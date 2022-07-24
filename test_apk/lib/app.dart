import 'package:flutter/material.dart';
import 'package:test_apk/routes.dart';
import 'package:test_apk/services/main_providers.dart';
import 'package:test_apk/splash.dart';
import 'package:test_apk/views/login_view.dart';
import 'core/core.dart';

import 'core/services/services.dart';

class WarmtePortaalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MaterialApp(home: Test());
    return CoreWidget(
      routes: routes,
      authView: const Login(),
      splashView: SplashView(),
      boundProviders: mainProviders,
      authService: FirebaseAuthService(),
    );
  }
}
