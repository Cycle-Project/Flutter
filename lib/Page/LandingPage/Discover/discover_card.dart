import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/image_avatar.dart';

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  ImageAvatar(
                    border: const ImageAvatarBorder(thickness: 4),
                    fileName: item["imagePath"]!,
                    onTap: () {},
                  ),
                  const SizedBox(width: 20),
                  Text(
                    item["username"]!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              item["name"]!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
