import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/domain/usecases/get_products.dart';
import 'package:equatable/equatable.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts _getProducts;

  ProductBloc({required GetProducts getProducts})
    : _getProducts = getProducts,
      super(const ProductInitialState()) {
    on<GetProductsEvent>(_onGetProductsEvent, transformer: sequential());
    on<ResetProductsEvent>((event, emit) => emit(const ProductInitialState()));
  }

  FutureOr<void> _onGetProductsEvent(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    ProductsSuccessState? currentState;
    if (event.isLoadMore) {
      if (state is! ProductsSuccessState) return;
      currentState = state as ProductsSuccessState;
      if (currentState.isMaxPaged) return;
      emit(currentState.copyWith(isLoadingMore: true));
    } else {
      emit(const ProductLoadingState());
    }
    final result = await _getProducts(params: event.params);
    result.fold(
      (failure) {
        if (event.isLoadMore && currentState != null) {
          emit(currentState.copyWith(isLoadingMore: false));
          addError(failure.message);
        } else {
          emit(ProductFailureState(failureMessage: failure.message));
        }
      },
      (success) {
        final isMaxPaged =
            success.metadata.currentPage == success.metadata.numberOfPages;
        if (event.isLoadMore && currentState != null) {
          final latestState = state as ProductsSuccessState;
          emit(
            latestState.copyWith(
              products: [...latestState.products, ...success.products],
              isMaxPaged: isMaxPaged,
              currentPage: success.metadata.currentPage,
              isLoadingMore: false,
            ),
          );
        } else {
          emit(
            ProductsSuccessState(
              products: success.products,
              isMaxPaged: isMaxPaged,
              currentPage: success.metadata.currentPage,
            ),
          );
        }
      },
    );
  }
}
