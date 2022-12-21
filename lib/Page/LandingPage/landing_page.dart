import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_page.dart';
import 'package:geo_app/Page/LandingPage/Profile/profile_page.dart';
import 'package:geo_app/Page/LandingPage/map/map_page.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class LandingPage extends HookWidget {
  LandingPage({Key? key}) : super(key: key);

  final tabs = {
    "Discover": Icons.star,
    "Map": Icons.map,
    "Profile": Icons.person,
  };

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: tabs.length);
    final index = useState(0);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DiscoverPage(),
          MapPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black45,
        unselectedItemColor: Colors.grey[400]!,
        selectedItemColor: primaryColor,
        currentIndex: index.value,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          tabController.animateTo(value);
          index.value = value;
        },
        items: tabs.keys
            .map((key) => BottomNavigationBarItem(
                  icon: Icon(tabs[key]),
                  label: key,
                  backgroundColor: Colors.black54,
                ))
            .toList(),
      ),
    );
  }
}
