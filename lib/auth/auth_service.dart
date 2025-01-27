import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/auth/auth_provider.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class AuthService {
  Future<AuthResponse> signInWithEmailAndPassword({required String email, required String password}) async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> checkUser(String email, String password, GlobalKey<FormState> formKey, AuthProvider authProvider, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
           await authProvider.login(email, password);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        // await signInWithEmailAndPassword(email: email, password: password).then((value) {
        //     Navigator.of(formKey.currentContext!).pushReplacement(
        //       MaterialPageRoute(builder: (context) => HomePage()),
        //     );
        //   }).catchError((e) {
        //     ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
        //   });
        // } catch (e) {
        //   ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
      } catch (e) {
        ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<String?> getLoggedInUser() async {
    final session = supabase.auth.currentSession;
    final User = session?.user.id;

    if (User == null) {
      print('No authenticated user found.');
      return null;
    }
    return User;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(password: password, email: email);
      if (response.user != null) {
        final userId = response.user!.id;
        final insertResponse = await supabase.from('persons').insert({
          'id': userId,
          'email': email,
        });

        if (insertResponse.error != null) {
          throw Exception("database error: ${insertResponse.error!.message}");
        }
        print("User create");
      }

      return response;
    } catch (e) {}
  }

  Future<bool> isEmailAvailable(String email) async {
    try {
      final response = await supabase.from('persons').select().match({'email': email}).maybeSingle();

      return response == null;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
    return emailRegex.hasMatch(email);
  }
}
