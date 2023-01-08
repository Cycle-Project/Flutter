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
    final isLoading = useState(true);
    final newUser = useState(false);
    checkNewUser() async {
      await Future.delayed(const Duration(seconds: 1));
      newUser.value =
          (await CacheManager.getSharedPref(tag: "newUser") ?? "true") ==
              "true";
      isLoading.value = false;
    }

    useEffect(() {
      checkNewUser();
      return null;
    }, []);
    return isLoading.value
        ? Scaffold(
            body: Center(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(2, 2, 1),
                child: const EnteranceHeader(showTitle: false),
              ),
            ),
          )
        : newUser.value
            ? OnboardingPage()
            : EnterancePage();
  }
}
