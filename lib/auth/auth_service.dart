import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class AuthService {
  Future<AuthResponse> signInWithEmailAndPassword({required String email, required String password}) async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> checkUser(String email, String password, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        await signInWithEmailAndPassword(email: email, password: password).then((value) {
          Navigator.of(formKey.currentContext!).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }).catchError((e) {
          ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
        });
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
}
