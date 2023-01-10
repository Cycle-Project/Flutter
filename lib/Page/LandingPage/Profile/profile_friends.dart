import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/image_avatar.dart';

class ProfileFriends extends HookWidget with LandingPageInteractions {
  ProfileFriends({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = useState(<UserModel>[]);
    final searchedFriends = useState<List<UserModel>?>(null);
    final searchController = useTextEditingController();

    useValueChanged(
      searchController.text,
      (oldValue, oldResult) =>
          searchedFriends.value = friends.value.map((e) => e).toList(),
    );

    useEffect(() {
      Future.microtask(() async => friends.value = await getFriends() ?? []);
      return null;
    }, []);

    return ProfileWidget(
      name: "Friends",
      prefixIcon: Icons.group,
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Constants.darkBluishGreyColor,
        isScrollControlled: true,
        builder: (_) => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(.2),
              ),
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white60),
                      ),
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: friends.value.length,
              itemBuilder: (_, i) => FriendCard(user: friends.value[i]),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendCard extends StatelessWidget with LandingPageInteractions {
  FriendCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(.2),
      ),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: const ImageAvatar(
          fileName: "assets/icon/Avatar.png",
          size: 60,
        ),
        title: Text(
          user.name ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          onPressed: () => removeFriend(user.id!),
          icon: const Icon(Icons.close, color: Colors.red),
        ),
      ),
    );
  }
}
