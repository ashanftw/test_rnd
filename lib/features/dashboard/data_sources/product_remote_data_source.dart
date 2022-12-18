import 'package:http/http.dart';
import 'package:test_rnd/core/network_manager.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data/repository/product_repo.dart';

class ProductRemoteDataSource implements ProductRepo {
  late Client client;
  late NetworkManager networkManager;
  ProductRemoteDataSource(this.client) {
    networkManager = NetworkManager(client: client);
  }

  @override
  Future<ProductData> getProducts() async {
    var result = await networkManager.sendRequest(
        path: 'https://dummyjson.com/products');
    return ProductData.fromJson(result);
  }
}
