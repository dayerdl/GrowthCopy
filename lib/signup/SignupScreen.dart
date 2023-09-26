import 'package:Growth/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'UserProvider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    print(">>>>>>>user is ${user?.email}");
    if (user != null) {
      return const MainAppPage();
    } else {
      return
        Scaffold(
          body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image at the top
              Container(
                color: Colors.black,
                child: SvgPicture.asset(
                  'images/transpartent_logo.svg',
                  height: 220,
                  color: Colors.white,
                ),
              ),
              // Text below the image
              const Text(
                'Growth',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'Put your gains on track 💪',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 85,
                    ),
                    // Sign-up buttons
                    GestureDetector(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            // Set the border color as needed
                            width: 1.0, // Set the border width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              20.0), // Set border radius as needed
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 27,
                            ),
                            Image.asset(
                              'assets/icon/google_icon.png',
                              width: 26,
                              height: 26,
                            ),
                            Container(
                              width: 16,
                            ),
                            const Text(
                              "Continue with Google",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Container(
                              width: 48,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        userProvider.signInWithGoogle();
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          // Set the border color as needed
                          width: 1.0, // Set the border width as needed
                        ),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set border radius as needed
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 26,
                          ),
                          Image.asset(
                            'assets/icon/apple_logo.png',
                            width: 26,
                            height: 26,
                          ),
                          Container(
                            width: 20,
                          ),
                          const Text(
                            "Continue with Apple",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Container(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            // Set the border color as needed
                            width: 1.0, // Set the border width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              20.0), // Set border radius as needed
                        ),
                        child: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 28,
                              ),
                              Image.asset(
                                'assets/icon/facebook_icon.png',
                                width: 26,
                                height: 26,
                              ),
                              Container(
                                width: 16,
                              ),
                              const Text(
                                "Continue with Facebook",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                width: 28,
                              ),
                            ],
                          ),
                          onTap: () {
                            userProvider.signInWithFacebook();
                          },
                        )),
                    // Text with a link to login
                    Container(
                      height: 30,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                      // Add logic to navigate to the login screen when this link is tapped
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Implement navigation to the login screen here
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }
  }
}
