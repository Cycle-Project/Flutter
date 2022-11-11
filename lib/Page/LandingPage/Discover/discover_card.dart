import 'package:flutter/material.dart';
import 'package:geo_app/components/image_avatar.dart';
import 'package:like_button/like_button.dart';

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300]!,
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 400,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 360,
                color: Colors.amber.withOpacity(.1),
              ),
              SizedBox(
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            ImageAvatar(
                              haveBorder: true,
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
              ),
            ],
          ),
          Row(
            children: [
              LikeButton(
                size: 40,
                isLiked: false,
                likeCount: 999,
                likeBuilder: (isLiked) => Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                likeCountPadding: const EdgeInsets.only(left: 2),
                countBuilder: (likeCount, isLiked, text) => Text(
                  text,
                  style: TextStyle(
                    color: isLiked ? Colors.black : Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //onTap: (isLiked) { request },
              ),
              LikeButton(
                size: 40,
                likeCount: 999,
                likeBuilder: (isLiked) => const Icon(
                  Icons.messenger_outlined,
                  color: Colors.grey,
                ),
                likeCountPadding: const EdgeInsets.only(left: 2),
                countBuilder: (likeCount, isLiked, text) => Text(
                  text,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //onTap: (isLiked) { request },
              ),
            ].map((e) => Expanded(child: Center(child: e))).toList(),
          ),
        ],
      ),
    );
  }
}
