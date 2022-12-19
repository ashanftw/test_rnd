import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:test_rnd/features/dashboard/presentation/cubit/dashboard_cubit.dart';

import 'dashboard_cubit_test.mocks.dart';

class MockProductRemoteData extends Mock implements ProductRemoteDataSource {}

@GenerateMocks([MockProductRemoteData])
void main() {
  late MockMockProductRemoteData mockProductRemoteData;
  late DashboardCubit dashboardCubit;
  setUp(() {
    mockProductRemoteData = MockMockProductRemoteData();
    dashboardCubit = DashboardCubit(client: mockProductRemoteData);
  });

  test('Should throw an exception if request failed', () async {
    //Arrange
    when(mockProductRemoteData.getProducts())
        .thenThrow(Exception('Request failed'));
    //Act
    await dashboardCubit.getProducts();

    //Assert
    expect(dashboardCubit.state.status, DashboardStatus.failure);
    expect(dashboardCubit.state.productData, null);
    expect(dashboardCubit.state.exception, isA<Exception>());
  });

  test('should retrun ProductData Model on success', () async {
    //Arrange
    when(mockProductRemoteData.getProducts())
        .thenAnswer((realInvocation) => Future.value(ProductData()));
    //Act
    await dashboardCubit.getProducts();

    //Assert
    expect(dashboardCubit.state.status, DashboardStatus.success);
    expect(dashboardCubit.state.productData, isA<ProductData>());
    expect(dashboardCubit.state.exception, null);
  });
}
