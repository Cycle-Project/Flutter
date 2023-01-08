import 'package:flutter/material.dart';
import 'package:geo_app/Page/OnboardingPage/Model/on_boarding_model.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final onboardingPages = [
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
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: [
              OnboardingAPage(onboardingModel: onboardingPages[0]),
              OnboardingAPage(onboardingModel: onboardingPages[1]),
              OnboardingAPage(onboardingModel: onboardingPages[2]),
            ],
            liquidController: controller,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: onPageChangedCallback,
          ),
          Positioned(
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
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => controller.jumpToPage(page: 2),
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

  onPageChangedCallback(int activeIndex) {
    setState(() => currentPage = activeIndex);
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
