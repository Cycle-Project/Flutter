// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_actions.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_progress.dart';
import 'package:geo_app/Page/LandingPage/landing_page_appbar.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';

class HomePage extends HookWidget with LandingPageInteractions {
  HomePage({super.key});
  final double progressOfKms = 16362;

  @override
  Widget build(BuildContext context) {
    final user = useState<UserModel?>(null);

    useMemoized(() {
      Future.microtask(() async => user.value = await getUserById(context));
      return null;
    }, []);

    return Column(
      children: [
        const LandingPageAppBar(),
        if (user.value != null)
          UserProgress(progressOfKms: progressOfKms)
        else
          const SizedBox(height: 16),
        const UserActions(),
      ],
    );
  }
}
