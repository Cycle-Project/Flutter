import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/header.dart';
import 'package:geo_app/components/image_avatar.dart';

class GroupDetailPage extends HookWidget {
  const GroupDetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Map item;

  @override
  Widget build(BuildContext context) {
    final membersLength = item["members"]?.length ?? 0;
    final size = MediaQuery.of(context).size;
    final width = min<double>(size.width, membersLength * 32.0);
    int memberCount() => (width / (membersLength / .5)).ceil();
    final length = min<int>(memberCount(), membersLength);
    return Scaffold(
      backgroundColor: Constants.darkBluishGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 30),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ImageAvatar(
                      border: const ImageAvatarBorder(
                          borderRadius: 60, thickness: 0),
                      size: 120,
                      color: Colors.white,
                      fileName: item["imagePath"]!,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item["groupName"]!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Header(title: "Members", padding: EdgeInsets.zero),
                ),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    backgroundColor:
                        Constants.darkBluishGreyColor.withOpacity(.9),
                    builder: (_) => Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Add new member",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Icon(
                                      Icons.person_add_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: item['members'].length,
                            itemBuilder: (_, i) => Container(
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
                                  item['members'][i],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: _Members(length: length, list: item["members"]),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Header(title: "Events", padding: EdgeInsets.zero),
                ),
                const _Events(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Events extends StatelessWidget {
  const _Events();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size.aspectRatio > 1 ? 3 : 2,
      children: [
        ...List.generate(
          9,
          (i) => Padding(
            padding: const EdgeInsets.all(2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text("Event ${i + 1}"),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _Members extends StatelessWidget {
  const _Members({
    Key? key,
    required this.length,
    required this.list,
  }) : super(key: key);
  final int length;
  final List list;

  @override
  Widget build(BuildContext context) {
    const profileSrc = "assets/icon/Avatar.png";
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: const Alignment(1, 0),
                end: const Alignment(-0.2, 0),
                colors: [
                  Colors.grey.withOpacity(0),
                  Colors.grey.withOpacity(.6),
                ],
                stops: const [0.0, 1],
              ).createShader(bounds);
            },
            child: Stack(
              children: [
                const SizedBox(width: double.infinity, height: 60),
                ...List.generate(
                  length,
                  (i) => Positioned(
                    top: 0,
                    bottom: 0,
                    left: (length - (i + 1)) * 32.0,
                    child: const ImageAvatar(fileName: profileSrc, size: 60),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Text(
                  "See All  >",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
