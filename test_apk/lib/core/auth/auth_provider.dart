import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test_apk/core/models/models.dart';

import 'package:test_apk/core/services/services.dart';

class AuthProvider with ChangeNotifier {
  String? email;
  String? password;
  String? rePassword;
  bool registerView = false;
  late AuthService _authService;
  String? _loginErrorMessage;
  String? _forgotPassErrorMessage;

  bool _showForgotPassword = false;
  bool _processing = false;

  final random = Random();
  final BuildContext context;

  AuthProvider(this.context) {
    _authService = Provider.of<AuthService>(context, listen: false);
  }

  bool get isShowForgotPassword => this._showForgotPassword;
  bool get isProcessing => this._processing;

  void setLoginErrorMessage(String arg) {
    this._loginErrorMessage = arg;
    notifyListeners();
  }

  void setShowForgotPassword(bool arg) {
    this._showForgotPassword = arg;
    notifyListeners();
  }

  void setProcessing(bool arg) {
    this._processing = arg;
    notifyListeners();
  }

  void setForgotPasswordErrorMessage(String arg) {
    this._forgotPassErrorMessage = arg;
    notifyListeners();
  }

  Future<void> login(String email, String passw) async {
    this.email = email;
    password = passw;

    await _signIn();
  }

  Future<void> _signIn() async {
    try {
      print(email);
      print(password);
      final AuthUserModel? _auth =
          await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("aquiiiiiiiii");
      print(_auth?.email ?? "sin email");
      notifyListeners();
    } catch (e) {
      //_jxSnackBar.show(Text(S.of(context).invalidEmailOrPasswordMsg));
      print(e.toString());

      setProcessing(false);
    }
  }

  double _calculateKey(int secretkey) {
    return secretkey * 3.14159 * DateTime.now().month;
  }
}
