import 'package:test_rnd/features/authentication/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should have a title", (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder title = find.text("Login");

    // ASSERT
    expect(title, findsOneWidget);
  });

  testWidgets("Should have one text field form to collect user email id",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder userEmailTextField = find.byKey(const ValueKey('email_id'));

    // ASSERT
    expect(userEmailTextField, findsOneWidget);
  });

  testWidgets("Should have one text field form to collect user password",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder userPasswordTextField = find.byKey(const ValueKey('password'));

    // ASSERT
    expect(userPasswordTextField, findsOneWidget);
  });

  testWidgets("Should have one login button", (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder loginButton = find.byType(ElevatedButton);

    // ASSERT
    expect(loginButton, findsOneWidget);
  });

  testWidgets(
      "Should show required fields error message if user email and password is empty",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    Finder loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);
    await tester
        .pumpAndSettle(); // await for animations to complete when button click
    Finder emailErrorText = find.text("required_email");
    Finder passwordErrorText = find.text("required_password");

    // ASSERT
    expect(emailErrorText, findsOneWidget);
    expect(passwordErrorText, findsOneWidget);
  });

  testWidgets("Should submit form when user email and password is valid",
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // ACT
    // enter values in text fields
    Finder userEmailTextField = find.byKey(const ValueKey('email_id'));
    Finder userPasswordTextField = find.byKey(const ValueKey('password'));
    await tester.enterText(userEmailTextField, 'abc@gmail.com');
    await tester.enterText(userPasswordTextField, '12345678');

    // tap login button
    Finder loginButton = find.byType(ElevatedButton);
    await tester.tap(loginButton);
    await tester
        .pumpAndSettle(); // await for animations to complete when button click
    Finder emailErrorText = find.text("required_email");
    Finder passwordErrorText = find.text("required_password");

    // ASSERT
    expect(emailErrorText, findsNothing);
    expect(passwordErrorText, findsNothing);
  });
}
