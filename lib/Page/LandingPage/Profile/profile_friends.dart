import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/search_user_card.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:provider/provider.dart';

class ProfileFriends extends HookWidget with LandingPageInteractions {
  ProfileFriends({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = useState(<UserModel>[]);

    useEffect(() {
      Future.microtask(() async {
        friends.value = await getFriends() ?? [];
      });
      return null;
    }, []);

    return ProfileWidget(
      name: "Friends",
      prefixIcon: Icons.group,
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Constants.darkBluishGreyColor,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
          value: Provider.of<FriendsController>(context),
          child: CustomSearchDialog<UserModel>(
            items: friends.value,
            itemBuilder: (_, user) => SearchUserCard(
              user: user,
              onRemove: () async => await removeFriend(context, user.id!),
            ),
            contains: (user) => user.name ?? "",
          ),
        ),
      ),
    );
  }
}
