import 'package:chatify/services/navigation_service.dart';
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
  FirebaseAuth _auth;
  AuthStatus status;
  FirebaseUser user;

  static AuthProvider instance = AuthProvider();

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
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("ログインに成功しました");
      // TODO Update LastSeen Time
      NavigationService.instance.navigationToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError("ログインに失敗しました");
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);

      SnackBarService.instance.showSnackBarSuccess("会員登録に成功しました");
      NavigationService.instance.goBack();
      NavigationService.instance.navigationToReplacement("home");
    } catch (e) {
      print(e);
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError("会員登録に失敗しました");
    }
    notifyListeners();
  }
}
