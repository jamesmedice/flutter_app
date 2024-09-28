import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'login.dart';
import 'login_interceptor.dart';
import 'terms_conditions.dart';

class AuthenticationWrapper extends StatelessWidget {
  final SharedPreferences _prefs;

  AuthenticationWrapper(this._prefs);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService(_prefs);

    return StreamBuilder<User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return LoginScreen(_prefs);
          } else {
            bool termsAccepted = _prefs.getBool('termsAccepted') ?? false;
            if (!termsAccepted) {
              return TermsAndConditionsScreen(_prefs);
            } else {
              return InterceptorPage(_prefs);
            }
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
