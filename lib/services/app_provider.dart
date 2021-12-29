import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class AppHndl with ChangeNotifier {
  bool isLoggedIn = false;

  void login(BuildContext context) {
    isLoggedIn = true;
    context.vRouter.to('/home');
  }

  void logout(BuildContext context) {
    isLoggedIn = false;
    context.vRouter.to('/login');
  }
}
