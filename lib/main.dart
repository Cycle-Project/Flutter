import 'package:flutter/material.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/OnboardingPage/on_boarding_page.dart';
import 'package:geo_app/Page/utilities/constants.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Constants.primaryColor,
        scaffoldBackgroundColor: Constants.bluishGreyColor,
        primarySwatch: Constants.generateMaterialColor(
          Constants.darkBluishGreyColor,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(body: OnboardingPage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
