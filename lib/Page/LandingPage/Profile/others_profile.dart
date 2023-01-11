import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/WebSocket/friends_controller.dart';
import 'package:provider/provider.dart';

class OthersProfile extends HookWidget with LandingPageInteractions {
  OthersProfile({
    Key? key,
    required this.profiledUser,
    required this.currentUser,
  }) : super(key: key);
  final UserModel profiledUser;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    final friendsController = Provider.of<FriendsController>(context);
    final isFriend = useState(false);
    useEffect(() {
      isFriend.value = profiledUser.friends
              ?.any((friendId) => (currentUser.id ?? "") == friendId) ??
          false;
      return null;
    }, []);
    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () async {
              if (currentUser.id != null && profiledUser.id != null) {
                if (isFriend.value) {
                  await removeFriend(context, profiledUser.id!);
                } else {
                  try {
                    friendsController.sendFriendRequest(
                      id: currentUser.id!,
                      recipientId: profiledUser.id!,
                    );
                    await showSuccessDialog(context, "Friend Request Send");
                  } catch (err) {
                    // ignore: avoid_print
                    print(err);
                    await showFailDialog(
                        context, "Couldn't Send the Friend Request");
                  }
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Constants.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color:
                        Constants.generateMaterialColor(Constants.primaryColor)
                            .shade400,
                    spreadRadius: 1,
                    blurRadius: 3,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Spacer(),
                  Icon(
                    isFriend.value ? Icons.close : Icons.add,
                    color: Colors.black,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${isFriend.value ? "Remove" : "Add"} Friend",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Constants.lilaColor,
              boxShadow: [
                BoxShadow(
                  color: Constants.generateMaterialColor(Constants.lilaColor)
                      .shade400,
                  spreadRadius: 1,
                  blurRadius: 3,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Center(
              child: Icon(
                Icons.messenger_outline_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
