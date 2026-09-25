import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_product.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockGetProducts mockGetProducts;
  late ProductBloc productBloc;

  setUp(() {
    mockGetProducts = MockGetProducts();
    productBloc = ProductBloc(getProducts: mockGetProducts);
  });
  tearDown(() => productBloc.close());

  group('ProductBloc', () {
    group('GetProductsEvent (initial load)', () {
      blocTest<ProductBloc, ProductState>(
        'emits [Loading, Success] when getProducts succeeds',
        build: () {
          when(
            mockGetProducts(params: TestParams.tProductParams),
          ).thenAnswer(
            (_) => Future.value(
              Right<Failure, Products>(TestEntities.tProducts),
            ),
          );
          return productBloc;
        },
        act: (bloc) => bloc.add(
          GetProductsEvent(params: TestParams.tProductParams),
        ),
        expect: () => [
          const ProductLoadingState(),
          ProductsSuccessState(
            products: TestEntities.tProductItems,
            isMaxPaged: true,
            currentPage: 1,
          ),
        ],
        verify: (_) {
          verify(
            mockGetProducts(params: TestParams.tProductParams),
          ).called(1);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'emits [Loading, Failure] when getProducts fails',
        build: () {
          when(
            mockGetProducts(params: TestParams.tProductParams),
          ).thenAnswer(
            (_) => Future.value(
              Left<Failure, Products>(TestFailures.tServerFailure),
            ),
          );
          return productBloc;
        },
        act: (bloc) => bloc.add(
          GetProductsEvent(params: TestParams.tProductParams),
        ),
        expect: () => [
          const ProductLoadingState(),
          ProductFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });

    group('GetProductsEvent (load more)', () {
      blocTest<ProductBloc, ProductState>(
        'emits [Loading, Success] then loadMore does nothing when isMaxPaged',
        build: () {
          when(
            mockGetProducts(params: TestParams.tProductParams),
          ).thenAnswer(
            (_) => Future.value(
              Right<Failure, Products>(TestEntities.tProducts),
            ),
          );
          return productBloc;
        },
        act: (bloc) {
          bloc.add(GetProductsEvent(params: TestParams.tProductParams));
          bloc.add(
            GetProductsEvent(
              params: TestParams.tProductParams,
              isLoadMore: true,
            ),
          );
        },
        expect: () => [
          const ProductLoadingState(),
          ProductsSuccessState(
            products: TestEntities.tProductItems,
            isMaxPaged: true,
            currentPage: 1,
          ),
        ],
      );
    });
  });
}
