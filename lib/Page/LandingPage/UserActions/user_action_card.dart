import 'package:flutter/material.dart';

class UserActionCard extends StatelessWidget {
  const UserActionCard({
    Key? key,
    this.onTap,
    required this.color,
    required this.icon,
    required this.headerText,
    this.subText,
  }) : super(key: key);
  final Function(Color)? onTap;
  final Color color;
  final Widget Function(Color) icon;
  final String headerText;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!(color);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Row(
          children: [
            icon(color),
            const SizedBox(width: 16),
            Text(
              headerText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 26,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class CircledIcon extends StatelessWidget {
  const CircledIcon({
    super.key,
    required this.color,
    required this.iconData,
    required this.size,
    required this.padding,
  });
  final Color color;
  final IconData iconData;
  final double size;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: padding,
        child: Icon(
          iconData,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
