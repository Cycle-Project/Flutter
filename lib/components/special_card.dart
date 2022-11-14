import 'package:flutter/material.dart';

class SpecialCard extends StatelessWidget {
  const SpecialCard({
    Key? key,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.grey,
    required this.child,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(2.5, 3),
          )
        ],
      ),
      child: child,
    );
  }
}
