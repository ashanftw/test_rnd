import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:test_rnd/features/dashboard/presentation/home_screen.dart';

import '../test/features/dashboard/presentation/cubit/dashboard_cubit_test.mocks.dart';

void main() {
  const delay = Duration(seconds: 2);
  late MockMockProductRemoteData mockMockProductRemoteData;
  late DashboardCubit dashboardCubit;

  setUp(() {
    mockMockProductRemoteData = MockMockProductRemoteData();
    dashboardCubit = DashboardCubit(client: mockMockProductRemoteData);
  });

  generateInitialScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => dashboardCubit,
      child: const HomeScreen(),
    )));
  }

  initWidget(WidgetTester tester) async {
    when(await dashboardCubit.getProducts()).thenAnswer((_) => Future.value(
            ProductData(products: [
          Product(id: 1, title: 'title 1'),
          Product(id: 2, title: 'title 2')
        ])));

    await dashboardCubit.getProducts();

    await generateInitialScreen(tester);
  }

  group('home screen integration test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        "should show error widget when there is an exception during loading products",
        (WidgetTester tester) async {
      // ARRANGE
      when(await dashboardCubit.getProducts())
          .thenThrow(Exception('error loading data'));

      await dashboardCubit.getProducts();
      await generateInitialScreen(tester);
      //ACT
      Finder errorWidget = find.byKey(const Key("errrr"));

      //ASSERT
      expect(errorWidget, findsOneWidget);
    });

    testWidgets("should show products list", (WidgetTester tester) async {
      // ARRANGE
      await initWidget(tester);

      //ACT
      Finder listView = find.byKey(const Key("product_list_view"));

      //ASSERT
      expect(listView, findsOneWidget);
    });

    testWidgets('should go to detail screen when tap on list item',
        (WidgetTester tester) async {
      // ARRANGE
      await initWidget(tester);

      //ACT
      Finder listItem = find.byKey(const Key("list_item_1"));

      await tester.tap(listItem);
      await tester.pumpAndSettle(delay);

      Finder detailScreen = find.byKey(const Key("detail_screen"));

      //ASSERT
      expect(detailScreen, findsOneWidget);
    });
  });
}
