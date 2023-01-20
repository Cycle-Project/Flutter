import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/OnboardingPage/Model/on_boarding_model.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends HookWidget with EnteranceInteraction {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnboardingModel(
        lottie: "https://assets1.lottiefiles.com/packages/lf20_8Gr1sc.json",
        title: "Cycling made easy",
        subtitle: "Plan your rides, share routes, "
            "connect with other cyclists and join groups with our app",
        counter: 1,
        bgColor: Constants.lightSalmonColor,
      ),
      OnboardingModel(
        lottie: "https://assets2.lottiefiles.com/packages/lf20_5e7wgehs.json",
        title: "Ride together",
        subtitle: "Join our cycling community, create and share routes, "
            "plan rides, and connect with like-minded individuals",
        counter: 2,
        bgColor: Constants.generateMaterialColor(Constants.tealColor).shade400,
      ),
      OnboardingModel(
        lottie: "https://assets6.lottiefiles.com/packages/lf20_8fz0xapf.json",
        title: "Get ready to ride!",
        subtitle: "Create your own routes, or follow those made by others. "
            "Join groups, add friends and participate in activities",
        counter: 3,
        bgColor: Constants.generateMaterialColor(Constants.lilaColor).shade300,
      ),
    ];
    final controller = LiquidController();
    final currentPage = useState(0);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            enableLoop: false,
            pages: List.generate(
              pages.length,
              (i) => OnboardingAPage(onboardingModel: pages[i]),
            ),
            liquidController: controller,
            slideIconWidget: pages.length - 1 == currentPage.value
                ? null
                : const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: (active) async {
              currentPage.value = active;
            },
          ),
          if (pages.length - 1 == currentPage.value)
            Positioned(
              bottom: 60,
              child: InkWell(
                onTap: () async {
                  await CacheManager.saveSharedPref(
                          tag: "newUser", value: "false")
                      .then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EnterancePage(),
                      ),
                      (r) => r.isFirst,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff272727),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Let's Start",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (currentPage.value != pages.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () => controller.jumpToPage(page: pages.length - 1),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          Positioned(
            bottom: 20,
            child: AnimatedSmoothIndicator(
              count: 3,
              activeIndex: currentPage.value,
              effect: const WormEffect(
                dotColor: Colors.white,
                activeDotColor: Constants.darkBluishGreyColor,
                dotHeight: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingAPage extends StatelessWidget {
  const OnboardingAPage({
    Key? key,
    required this.onboardingModel,
  }) : super(key: key);

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: onboardingModel.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.network(
            onboardingModel.lottie,
            repeat: true,
            height: size.height * .4,
            width: size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  onboardingModel.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  onboardingModel.subtitle,
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
