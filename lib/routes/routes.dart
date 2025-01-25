import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/auth/auth_gate.dart';
import 'package:pt_pick_up_platform/onboarding/start_page.dart';
import 'package:pt_pick_up_platform/pages/account_page.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:pt_pick_up_platform/pages/login.dart';
import 'package:pt_pick_up_platform/pages/order_overview.dart';
import 'package:pt_pick_up_platform/pages/sign_up.dart';

class Routes {
  static const String onBoarding = '/onboarding';
  static const String authGate = '/auth_gate';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String account = "/account";
  static const String order_overview = "/order-overview";

  static Map<String, WidgetBuilder> returnRoutes = {
    onBoarding: (context) => Introduction(),
    authGate: (context) => AuthGate(),
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    signUp: (context) => SignUpPage(),
    account: (context) => AccountPage(),
    order_overview : (context) => OrdersPage()

  };
}
