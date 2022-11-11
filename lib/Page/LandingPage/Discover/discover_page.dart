import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_card.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  static const list = [
    {
      "username": "Content Creator",
      "imagePath": "assets/icon/Avatar.png",
      "name": "Glad to came",
    },
    {
      "username": "Content Creator",
      "imagePath": "assets/icon/Avatar.png",
      "name": "My new route",
    },
    {
      "username": "Content Creator",
      "imagePath": "assets/icon/Avatar.png",
      "name": "Mountain Bike",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discover",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.filter_alt_rounded, size: 30),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) => DiscoverCard(item: list[i]),
            ),
          ),
        ],
      ),
    );
  }
}
