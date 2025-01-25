import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/auth/auth_service.dart';
import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final authService = AuthService();
  bool isLoggedIn = false;
  bool get _isLoggedIn => isLoggedIn;

  AuthProvider() {
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    final userId = await authService.getLoggedInUser();
    isLoggedIn = userId != null;
    notifyListeners();
  }

  Future<void> logOut() async {
    await authService.signOut();
    isLoggedIn = false;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        isLoggedIn = true;
        notifyListeners();
      } else {
        throw Exception("Login failed");
      }
    } on AuthException catch (e) {
      throw Exception("Login error: $e");
    } catch (e) {
      throw Exception("Login error: $e");
    }
  }
}
