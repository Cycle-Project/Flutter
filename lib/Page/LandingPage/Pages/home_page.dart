import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_actions.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_progress.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final double progressOfKms = 16362;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserProgress(progressOfKms: progressOfKms),
        const UserActions(),
      ],
    );
  }
}
