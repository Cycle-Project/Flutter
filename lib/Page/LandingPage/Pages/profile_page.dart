import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_image.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/qr_code.dart';
import 'package:geo_app/components/qr_code_scanner.dart';

class ProfilePage extends HookWidget with LandingPageInteractions {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserById(context),
      builder: (context, snap) {
        UserModel? user = snap.data;
        if (user == null || snap.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: Constants.primaryColor,
              backgroundColor: Constants.bluishGreyColor,
            ),
          );
        }
        return Column(
          children: [
            ProfileImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.name ?? "-",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    /* ${user.friends} */
                    "0 Connected",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            QRCode(
              qrSize: 150,
              qrPadding: 2,
              qrData: user.id!,
              qrBackgroundColor: Colors.transparent,
              qrForegroundColor: Constants.tealColor,
            ),
            const QrCodeScanner(),
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
        );
      },
    );
  }
}
