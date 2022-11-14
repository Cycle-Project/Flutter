import 'package:flutter/material.dart';

class IconAvatar extends StatelessWidget {
  const IconAvatar({
    Key? key,
    this.size = 50,
    this.imageSize = 40,
    required this.fileName,
    required this.onTap,
  }) : super(key: key);

  final double size;
  final double imageSize;
  final String fileName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size),
        ),
        child: Center(
          child: SizedBox.square(
            dimension: imageSize,
            child: Image.asset(fileName),
          ),
        ),
      ),
    );
  }
}
