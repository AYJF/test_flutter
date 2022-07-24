import 'package:flutter/material.dart';

class RouteModel {
  final IconData leading;
  final String routeName;
  final WidgetBuilder view;
  final WidgetBuilder title;
  final List<RouteModel> subMenu;

  const RouteModel({
    required this.title,
    required this.leading,
    required this.view,
    required this.routeName,
    this.subMenu = const [],
  });

  @override
  List<Object> get props => [routeName];
}
