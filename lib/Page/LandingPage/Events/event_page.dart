import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_card.dart';

class EventPage extends HookWidget {
  const EventPage({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text("Events"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Expanded(
            child: SizedBox(
              height: size.height * .5,
              child: ListView.builder(
                itemCount: list.value?.length ?? 0,
                itemBuilder: (context, i) => list.value == null
                    ? const SizedBox()
                    : DiscoverCard(
                        item: list.value![i],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
