import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePageWithBottomAppBar extends HookWidget {
  const HomePageWithBottomAppBar({
    super.key,
    required this.pages,
    required this.icons,
    required this.color,
    required this.selectedColor,
    required this.backgroundColor,
    required this.bottomBarColor,
  });
  final List<Widget> pages;
  final List<IconData> icons;
  final Color selectedColor;
  final Color color;
  final Color backgroundColor;
  final Color bottomBarColor;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final pageIndex = useState(0);
    final isVisible = useState(true);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => isVisible.value = true,
        child: PageView.builder(
          itemCount: pages.length,
          itemBuilder: (context, i) => pages[i],
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Visibility(
          visible: isVisible.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bottomBarColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              height: 60.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (context, i) => IconButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  icon: Icon(
                    icons[i],
                    color: pageIndex.value == i ? selectedColor : color,
                  ),
                  onPressed: () {
                    pageIndex.value = i;
                    isVisible.value = true;
                    pageController.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInCirc,
                    );
                  },
                ),
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
