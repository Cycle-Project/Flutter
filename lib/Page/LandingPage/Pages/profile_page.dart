import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_favorites.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_qr.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_routes.dart';
import 'package:geo_app/Page/LandingPage/Profile/topbar.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';

class ProfilePage extends HookWidget with LandingPageInteractions {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useState<UserModel?>(null);
    final isLoading = useState(true);

    useMemoized(() {
      Future.microtask(() async {
        user.value = await getUserById(context);
        isLoading.value = false;
      });
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
              name: "SignUp",
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
          TopBar(username: user.value?.name ?? "-"),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
            ),
            child: Column(
              children: const [
                ProfileRoutes(),
                ProfileFavorites(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
            ),
            child: Column(
              children: [
                ProfileQR(userid: user.value?.id ?? "-1"),
                ProfileWidget(
                  name: "Friends",
                  prefixIcon: Icons.group,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
            ),
            child: ProfileWidget(
              name: "Logout",
              color: Colors.red,
              prefixIcon: Icons.logout_rounded,
              onTap: () async {
                if (await showQuestionDialog(
                    context, "Dou you want to exit?")) {
                  await CacheManager.remove(tag: "user_id");
                  await CacheManager.remove(tag: "user_token");
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
