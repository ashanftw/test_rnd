import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rnd/features/dashboard/data/models/product.dart';
import 'package:test_rnd/features/dashboard/data/repository/product_repo.dart';
import 'package:test_rnd/features/dashboard/domain/product_domain.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late ProductRepo client;
  late ProductDomain product;
  DashboardCubit({required this.client}) : super(const DashboardState()) {
    product = ProductDomain(client: client);
  }

  Future<void> getProducts() async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      ProductData productData = await product.getProducts();
      emit(state.copyWith(
          status: DashboardStatus.success, productData: productData));
    } on Exception catch (error) {
      emit(state.copyWith(status: DashboardStatus.failure, exception: error));
    }
  }
}
