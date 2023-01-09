import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/header.dart';
import 'package:geo_app/components/qr_code.dart';
import 'package:geo_app/components/qr_code_scanner.dart';

class ProfileQR extends StatelessWidget {
  const ProfileQR({super.key, required this.userid});
  final String userid;

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      name: "QR Code",
      prefixIcon: Icons.qr_code_scanner,
      onTap: () {
        final size = MediaQuery.of(context).size;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Constants.darkBluishGreyColor,
          builder: (_) => Column(
            children: [
              const Spacer(),
              QRCode(
                qrSize: size.width * .9,
                qrPadding: 2,
                qrData: userid,
                qrBackgroundColor: Colors.transparent,
                qrForegroundColor: Constants.primaryColor,
              ),
              const Spacer(),
              InkWell(
                onTap: () => showQrCodeScanner(context),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: const [
                      Spacer(),
                      Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
                      Header(title: "Scan", color: Colors.white),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
