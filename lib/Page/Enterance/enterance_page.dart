import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/GPS/location_service.dart';
import 'package:geo_app/Page/Enterance/Page/login_or_signup_page.dart';
import 'package:geo_app/Page/Enterance/enterance_header.dart';
import 'package:geo_app/components/image_avatar.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class EnterancePage extends HookWidget {
  const EnterancePage({Key? key}) : super(key: key);

  login(context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationService(),
        ),
        (r) => r.isFirst,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const EnteranceHeader(),
                const LoginOrSignUpPage(),
                Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageAvatar(
                          color: Colors.white,
                          fileName: 'assets/icon/google.png',
                          onTap: () => login(context),
                        ),
                        const SizedBox(width: 10),
                        ImageAvatar(
                          color: Colors.white,
                          fileName: 'assets/icon/facebook.png',
                          onTap: () => login(context),
                        ),
                      ],
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => login(context),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Continue as Guest",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}