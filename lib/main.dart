import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/Splash/splash_view.dart';

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
      home: const SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
