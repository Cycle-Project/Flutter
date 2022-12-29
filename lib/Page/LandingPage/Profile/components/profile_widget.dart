import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/header.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.name,
    required this.prefixIcon,
    required this.list,
  }) : super(key: key);

  final String name;
  final IconData? prefixIcon;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _SubList(list: list)),
            ),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(prefixIcon, color: Colors.white),
                  Header(title: name, color: Colors.white),
                ],
              ),
            ),
          ),
          if (list.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "No $name",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          if (list.isNotEmpty) ...[
            SizedBox(
              height: 160,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 200,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                      //image: DecorationImage(image: AssetImage("")),
                    ),
                    child: Align(
                      alignment: const Alignment(0, .9),
                      child: Text(
                        list[i],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SubList extends StatelessWidget {
  const _SubList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left, size: 36),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) => SizedBox(
          height: 50,
          child: Center(
            child: Text(
              list[i],
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
