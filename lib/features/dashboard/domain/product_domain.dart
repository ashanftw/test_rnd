import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data/repository/product_repo.dart';

class ProductDomain implements ProductRepo {
  final ProductRepo client;
  ProductDomain({required this.client});

  @override
  Future<ProductData> getProducts() {
    return client.getProducts();
  }
}
