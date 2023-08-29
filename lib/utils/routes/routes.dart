import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_screen.dart';
import 'package:mvvm/view/signup_screen.dart';

import '../../view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
