import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/special_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subActionsList = {
      Icons.edit: () {},
      Icons.notifications: () {},
      Icons.settings: () {},
    };
    final actionList = {
      "Routes": () {},
      "Favorites": () {},
      "Bookmarks": () {},
    };
    return SafeArea(
      child: Column(
        children: [
          SpecialCard(
            backgroundColor: Colors.grey[300]!,
            shadowColor: loginBackgroundColor.withOpacity(.6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 120,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(4),
                        clipBehavior: Clip.antiAlias,
                        scrollDirection: Axis.vertical,
                        child: Text(
                          "Username",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          //image: DecorationImage(image: AssetImage("")),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              subActionsList.length,
              (i) {
                IconData key = subActionsList.keys.elementAt(i);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: subActionsList[key],
                    child: Container(
                      decoration: BoxDecoration(
                        color: loginBackgroundColor.withOpacity(.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(key, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 50,
            endIndent: 50,
            color: Colors.black.withOpacity(.6),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: actionList.length,
            itemBuilder: (context, i) {
              String key = actionList.keys.elementAt(i);
              return InkWell(
                onTap: actionList[key],
                child: SpecialCard(
                  backgroundColor: Colors.grey[100]!,
                  shadowColor: loginBackgroundColor.withOpacity(.6),
                  size: const Size(double.infinity, 60),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            key,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.keyboard_arrow_right, size: 26),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 50,
            endIndent: 50,
            color: Colors.black.withOpacity(.6),
          ),
        ],
      ),
    );
  }
}
