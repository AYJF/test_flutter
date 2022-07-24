import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
/// Note: this class used to be called [LandingPage].
class AuthWidget extends StatelessWidget {
  final Widget authView;
  final Widget splashView;
  final AsyncSnapshot<AuthUserModel?> userSnapshot;

  const AuthWidget({
    Key? key,
    required this.authView,
    required this.splashView,
    required this.userSnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (authView == null) return splashView;

    if (userSnapshot.connectionState == ConnectionState.active) {
      print("Aqui");
      print(userSnapshot.data);
      print(userSnapshot.hasData);
      return userSnapshot.hasData ? splashView : authView;
    }

    return Scaffold(body: Center(child: LoadingProgress()));
  }
}
