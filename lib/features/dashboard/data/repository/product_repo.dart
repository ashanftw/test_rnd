import 'package:test_rnd/features/dashboard/data/models/product.dart';

abstract class ProductRepo {
  Future<ProductData> getProducts();
}
