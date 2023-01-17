import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app load test', () async {
    // Arrange
    final testWidgetsFlutterBinding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await testWidgetsFlutterBinding.runAsync(() async {
      // Act
      await TestApp.start();
      final loginButtonFinder = find.byKey(Key('loginButton'));
      await tester.pump();

      // Assert
      expect(loginButtonFinder, findsOneWidget);
    });
  });
}
