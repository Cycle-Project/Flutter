import 'package:flutter/material.dart';

class SpecialCard extends StatelessWidget {
  const SpecialCard({
    Key? key,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.grey,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
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
      ),
    );
  }
}
