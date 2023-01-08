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
        lottie: "https://assets6.lottiefiles.com/packages/lf20_8fz0xapf.json",
        title: "Bisiklet Sürme",
        subtitle: "Ebenin kilometresi kadar bisiklet sürebilirsin",
        counter: 1,
        bgColor: Constants.lightSalmonColor,
      ),
      OnboardingModel(
        lottie: "https://assets10.lottiefiles.com/packages/lf20_ryzjgsfe.json",
        title: "Tanışma",
        subtitle: "Erkekler için Kız bulma platformu",
        counter: 2,
        bgColor: Constants.generateMaterialColor(Constants.tealColor).shade400,
      ),
      OnboardingModel(
        lottie: "https://assets6.lottiefiles.com/packages/lf20_hbhjkeay.json",
        title: "Öyle işte",
        subtitle: "Bir şeyler bir şeler hacım işte. Uygulamaya like atın",
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
                dotColor: Constants.backgroundColor,
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
          Column(
            children: [
              Text(
                onboardingModel.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                onboardingModel.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
