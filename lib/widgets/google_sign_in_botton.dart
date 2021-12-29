import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:test_flutter/services/app_provider.dart';

import '../services/auth_service.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: GoogleAuthButton(
            borderColor: Colors.transparent,
            height: 100,
            onPressed: () {
              context.read<FirebaseAuthService>().signInWithGoogle();
              context.read<AppHndl>().login(context);
            },
            darkMode: false,
            style: AuthButtonStyle.icon,
            width: 100),
      ),
    );
  }
}
