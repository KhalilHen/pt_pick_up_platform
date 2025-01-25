import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/auth/auth_provider.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:pt_pick_up_platform/pages/order_overview.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>;
    // final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Account',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome! sign up or log in to continue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
                  child: const Text("Sign up")),
              const SizedBox(
                height: 15,
              ),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                      side: const BorderSide(
                        color: Colors.deepOrange,
                      ),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text("Log in")),
            ],
          ),
        ),
      ),
    );
  }
}
