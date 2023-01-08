import 'package:flutter/material.dart';
import 'package:geo_app/Page/Enterance/enterance_header.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class LandingPageAppBar extends StatelessWidget {
  const LandingPageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Constants.darkBluishGreyColor,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 92,
                  child: EnteranceHeader(showTitle: false),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment(-1, .4),
                    child: Text(
                      "Cycleon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => showGeneralDialog(
                    context: context,
                    pageBuilder: (context, _, __) => Scaffold(
                      appBar: AppBar(
                        title: const Text("Notifications"),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
