import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    required this.title,
    this.color,
  });
  final String title;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color ?? Colors.black,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: color ?? Colors.black,
          ),
        ],
      ),
    );
  }
}
