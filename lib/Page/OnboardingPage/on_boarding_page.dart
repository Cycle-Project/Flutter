import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/OnboardingPage/Model/on_boarding_model.dart';
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
        bgColor: Colors.red,
      ),
      OnboardingModel(
        lottie: "https://assets10.lottiefiles.com/packages/lf20_ryzjgsfe.json",
        title: "Tanışma",
        subtitle: "Erkekler için Kız bulma platformu",
        counter: 2,
        bgColor: Colors.blue,
      ),
      OnboardingModel(
        lottie: "https://assets6.lottiefiles.com/packages/lf20_hbhjkeay.json",
        title: "Öyle işte",
        subtitle: "Bir şeyler bir şeler hacım işte. Uygulamaya like atın",
        counter: 3,
        bgColor: Colors.green,
      ),
    ];
    final controller = LiquidController();
    final currentPage = useState(0);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: List.generate(
              pages.length,
              (i) => OnboardingAPage(onboardingModel: pages[i]),
            ),
            liquidController: controller,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: (active) {
              if (pages.length - 1 == currentPage.value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EnterancePage(),
                  ),
                  (r) => r.isFirst,
                );
                return;
              }
              currentPage.value = active;
            },
          ),
          /* Positioned(
            bottom: 60,
            child: OutlinedButton(
              onPressed: () {
                int nextPage = controller.currentPage + 1;
                controller.animateToPage(page: nextPage);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color(0xff272727), shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ), */
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
              activeIndex: controller.currentPage,
              effect: const WormEffect(
                activeDotColor: Color(0xff272727),
                dotHeight: 5,
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
