import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.color,
  });
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
            size: 24,
            color: color ?? Colors.black,
          ),
        ],
      ),
    );
  }
}
