import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
    this.size = 50,
    this.color = Colors.grey,
    this.onTap,
    this.border,
    required this.fileName,
  }) : super(key: key);

  final double size;
  final Color color;
  final String fileName;
  final Function()? onTap;
  final ImageAvatarBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: border?.color ?? Colors.white,
            borderRadius: BorderRadius.circular(border?.borderRadius ?? size),
          ),
          child: Container(
            margin: EdgeInsets.all(border?.thickness ?? 0),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadius.circular((border?.borderRadius ?? size) - 4),
              image: DecorationImage(
                image: AssetImage(fileName),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageAvatarBorder {
  final double? thickness;
  final double? borderRadius;
  final Color? color;

  const ImageAvatarBorder({
    this.thickness,
    this.borderRadius,
    this.color,
  });
}
