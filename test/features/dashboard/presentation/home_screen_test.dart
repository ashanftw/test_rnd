import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:test_rnd/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:test_rnd/features/dashboard/presentation/home_screen.dart';

import 'cubit/dashboard_cubit_test.mocks.dart';

class MockProductRemoteData extends Mock implements ProductRemoteDataSource {}

@GenerateMocks([MockProductRemoteData])
void main() {
  late MockMockProductRemoteData mockMockProductRemoteData;
  late DashboardCubit dashboardCubit;

  setUp(() {
    mockMockProductRemoteData = MockMockProductRemoteData();
    dashboardCubit = DashboardCubit(client: mockMockProductRemoteData);
  });

  initWidget(WidgetTester tester) async {
    when(await dashboardCubit.getProducts()).thenAnswer((_) => Future.value(
            ProductData(products: [
          Product(id: 1, title: 'title 1'),
          Product(id: 2, title: 'title 2')
        ])));

    await dashboardCubit.getProducts();

    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => dashboardCubit,
      child: const HomeScreen(),
    )));
  }

  testWidgets('should show home screen', (WidgetTester tester) async {
    // ARRANGE
    await initWidget(tester);

    // ACT
    Finder home = find.byKey(const Key("home_screen"));

    // ASSERT
    expect(home, findsOneWidget);
  });

  testWidgets('should have product list view', (WidgetTester tester) async {
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
    await tester.pumpAndSettle();

    Finder detailScreen = find.byKey(const Key("detail_screen"));

    //ASSERT
    expect(detailScreen, findsOneWidget);
  });
}
