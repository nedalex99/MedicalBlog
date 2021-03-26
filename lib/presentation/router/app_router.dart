import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/login_screen/login_screen.dart';
import 'package:medical_blog/presentation/screens/splashscreen/splashscreen.dart';
import 'package:medical_blog/presentation/screens/tutorial/tutorial_page_view.dart';
import 'package:medical_blog/presentation/screens/tutorial/tutorial_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/tutorial':
        return MaterialPageRoute(
          builder: (_) => TutorialPageView(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return null;
    }
  }
}
