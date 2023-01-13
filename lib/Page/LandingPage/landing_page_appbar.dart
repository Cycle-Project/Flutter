import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/Enterance/enterance_header.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:geo_app/components/header.dart';
import 'package:geo_app/main.dart';
import 'package:provider/provider.dart';

class LandingPageAppBar extends HookWidget {
  const LandingPageAppBar({super.key});

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
                    pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
                      value: Provider.of<FriendsController>(context),
                      child: NotificationsDialog(),
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

class NotificationsDialog extends HookWidget with LandingPageInteractions {
  NotificationsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);
    final friendsController = Provider.of<FriendsController>(context);
    final friendList = useState(<UserModel>[]);
    useEffect(() {
      Future.microtask(() async {
        for (String senderId in friendsController.friendRequests.senders) {
          UserModel user = (await getUserById(context, userId: senderId))!;
          friendList.value.add(user);
        }
        isLoading.value = true;
      });
      return null;
    }, [friendsController.friendRequests]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: applicationUserModel == null || isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Header(
                  padding: EdgeInsets.all(8),
                  title: "Friend Requests",
                  color: Colors.white,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: friendList.value.length,
                  itemBuilder: (_, i) => NotificationTile(
                    user: friendList.value[i],
                    currentUser: applicationUserModel!,
                  ),
                ),
              ],
            ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.user,
    required this.currentUser,
  }) : super(key: key);

  final UserModel user;
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final friendsController = Provider.of<FriendsController>(context);

    respond(response) {
      friendsController.respondFriendRequest(
        id: user.id!,
        recipientId: currentUser.id!,
        response: response,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Constants.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      child: Row(
        children: [
          Text(
            user.name!,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => respond('accepted'),
            icon: const Icon(Icons.done, color: Colors.teal),
          ),
          IconButton(
            onPressed: () => respond('rejected'),
            icon: const Icon(Icons.close, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
