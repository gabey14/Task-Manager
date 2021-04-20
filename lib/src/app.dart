import 'package:flutter/material.dart';
import 'package:todo/app/landing_page.dart';

import 'package:splashscreen/splashscreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image.asset('images/launch_image2.png'),
      seconds: 4,
      photoSize: 60.0,
      backgroundColor: Colors.white,
      navigateAfterSeconds: new LandingPage(),
      loaderColor: Colors.blue,
      pageRoute: _createRoute(),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LandingPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
