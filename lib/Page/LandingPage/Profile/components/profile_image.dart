import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends HookWidget {
  ProfileImage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var image = useState(File(""));

    picker(context, ImageSource source) async {
      XFile? photo = await _picker.pickImage(source: source);
      bool approve = await showQuestionDialog(context, "Are you sure?");
      if (approve) {
        image.value = File(photo!.path);
      }
    }

    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Constants.darkBluishGreyColor,
        builder: (_) => Wrap(
          children: [
            _CustomListTile(
              onTap: () async => await picker(context, ImageSource.camera),
              icon: Icons.camera_alt_outlined,
              title: "Camera",
            ),
            _CustomListTile(
              onTap: () async => await picker(context, ImageSource.gallery),
              icon: Icons.photo,
              title: "Gallery",
            ),
            _CustomListTile(
              onTap: () => Navigator.pop(context),
              icon: Icons.cancel_outlined,
              title: "Cancel",
            ),
            _CustomListTile(
              onTap: () async {
                bool answer = await showQuestionDialog(
                    context, 'Do you want to remove Image?');
                if (answer) image.value = File("");
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              icon: Icons.delete_forever,
              color: Colors.red.shade600,
              title: "Delete Image",
            ),
          ],
        ),
      ),
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(
              image.value,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: image.value.path.isEmpty
            ? const Icon(Icons.person, size: 72, color: Colors.white)
            : const SizedBox(),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Spacer(),
            Icon(icon, size: 28, color: color),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
