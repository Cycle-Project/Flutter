import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_actions.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_progress.dart';
import 'package:geo_app/Page/LandingPage/landing_page_appbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
  final String profileSrc = "assets/icon/Avatar.png";
  final double progressOfKms = 16362;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LandingPageAppBar(profileSrc: profileSrc),
            UserProgress(progressOfKms: progressOfKms),
            const SizedBox(height: 4),
            const Expanded(child: UserActions()),
          ],
        ),
      ),
    );
  }
}
