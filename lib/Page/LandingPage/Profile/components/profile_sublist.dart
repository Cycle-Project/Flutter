import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class ProfileSubList extends StatelessWidget {
  const ProfileSubList({
    Key? key,
    required this.list,
    required this.title,
  }) : super(key: key);

  final List list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkBluishGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(title),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => Container(
            margin: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 100,
                  child: ColoredBox(color: Colors.grey),
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      list[i],
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
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
