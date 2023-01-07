import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Pages/community_page.dart';
import 'package:geo_app/Page/LandingPage/Pages/home_page.dart';
import 'package:geo_app/Page/LandingPage/Pages/profile_page.dart';
import 'package:geo_app/Page/LandingPage/home_page_with_bootom_appbar.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// TODO are you sure dialog
      onWillPop: () async => await Future.delayed(
        const Duration(milliseconds: 100),
        () => true,
      ),
      child: SafeArea(
        child: HomePageWithBottomAppBar(
          pages: [
            const HomePage(),
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
      ),
    );
  }
}
