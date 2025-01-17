import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/auth/auth_gate.dart';
import 'package:pt_pick_up_platform/onboarding/start_page.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:pt_pick_up_platform/pages/login.dart';

class Routes {
  static const String onBoarding = '/onboarding';
  static const String authGate = '/auth_gate';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/sign_up';
   


   static Map<String, WidgetBuilder> returnRoutes = {
    onBoarding: (context) => Introduction(),
    authGate: (context) => AuthGate(),
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    // signUp: (context) => SignUp(),
};

}
