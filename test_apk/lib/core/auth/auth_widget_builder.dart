import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../models/models.dart';
import '../services/services.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final bool authDisabled;
  final List<RouteModel> routes;
  final List<SingleChildWidget> boundProviders;
  final Widget Function(BuildContext, AsyncSnapshot<AuthUserModel?>) builder;

  const AuthWidgetBuilder({
    Key? key,
    required this.routes,
    required this.builder,
    this.authDisabled = false,
    this.boundProviders = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<AuthUserModel?>(
      stream: authService.onAuthChanged,
      builder: (_, snapshot) {
        AuthUserModel? user =
            authDisabled ? AuthUserModel.empty : snapshot.data;
        if (user != null) {
          // User is logged in.

          print("aqui es true");
          return MultiProvider(
            providers: [
              Provider<AuthUserModel>.value(value: user),
              // NOTE: Any other user-bound providers here can be added here
              ...boundProviders,
            ],
            child: builder(context, snapshot),
          );
        }
        print("aqui es false");
        return builder(context, snapshot);
      },
    );
  }
}
