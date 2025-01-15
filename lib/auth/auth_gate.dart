import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pt_pick_up_platform/routes/routes.dart';
class AuthGate extends StatefulWidget {
  const AuthGate({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
    late Future<bool> isFirstTimeUserValue;

  Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTimeUser') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTimeUser', false);
    }
    return isFirstTime;
  }

  Future<bool> isSecondTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isSecondTime = prefs.getBool('isSecondTimeUser') ?? true;
    if (isSecondTime) {
      await prefs.setBool('isSecondTimeUser', false);
    }
    return isSecondTime;
  }

  @override
  void initState() {
    super.initState();
    isFirstTimeUserValue = isFirstTimeUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(

future: isFirstTimeUserValue,

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        if(snapshot.data == true) {
              //Navigate to the onboarding file
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, Routes.onBoarding);
          });
        }
        else {
          //Navigate to the home page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, Routes.home);
          });
        }
          
        return const Scaffold(
          body: Center(
            child: SizedBox(),
          ),
        );
      },
    );
  }
}
