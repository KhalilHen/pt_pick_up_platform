import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class AuthService {

   

   Future<AuthResponse> signInWithEmailAndPassword({required String email, required String password }) async {


    return await supabase.auth.signInWithPassword(email: email, password: password);
   }   
}