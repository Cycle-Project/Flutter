import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_actions.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_progress.dart';
import 'package:geo_app/Page/LandingPage/landing_page_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final String profileSrc = "assets/icon/Avatar.png";
  final double progressOfKms = 16362;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          LandingPageAppBar(profileSrc: profileSrc),
          UserProgress(progressOfKms: progressOfKms),
          const UserActions(),
        ],
      ),
    );
  }
}
