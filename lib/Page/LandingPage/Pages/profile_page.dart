import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/Profile/others_profile.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_favorites.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_friends.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_qr.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_routes.dart';
import 'package:geo_app/Page/LandingPage/Profile/topbar.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/main.dart';

class ProfilePage extends HookWidget with LandingPageInteractions {
  ProfilePage({
    Key? key,
    this.profiledUser,
  }) : super(key: key);
  final UserModel? profiledUser;

  @override
  Widget build(BuildContext context) {
    final user = useState<UserModel?>(null);
    final currentUser = useState<UserModel?>(null);
    final isLoading = useState(true);

    final boxShadow = [
      BoxShadow(
        color: Constants.generateMaterialColor(
          Constants.darkBluishGreyColor.withOpacity(.6),
        ).shade400,
        spreadRadius: 1,
        blurRadius: 3,
        offset: const Offset(0, 3),
      )
    ];

    useMemoized(() {
      if (profiledUser == null) {
        user.value = applicationUserModel;
        isLoading.value = false;
      } else {
        user.value = profiledUser;
        currentUser.value = applicationUserModel;
        isLoading.value = false;
      }
      return null;
    }, []);

    if (isLoading.value) {
      return Center(
        child: CircularProgressIndicator(
          color: Constants.darkBluishGreyColor,
          backgroundColor: Constants.darkBluishGreyColor.withOpacity(.2),
        ),
      );
    }
    if (user.value == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
            ),
            child: ProfileWidget(
              name: "SignUp / Login",
              prefixIcon: Icons.group,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(
            username: user.value?.name ?? "-",
            child: profiledUser == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OthersProfile(
                      profiledUser: profiledUser!,
                      currentUser: currentUser.value!,
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
              boxShadow: boxShadow,
            ),
            child: Column(
              children: const [
                ProfileRoutes(),
                ProfileFavorites(),
              ],
            ),
          ),
          if (profiledUser == null) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Constants.darkBluishGreyColor.withOpacity(.6),
                boxShadow: boxShadow,
              ),
              child: Column(
                children: [
                  ProfileQR(userid: user.value?.id ?? "-1"),
                  ProfileFriends(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Constants.darkBluishGreyColor.withOpacity(.6),
                boxShadow: boxShadow,
              ),
              child: ProfileWidget(
                name: "Logout",
                color: Colors.red,
                prefixIcon: Icons.logout_rounded,
                onTap: () async => await exitFromApp(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
