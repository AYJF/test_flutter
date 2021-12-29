import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class RegisterModel extends ChangeNotifier {
  RegisterModel(this.locator);

  final Locator locator;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerUser(String email, String passw, String name) async {
    _setLoading();
    await locator<FirebaseAuthService>()
        .registerUser(email: email, password: passw, name: name);
    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
