import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/services/app_provider.dart';
import 'package:test_flutter/views/home.dart';
import 'package:test_flutter/views/sign_in.dart';
import 'package:test_flutter/views/sign_up.dart';
import 'package:vrouter/vrouter.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppHndl _appHndl = Provider.of<AppHndl>(context);

    return VRouter(
      debugShowCheckedModeBanner: false,
      initialUrl: '/login',
      mode: VRouterMode.history,
      routes: [
        VWidget(path: '/login', widget: const SignInView()),
        VWidget(path: '/register', widget: const SignUp()),
        VGuard(
          beforeEnter: (vRedirector) async =>
              _appHndl.isLoggedIn ? null : vRedirector.to('/login'),
          stackedRoutes: [VWidget(path: '/home', widget: const HomeView())],
        ),
        // :_ is a path parameters named _
        // .+ is a regexp to match any path
        VRouteRedirector(path: ':_(.+)', redirectTo: '/home')
      ],
    );
  }
}
