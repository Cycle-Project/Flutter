import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends HookWidget {
  ProfileImage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var image = useState(File(""));

    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                _CustomListTile(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 28,
                  ),
                  str: "Camera",
                  onTap: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                    ShowQuestionDialog(
                      context,
                      question: "Are you sure about that?",
                      approveAction: () {
                        image.value = File(photo!.path);
                        Navigator.pop(context);
                      },
                      cancelAction: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                _CustomListTile(
                  icon: const Icon(
                    Icons.photo,
                    size: 28,
                  ),
                  str: "Gallery",
                  onTap: () async {
                    final XFile? gallery =
                        await _picker.pickImage(source: ImageSource.gallery);
                    image.value = File(gallery!.path);
                    Navigator.pop(context);
                    ShowQuestionDialog(
                      context,
                      question: "Are you sure about that?",
                      approveAction: () {
                        image.value = File(gallery!.path);
                        Navigator.pop(context);
                      },
                      cancelAction: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                _CustomListTile(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 28,
                  ),
                  str: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      child: SizedBox.square(
        dimension: 150,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: image.value.path.isEmpty
              ? const Image(
                  image: AssetImage("assets/icon/add-image.png"),
                )
              : ClipOval(
                  child: Image.file(
                    image.value,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    Key? key,
    required this.icon,
    required this.str,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String str;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Spacer(),
            icon,
            const SizedBox(width: 16),
            Text(
              str,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

/**
 * //

 */
