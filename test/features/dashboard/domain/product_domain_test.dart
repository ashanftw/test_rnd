import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data/repository/product_repo.dart';
import 'package:test_rnd/features/dashboard/domain/product_domain.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'product_domain_test.mocks.dart';

class MockProductRepo extends Mock implements ProductRepo {}

@GenerateMocks([MockProductRepo])
void main() {
  late MockMockProductRepo mockProdctRepo;
  late ProductDomain productDomain;
  setUp(() {
    mockProdctRepo = MockMockProductRepo();
    productDomain = ProductDomain(client: mockProdctRepo);
  });
  final prodData = ProductData();

  test('Should return productData model', () async {
    //Arrange
    when(mockProdctRepo.getProducts()).thenAnswer((_) async => prodData);

    //Act
    var result = await productDomain.getProducts();

    //Assert
    expect(result, prodData);
    verify(mockProdctRepo.getProducts()).called(1);
    verifyNoMoreInteractions(mockProdctRepo);
  });
}
