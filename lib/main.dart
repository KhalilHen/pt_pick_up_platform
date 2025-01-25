import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/auth/auth_gate.dart';
import 'package:pt_pick_up_platform/auth/auth_provider.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/onboarding/pages/introduction.dart';
import 'package:pt_pick_up_platform/onboarding/start_page.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:pt_pick_up_platform/pages/login.dart';
import 'package:pt_pick_up_platform/pages/sign_up.dart';
import 'package:pt_pick_up_platform/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //To force user to use only portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<OrderController>(
        create: (_) => OrderController(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Primary text on light background
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            //Secondary text/body  on light background
            bodyMedium: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      debugShowCheckedModeBanner: false,

      // home: const AuthGate(),
      // home: Introduction(),
      // home: Introduction(), //Easier for making the homepage
      home: AuthGate(),
      // home: SignUpPage(),
      // home: OrderStatusScreen(),
      // home: LoginPage(),
      routes: {
        Routes.onBoarding: (context) => Introduction(),
        Routes.authGate: (context) => AuthGate(),
        Routes.home: (context) => HomePage(),
        Routes.signUp: (context) => SignUpPage(),
        Routes.login: (context) => LoginPage(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
