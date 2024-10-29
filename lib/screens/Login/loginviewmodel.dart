import 'package:bharatposters0/utils/authentication/authentication.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final Authentication _authentication = Authentication();
  bool _isSigningIn = false;

  bool get isSigningIn => _isSigningIn;

  Future<void> signInWithGoogle(BuildContext context) async {
    _isSigningIn = true;
    notifyListeners();

    await _authentication.signInWithGoogle(context);

    _isSigningIn = false;
    notifyListeners();
  }

  Future<bool> loginUserWithGoogle(String idToken) async {
    return await _authentication.loginUserWithGoogle(idToken);
  }

  // Future<void> saveUserData(Map<String, dynamic> userData) async {
  //   await _authentication.saveUserData(userData);
  // }
}
