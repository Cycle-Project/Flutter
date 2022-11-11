import 'package:flutter/material.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: EnterancePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
