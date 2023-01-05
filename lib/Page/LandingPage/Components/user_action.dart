import 'package:flutter/material.dart';

class UserAction {
  final Color color;
  final IconData iconData;
  final String headerText;
  final Widget Function(Color) child;

  UserAction({
    required this.color,
    required this.iconData,
    required this.headerText,
    required this.child,
  });
}
