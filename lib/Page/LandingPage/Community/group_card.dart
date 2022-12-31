import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Community/group_detail_page.dart';
import 'package:geo_app/components/image_avatar.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.color,
    required this.item,
  }) : super(key: key);

  final Color color;
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailPage(
              color: color,
              item: item,
            ),
          ),
        ),
        child: Row(
          children: [
            ImageAvatar(
              fileName: item["imagePath"]!,
              border: const ImageAvatarBorder(borderRadius: 12, thickness: 0),
              size: 60,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item["groupName"]!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${item["members"].length ?? 0} Members",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
