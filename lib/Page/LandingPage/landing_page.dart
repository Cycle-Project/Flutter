import 'package:flutter/material.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Page/LandingPage/Pages/community_page.dart';
import 'package:geo_app/Page/LandingPage/Pages/home_page.dart';
import 'package:geo_app/Page/LandingPage/Pages/profile_page.dart';
import 'package:geo_app/Page/LandingPage/home_page_with_bootom_appbar.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await showQuestionDialog(context, "Dou you want to exit?")) {
          await CacheManager.remove(tag: "user_id");
          await CacheManager.remove(tag: "user_token");
          return true;
        }
        return false;
      },
      child: HomePageWithBottomAppBar(
        pages: [
          HomePage(),
          const CommunityPage(),
          ProfilePage(),
        ],
        icons: const [
          Icons.home_outlined,
          Icons.search,
          Icons.person_outline,
        ],
        color: Colors.white54,
        selectedColor: Constants.primaryColor,
        backgroundColor: Constants.bluishGreyColor,
        bottomBarColor: Constants.darkBluishGreyColor,
      ),
    );
  }
}
