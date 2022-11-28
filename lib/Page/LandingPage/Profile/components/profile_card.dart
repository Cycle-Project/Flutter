part of '../profile_page.dart';

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Stack(
        children: [
          ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  height: 110,
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox(height: 60)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mode_edit_outline_outlined,
                          size: 28),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined, size: 28),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "500+ Followers",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 12,
            child: SizedBox.square(
              dimension: 120,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    //image: DecorationImage(image: AssetImage("")),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
