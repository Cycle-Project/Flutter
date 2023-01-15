import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_image.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.username,
    required this.friendCount,
    this.child,
    this.topWidget,
  }) : super(key: key);
  final String username;
  final int friendCount;
  final Widget? child, topWidget;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Constants.darkBluishGreyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60, child: topWidget),
          ProfileImage(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$friendCount Friends",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
