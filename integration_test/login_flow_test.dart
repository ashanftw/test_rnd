import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_rnd/features/authentication/presentation/login_screen.dart';

void main() {
  const delay = Duration(seconds: 2);
  group("Login Flow Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        "Should show required error message when user taps on login button without entering valid email & password",
        (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(const MaterialApp(
        home: LoginScreen(),
      ));

      // ACT
      Finder loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle(
          delay); // await for animations to complete when button click
      Finder emailErrorText = find.text("required_email");
      Finder passwordErrorText = find.text("required_password");

      // ASSERT
      expect(emailErrorText, findsOneWidget);
      expect(passwordErrorText, findsOneWidget);
    });

    testWidgets(
        "Should show home screen when user taps on login button after entering valid email & password",
        (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(const MaterialApp(
        home: LoginScreen(),
      ));

      // ACT
      // enter values in text fields
      Finder userEmailTextField = find.byKey(const ValueKey('email_id'));
      Finder userPasswordTextField = find.byKey(const ValueKey('password'));
      await tester.enterText(userEmailTextField, 'mark@gmail.com');
      await tester.enterText(userPasswordTextField, 'mark123456');

      // tap login button
      Finder loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle(
          delay); // await for animations to complete when button click
      Finder homeScreen = find.byKey(const Key('home_screen'));

      // ASSERT
      expect(homeScreen, findsOneWidget);
    });
  });
}
