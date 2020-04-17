import 'package:chatify/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  static AuthProvider instance = AuthProvider();
  FirebaseAuth _auth;
  AuthStatus status;
  FirebaseUser user;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      //Navigate to HomePage
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("ログインしました");
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError("ログインに失敗しました");
    }
    notifyListeners();
  }
}
