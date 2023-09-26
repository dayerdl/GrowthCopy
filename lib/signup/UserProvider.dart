import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final authProvider = GoogleAuthProvider();
      authProvider
        ..addScope('email')
        ..addScope('profile');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Check if the email is already registered with a different provider
      final email = googleUser.email;
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (methods.isEmpty) {
        // User doesn't exist, proceed with account creation
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(googleCredential);
        setUser(authResult.user);
      } else {
        // User exists with a different provider, link the accounts
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(googleCredential);
        final User existingUser = authResult.user!;

        await existingUser.linkWithCredential(googleCredential);
        setUser(existingUser);
      }
    } catch (error) {
      print(error.toString());
    }
  }


  Future<void> signInWithFacebook() async {
    try {
      final LoginResult facebookUser = await FacebookAuth.instance.login();

      if (facebookUser.status != LoginStatus.success) return;

      final OAuthCredential facebookCredential =
          FacebookAuthProvider.credential(
        facebookUser.accessToken!.token,
      );
      // Check if the email is already registered with a different provider
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookCredential);

      final email = userCredential.user?.email;
      if (email == null) {
        // Handle the case where the Facebook login didn't provide an email
        return;
      }

      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (methods.isEmpty) {
        // User doesn't exist, proceed with account creation
        setUser(userCredential.user);
      } else {
        // User exists with a different provider, link the accounts
        final User existingUser = userCredential.user!;
        await existingUser.linkWithCredential(facebookCredential);
        setUser(existingUser);
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == "account-exists-with-different-credential") {
          var authMethods = await FirebaseAuth.instance
              .fetchSignInMethodsForEmail(error.email!);
          print(authMethods.first);
        }
      }
      print(error.toString());
    }
  }


  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    setUser(null);
  }

}
