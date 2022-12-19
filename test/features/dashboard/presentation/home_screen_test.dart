import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:test_rnd/features/dashboard/presentation/home_screen.dart';

void main() {
  testWidgets('should show home screen', (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    // ACT
    Finder home = find.byKey(const Key("home_screen"));

    // ASSERT
    expect(home, findsOneWidget);
  });

  testWidgets('should have product list view', (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    // ACT
    Finder listView = find.byKey(const Key("product_list_view"));

    // ASSERT
    expect(listView, findsOneWidget);
  });
}
