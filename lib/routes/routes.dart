import 'package:flutter/material.dart';

import '../core/error/exceptions.dart';
import '../features/auth/screen/forget_pw_screen.dart';
import '../features/auth/screen/login_screen.dart';
import '../features/auth/screen/signup_screen.dart';
import '../features/home/screen/home_screen.dart';
import '../features/splash/screen/splash_screen.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPw = '/forgetPw';
  static const String home = '/home';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case forgetPw:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw RouteException('Route not found');
    }
  }
}
