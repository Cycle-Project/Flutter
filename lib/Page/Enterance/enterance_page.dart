import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Enterance/Page/login_or_signup_page.dart';
import 'package:geo_app/Page/Enterance/enterance_header.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';
import 'package:geo_app/components/icon_avatar.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class EnterancePage extends HookWidget with EnteranceInteraction {
  EnterancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bluishGreyColor,
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
                LoginOrSignUpPage(),
                Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconAvatar(
                          fileName: 'assets/icon/google.png',
                          imageSize: 32,
                          onTap: () async => await googleLogin(context),
                        ),
                      ],
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => guestLogin(context),
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
