import 'package:flutter_test/flutter_test.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ProductRemoteDataSource productRemoteDataSource;
  setUp(() {
    mockClient = MockClient();
    productRemoteDataSource = ProductRemoteDataSource(mockClient);
  });

  tearDown(() {
    mockClient.close();
  });

  test(
      'Should return a valid ProductData model when the JSON rating is an integer',
      () async {
    //Arrange
    String fetchProductsUrl = 'https://dummyjson.com/products';

    //Act
    when(mockClient.get(Uri.parse(fetchProductsUrl), headers: {
      'content-type': 'application/json'
    })).thenAnswer((realInvocation) async => http.Response(
        '{ "products":[ { "id":1, "title":"flutter", "description":"A framework", "price":549, "discountPercentage":12.96, "rating":4, "stock":94, "brand":"Apple", "category":"smartphones", "thumbnail":"https://flutter/thumbnail.jpg", "images":[ "https://flutter/1.jpg" ] } ], "total":100, "skip":0, "limit":30 }',
        200));

    //Assert
    expect(await productRemoteDataSource.getProducts(), isA<ProductData>());
  });

  test(
      'Should return a valid ProductData model when the JSON rating is a Double',
      () async {
    //Arrange
    String fetchProductsUrl = 'https://dummyjson.com/products';

    //Act
    when(mockClient.get(Uri.parse(fetchProductsUrl), headers: {
      'content-type': 'application/json'
    })).thenAnswer((realInvocation) async => http.Response(
        '{ "products":[ { "id":1, "title":"flutter", "description":"A framework", "price":549, "discountPercentage":12.96, "rating":4.34, "stock":94, "brand":"Apple", "category":"smartphones", "thumbnail":"https://flutter/thumbnail.jpg", "images":[ "https://flutter/1.jpg" ] } ], "total":100, "skip":0, "limit":30 }',
        200));

    //Assert
    expect(await productRemoteDataSource.getProducts(), isA<ProductData>());
  });
}
