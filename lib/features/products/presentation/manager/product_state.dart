part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitialState extends ProductState {
  const ProductInitialState();
}

final class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

final class ProductsSuccessState extends ProductState {
  final int currentPage;
  final List<ProductItem> products;
  final bool isMaxPaged;
  final bool isLoadingMore;
  const ProductsSuccessState({
    required this.currentPage,
    required this.products,
    required this.isMaxPaged,
    this.isLoadingMore = false,
  });

  ProductsSuccessState copyWith({
    int? currentPage,
    List<ProductItem>? products,
    bool? isMaxPaged,
    bool? isLoadingMore,
  }) {
    return ProductsSuccessState(
      currentPage: currentPage ?? this.currentPage,
      products: products ?? this.products,
      isMaxPaged: isMaxPaged ?? this.isMaxPaged,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [currentPage, products, isMaxPaged, isLoadingMore];
}

final class ProductFailureState extends ProductState {
  final String failureMessage;
  const ProductFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
