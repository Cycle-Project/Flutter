import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  const MapCard({
    Key? key,
    this.text = "",
    required this.size,
    required this.prefix,
    required this.fadeTime,
    required this.backgroundColor,
  }) : super(key: key);
  final Widget prefix;
  final String text;
  final Size size;
  final int fadeTime;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
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
            child: Row(
              children: [
                prefix,
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
