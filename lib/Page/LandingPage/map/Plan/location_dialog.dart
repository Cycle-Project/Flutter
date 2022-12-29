import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:provider/provider.dart';

class LocationDialog extends HookWidget {
  const LocationDialog({
    Key? key,
    required this.index,
    required this.callback,
  }) : super(key: key);

  final int index;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    final planProvider = Provider.of<PlanRouteProvider>(context);
    final textSearchController = useTextEditingController();
    final isSearching = useState(true);

    return Scaffold(
      appBar: AppBar(
        elevation: isSearching.value ? 0 : 6,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade600,
        title: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: isSearching.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstCurve: Curves.easeInSine,
          secondCurve: Curves.easeInSine,
          firstChild: SizedBox(
            width: double.maxFinite,
            child: Text(
              "${index == 1 ? "Source" : "Destination"} Location",
              textAlign: TextAlign.left,
            ),
          ),
          secondChild: Center(
            child: TextFormField(
              controller: textSearchController,
              style: const TextStyle(
                fontSize: 20,
              ),
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {
                if (textSearchController.text == "") {
                  isSearching.value = !isSearching.value;
                } else if (!isSearching.value) {
                  textSearchController.text = "";
                  isSearching.value = !isSearching.value;
                } else {
                  /// TODO: Search
                }
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: !isSearching.value
          ? MapWidget(
              shouldClearMark: false,
              shouldAddMark: (p0) => false,
            )
          : Column(
              children: [
                _SearchListItem(
                  callback: callback,
                  onTap: () {
                    switch (index) {
                      case 1:
                        planProvider.setSource(isPinned: true);
                        break;
                      case 2:
                        planProvider.setDestination(isPinned: true);
                        break;
                      default:
                    }
                  },
                  text: "Current Location",
                  iconData: Icons.my_location,
                ),
                _SearchListItem(
                  callback: (p0) => null,
                  text: "Pick on Map",
                  iconData: Icons.map,
                  onTap: () => isSearching.value = false,
                ),
              ],
            ),
    );
  }
}

class _SearchListItem extends StatelessWidget {
  const _SearchListItem({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    required this.callback,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final Function()? onTap;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
        callback(text);
      },
      child: SizedBox(
        height: 50,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(
                iconData,
                color: Colors.black,
                size: 28,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
