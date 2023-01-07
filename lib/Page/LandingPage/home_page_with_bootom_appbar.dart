import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/landing_page_appbar.dart';

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
    final size = MediaQuery.of(context).size;
    final pageController = usePageController();
    final scrollController = useScrollController();
    final isVisible = useState(true);
    final pageIndex = useState(0);

    useEffect(() {
      scrollController.addListener(() {
        ScrollDirection dir = scrollController.position.userScrollDirection;
        isVisible.value = dir == ScrollDirection.forward;
      });
      return null;
    }, [scrollController]);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => isVisible.value = true,
        child: Column(
          children: [
            AnimatedCrossFade(
              crossFadeState: pageIndex.value == 2 || !isVisible.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 100),
              firstChild:
                  const LandingPageAppBar(profileSrc: "assets/icon/Avatar.png"),
              secondChild: const SizedBox(),
              sizeCurve: Curves.easeInExpo,
            ),
            Expanded(
              child: Center(
                child: PageView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, i) => SingleChildScrollView(
                    controller: scrollController,
                    child: pages[i],
                  ),
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
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
