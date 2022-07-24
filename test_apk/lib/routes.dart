import 'package:flutter/material.dart';

import 'package:test_apk/views/home_page.dart';
import 'package:test_apk/views/login_view.dart';

import '../core/models/models.dart';

RouteModel homeRoute = RouteModel(
  title: (context) => Text("Home"),
  leading: Icons.home,
  routeName: '/home',
  view: (BuildContext context) => const HomePage(),
);

RouteModel test = RouteModel(
  title: (context) => Text("Login"),
  leading: Icons.home,
  routeName: '/login',
  view: (BuildContext context) => const Login(),
);

List<RouteModel> routes = [
  homeRoute,
  test,
];
