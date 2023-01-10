import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Page/Enterance/enterance_header.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/OnboardingPage/on_boarding_page.dart';

class SplashView extends HookWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    checkNewUser() async {
      await Future.delayed(const Duration(seconds: 1));
      await CacheManager.getSharedPref(tag: "newUser").then(
        (value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => (value ?? "true") == "true"
                ? OnboardingPage()
                : EnterancePage(),
          ),
          (r) => !r.isFirst,
        ),
      );
    }

    useEffect(() {
      checkNewUser();
      return null;
    }, []);

    return Scaffold(
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(2, 2, 1),
          child: const EnteranceHeader(showTitle: false),
        ),
      ),
    );
  }
}
