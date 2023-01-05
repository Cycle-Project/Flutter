import 'package:flutter/material.dart';
import 'package:geo_app/components/image_avatar.dart';

class LandingPageAppBar extends StatelessWidget {
  const LandingPageAppBar({
    super.key,
    required this.profileSrc,
  });
  final String profileSrc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: ImageAvatar(
                border: const ImageAvatarBorder(
                  thickness: 4,
                  borderRadius: 16,
                ),
                size: 64,
                fileName: profileSrc,
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Icon(
                Icons.logout_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
