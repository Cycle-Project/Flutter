import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = useState("Username");
    final followers = useState(515);
    return Scaffold(
      backgroundColor: Constants.generateMaterialColor(
        Constants.darkBluishGreyColor,
      ).shade400,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, size: 36),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, size: 32),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text("Coming Soon..."),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          SizedBox.square(
            dimension: 120,
            child: Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                //image: DecorationImage(image: AssetImage("")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  username.value,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${followers.value} Followers",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          ProfileWidget(
            name: "Routes",
            prefixIcon: Icons.route,
            list: List.generate(20, (i) => "Route ${i + 1}"),
          ),
          ProfileWidget(
            name: "Favorites",
            prefixIcon: Icons.favorite,
            list: List.generate(20, (i) => "Favorites ${i + 1}"),
          ),
        ],
      ),
    );
  }
}
