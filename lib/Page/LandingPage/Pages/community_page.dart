import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Community/group_card.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_page.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/search_user_card.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:provider/provider.dart';

class CommunityPage extends HookWidget with LandingPageInteractions {
  CommunityPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendsController = Provider.of<FriendsController>(context);
    final list = useState<List?>(null);
    final activeIndex = useState(0);

    useEffect(() {
      list.value = [
        {
          "groupName": "VelEsbid",
          "imagePath": "assets/icon/velesbid.jpg",
          "members": [
            "Turan",
            "Ömer",
            "Fatih",
            "Yahya",
            "Faruk",
            "Burhan",
            "Beşir",
            "Hatim"
          ],
        },
        {
          "groupName": "Muğla Bisiklet Derneği",
          "imagePath": "assets/icon/mugla-bisiklet-derneği.jpg",
          "members": ["Ali", "Veli", "Selami"],
        },
      ];
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColoredBox(
          color: Constants.darkBluishGreyColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Constants.bluishGreyColor.withOpacity(.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          2,
                          (i) => InkWell(
                            onTap: () => activeIndex.value = i,
                            child: Container(
                              decoration: BoxDecoration(
                                color: activeIndex.value == i
                                    ? Constants.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Center(
                                child: Text(
                                  i == 0 ? "Discover" : "Groups",
                                  style: TextStyle(
                                    color: activeIndex.value == i
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20,
                                    fontWeight: activeIndex.value == i
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () async => await getUsers(context, true).then(
                            (value) async => await showModalBottomSheet(
                              context: context,
                              backgroundColor: Constants.darkBluishGreyColor,
                              isScrollControlled: true,
                              builder: (_) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                    value: friendsController,
                                  ),
                                ],
                                child: CustomSearchDialog<UserModel>(
                                  items: value ?? [],
                                  itemBuilder: (_, user) =>
                                      SearchUserCard(user: user),
                                  contains: (user) => user.name ?? "",
                                ),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.search,
                              color: Constants.primaryColor,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: activeIndex.value == 0
              ? const Discover()
              : Column(
                  children: List.generate(
                    list.value?.length ?? 0,
                    (i) => Container(
                      padding: const EdgeInsets.all(16),
                      margin:
                          const EdgeInsets.only(right: 16, left: 16, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GroupCard(
                        item: list.value![i],
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
