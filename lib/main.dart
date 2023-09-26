import 'package:Growth/signup/SignupScreen.dart';
import 'package:Growth/signup/UserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SVGWidgets.dart';
import 'MaterialColorGenerator.dart';
import 'ProfilePage.dart';
import 'Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true));
}

final MaterialColor customGreenAccent =
    MaterialColorGenerator.from(const Color(0xFF69F0AE));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase().then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ], child: const GrowthApp()));
  });
}

class GrowthApp extends StatelessWidget {
  const GrowthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Growth App',
      home: const SignupScreen(),
      theme: ThemeGrowth.themeData,
    );
  }
}

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;
  final GlobalKey _childKey = GlobalKey();
  double _bottomBarHeight = 0;

  double MARGIN_TOP_SESSION_TRACKER = 25.0;
  double HEIGHT_HEADER_SESSION_TRACKER = 70;

  var END_VALUE_ANIMATION = 0.08;

  double get _childHeight {
    final RenderBox renderBox =
    _childKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  bool _isBottomBarVisible = true;
  bool _isSessionTrackerVisible = false;
  bool _isRPEkeyboardVisible = false;
  late Function(String text) _callback;

  void _toggleSessionTrackerVisibility() {
    setState(() {
      _isSessionTrackerVisible = !_isSessionTrackerVisible;
      if (_isSessionTrackerVisible == false) {
        _isBottomBarVisible = true;
        _animationController.reverse();
      }
    });
  }

  void _handleEvent() {
    // Perform the desired action when the event is received
    // Call a method on the main app or update its state
    if (_isSessionTrackerVisible) {
      _toggleSessionTrackerVisibility();
    }

    _toggleSessionTrackerVisibility();
    _animationController.fling();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 1.0, end: END_VALUE_ANIMATION)
        .animate(_animationController);

    _animationController.addListener(() {
      if (_animation.value == END_VALUE_ANIMATION) {
        setState(() {
          _isBottomBarVisible = false;
        });
      } else if (_animation.value > 1.0 - 0.1) {
        setState(() {
          _isBottomBarVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Specify the callback function to handle the back button press
        onWillPop: () async {
          // Your custom logic goes here
          // Return true to allow navigating back, or false to prevent it
          bool allowBackNavigation = false;

          if (_isRPEkeyboardVisible) {
            setState(() {
              _isRPEkeyboardVisible = false;
            });
          } else {
            allowBackNavigation = true;
          }

          return allowBackNavigation;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: GestureDetector(
                onLongPress: () {
                  _toggleSessionTrackerVisibility();
                },
                child: _bottomBarHeight == 0
                    ? _buildBottomNavigationBar()
                    : AnimatedContainer(
                    height: _isBottomBarVisible ? _bottomBarHeight : 0,
                    duration: const Duration(milliseconds: 0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _isBottomBarVisible ? 1.0 : 0.0,
                      child: _buildBottomNavigationBar(),
                    ))),
            body: Stack(
              children: [
                IndexedStack(
                  index: _tabIndex,
                  children: [
                    const ProfilePage(),
                    const ProfilePage(),
                    const ProfilePage(),
                    const ProfilePage(),
                  ],
                ),
              ],
            )));
  }

  _buildBottomNavigationBar() {
    return Builder(builder: (BuildContext context) {
      final bottomBarNavigation = BottomNavigationBar(
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: ico_exercises,
              label: 'Exercises',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: ico_explore,
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: ico_workout,
              label: 'My Plans',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: ico_history,
              label: 'History',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: ico_profile,
              label: 'Profile',
            ),
          ],
          currentIndex: _tabIndex,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.greenAccent,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final bottomNavBarHeight = renderBox.size.height;

        if (bottomNavBarHeight > 0) {
          _bottomBarHeight = bottomNavBarHeight;
        }
      });
      return bottomBarNavigation;
    });
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (!_animationController.isAnimating) {
      final double change = details.primaryDelta! / _childHeight;
      final newValue = _animationController.value - change;
      if (newValue != _animationController.value) {
        _animationController.value = newValue;
      }
    }
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (!_animationController.isAnimating) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: flingVelocity);
      }
    }
  }

}