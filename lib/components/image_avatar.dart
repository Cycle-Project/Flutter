import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
    this.size = 50,
    this.color = Colors.grey,
    this.haveBorder = false,
    required this.fileName,
    required this.onTap,
  }) : super(key: key);

  final double size;
  final Color color;
  final bool haveBorder;
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
        child: Container(
          margin: haveBorder ? const EdgeInsets.all(4) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size),
            image: DecorationImage(image: AssetImage(fileName)),
          ),
        ),
      ),
    );
  }
}
