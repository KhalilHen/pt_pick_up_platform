import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/onboarding/pages/introduction.dart';
import 'package:pt_pick_up_platform/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      // home: const AuthGate(),
      home: IntroScreenDemo(),
      routes: {
        // Routes.onBoarding: (context) => OnBoarding(),
        // Routes.authGate: (context) => AuthGate(),
        // Routes.home: (context) => Home(),
        // Routes.signUp: (context) => SignUp(),
        // Routes.login: (context) => Login(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
