import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  const MapCard({
    Key? key,
    required this.size,
    required this.child,
    required this.fadeTime,
    required this.backgroundColor,
  }) : super(key: key);
  final Size size;
  final int fadeTime;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: Duration(milliseconds: fadeTime),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor,
        ),
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: child,
        ),
      ),
    );
  }
}
