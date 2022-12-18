import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:test_rnd/features/dashboard/domain/product_domain.dart';
import 'package:http/http.dart' as http;

void main() {
  late ProductDomain productDomain;
  setUp(() {
    productDomain =
        ProductDomain(client: ProductRemoteDataSource(http.Client()));
  });

  test('Should return productData model', () async {
    //Arrange
    //Act
    var result = await productDomain.getProducts();

    //Assert
    expect(result, isA<ProductData>());
  });
}
