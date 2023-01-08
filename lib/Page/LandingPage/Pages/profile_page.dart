import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_image.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_sublist.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/components/qr_code.dart';
import 'package:geo_app/components/qr_code_scanner.dart';

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
          ColoredBox(
            color: Constants.darkBluishGreyColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                ProfileImage(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.value?.name ?? "-",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        /* ${user.friends} */
                        "0 Friends",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.darkBluishGreyColor.withOpacity(.6),
            ),
            child: Column(
              children: [
                ProfileWidget(
                  name: "Routes",
                  prefixIcon: Icons.route,
                  onTap: () {
                    List list = List.generate(20, (i) => "Route ${i + 1}");
                    if (list.isNotEmpty) {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (_, __, ___) => ProfileSubList(
                          list: list,
                          title: "Routes",
                        ),
                      );
                    }
                  },
                ),
                ProfileWidget(
                  name: "Favorites",
                  prefixIcon: Icons.favorite,
                  onTap: () {
                    List list = List.generate(20, (i) => "Favorite ${i + 1}");
                    if (list.isNotEmpty) {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (_, __, ___) => ProfileSubList(
                          list: list,
                          title: "Favorites",
                        ),
                      );
                    }
                  },
                ),
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
                ProfileWidget(
                  name: "QR Code",
                  prefixIcon: Icons.qr_code_scanner,
                  onTap: () {
                    final size = MediaQuery.of(context).size;
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Constants.darkBluishGreyColor,
                      builder: (_) => SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: size.width * .1),
                            QRCode(
                              qrSize: size.width * .9,
                              qrPadding: 2,
                              qrData: user.value?.id ?? "-1",
                              qrBackgroundColor: Colors.transparent,
                              qrForegroundColor: Constants.tealColor,
                            ),
                            ProfileWidget(
                              name: "Scan",
                              prefixIcon: Icons.qr_code_scanner_rounded,
                              onTap: () => showQrCodeScanner(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
