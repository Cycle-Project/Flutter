// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:geo_app/Page/OnboardingPage/on_boarding_page.dart';

void main() {
  testWidgets('Navigator test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(OnboardingPage());

    // Find the "Skip" button
    final skipButton = find.text('Skip');

    // Tap the button
    await tester.tap(skipButton);

    // Find the "Let's Start" button
    final letsStartButton = find.text("Let's Start");

    // Check that the new page is displayed
    expect(find.text('Entrance Page'), letsStartButton);
  });
}
