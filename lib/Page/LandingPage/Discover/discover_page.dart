import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_card.dart';

class Discover extends HookWidget {
  const Discover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = useState<List?>(null);
    useEffect(() {
      list.value = [
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
      return null;
    }, []);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: list.value?.length ?? 0,
      itemBuilder: (context, i) => list.value == null
          ? const SizedBox()
          : DiscoverCard(
              item: list.value![i],
            ),
    );
  }
}
