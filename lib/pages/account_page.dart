import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/auth/auth_provider.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:pt_pick_up_platform/pages/login.dart';
import 'package:pt_pick_up_platform/pages/order_overview.dart';
import 'package:pt_pick_up_platform/pages/sign_up.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (!authProvider.isLoggedIn) {
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
                    child: const Text("Sign up")),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton(
                    onPressed: () {
                      // Navigator.push
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Account",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, User",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ), //TODO: Replace with user name

                      Text(
                        "Manage your account",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Account settings",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              settingsItem(context, icon: Icons.person_outline, title: 'Personal Information'),
              settingsItem(context, icon: Icons.lock_outline, title: 'Change password'),
              settingsItem(context, icon: Icons.notifications_outlined, title: "Notifications"),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      authProvider.logOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text("Log out")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
