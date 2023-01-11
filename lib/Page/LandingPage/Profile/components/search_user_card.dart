import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Pages/profile_page.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:geo_app/components/image_avatar.dart';
import 'package:provider/provider.dart';

class SearchUserCard extends StatelessWidget with LandingPageInteractions {
  SearchUserCard({
    Key? key,
    required this.user,
    this.onRemove,
  }) : super(key: key);
  final UserModel user;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final friendsController = Provider.of<FriendsController>(context);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: friendsController,
            child: Scaffold(
              body: ProfilePage(profiledUser: user),
            ),
          ),
        ),
      ),
      child: Container(
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
          trailing: onRemove == null
              ? null
              : IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
        ),
      ),
    );
  }
}
