part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class GetProductsEvent extends ProductEvent {
  final ProductParams params;
  final bool isLoadMore;
  const GetProductsEvent({required this.params, this.isLoadMore = false});
  @override
  List<Object> get props => [params, isLoadMore];
}
final class ResetProductsEvent extends ProductEvent {
  const ResetProductsEvent();
}
