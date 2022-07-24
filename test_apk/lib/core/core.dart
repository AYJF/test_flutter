import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_apk/core/widgets/loading_progress.dart';
import 'package:test_apk/views/login_view.dart';
import 'package:vrouter/vrouter.dart';

import 'auth/auth.dart';
import 'models/models.dart';
import 'services/services.dart';

class CoreWidget extends StatelessWidget {
  final Widget? authView;
  final Widget splashView;
  final AuthService authService;
  final List<RouteModel> routes;

  // NOTE: Bound providers are injected only when the user logs in.
  final List<SingleChildWidget> boundProviders;

  const CoreWidget({
    Key? key,
    required this.routes,
    required this.splashView,
    required this.authView,
    required this.authService,
    this.boundProviders = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MockAuthService for offline.
    // user: admin@test.com
    // password: admin

    return MultiProvider(
      providers: [
        Provider<AuthService>.value(value: authService),
      ],
      child: AuthWidgetBuilder(
        routes: routes,
        boundProviders: boundProviders,
        authDisabled: authView == null,
        builder: (context, AsyncSnapshot<AuthUserModel?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            return VRouter(
              initialUrl: userSnapshot.hasData ? '/splash' : '/auth',
              routes: [
                VWidget(path: '/auth', widget: authView!),
                VWidget(path: '/splash', widget: splashView),
                VWidget(path: '/login', widget: const Login())
              ],
              // routes: _createRoutes(),
              title: "App Name",
              theme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.dark,
                primaryColor: Colors.lightBlue[800],

                // Define the default `TextTheme`. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
                textTheme: const TextTheme(
                  headline1:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  headline6:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                ),
              ),
              debugShowCheckedModeBanner: false,
              // home: AuthWidget(
              //   authView: authView!,
              //   splashView: splashView,
              //   userSnapshot: userSnapshot,
              // ),
            );
          }

          return Scaffold(body: Center(child: LoadingProgress()));
        },
      ),
    );
  }

  Map<String, WidgetBuilder> _createRoutes() {
    final Map<String, WidgetBuilder> _routes = {};
    for (RouteModel route in routes) {
      route.subMenu.forEach((subMenu) {
        _routes[subMenu.routeName] = subMenu.view;
      });
      if (route.routeName != null) {
        _routes[route.routeName] = route.view;
      }
    }
    return _routes;
  }
}

class _ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          ),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: _FailedMessage(),
    );
  }
}

class _FailedMessage extends StatelessWidget {
  const _FailedMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(26.0),
          child: Text(
            "Error",
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Image.asset(
          'assets/images/error.png',
          height: 210,
        ),
      ],
    );
  }
}
