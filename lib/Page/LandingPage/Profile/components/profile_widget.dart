import 'package:flutter/material.dart';
import 'package:geo_app/components/header.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.name,
    required this.prefixIcon,
    required this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  final Color color;
  final String name;
  final IconData? prefixIcon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(prefixIcon, color: color),
              Header(title: name, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
