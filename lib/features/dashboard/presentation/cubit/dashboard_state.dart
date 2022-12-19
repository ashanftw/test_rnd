part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final ProductData? productData;
  final Exception? exception;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.productData,
    this.exception,
  });
  @override
  List<Object?> get props => [status, productData, exception];

  DashboardState copyWith({
    DashboardStatus? status,
    ProductData? productData,
    Exception? exception,
  }) {
    return DashboardState(
      status: status ?? this.status,
      productData: productData ?? this.productData,
      exception: exception ?? this.exception,
    );
  }
}
