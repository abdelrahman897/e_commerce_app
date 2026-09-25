import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_wishlist.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockGetWishlist mockGetWishlist;
  late MockAddProductToWishlist mockAddProduct;
  late MockDeleteProductFromWishlist mockDeleteProduct;
  late WishlistBloc wishlistBloc;

  setUp(() {
    mockGetWishlist = MockGetWishlist();
    mockAddProduct = MockAddProductToWishlist();
    mockDeleteProduct = MockDeleteProductFromWishlist();
    wishlistBloc = WishlistBloc(
      getWishlist: mockGetWishlist,
      addProductToWishlist: mockAddProduct,
      deleteProductFromWishlist: mockDeleteProduct,
    );
  });
  tearDown(() => wishlistBloc.close());

  group('WishlistBloc', () {
    group('GetWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, GetWishlistSuccess] when getWishlist succeeds with products',
        build: () {
          when(mockGetWishlist()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tProductItems)),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const GetWishlistEvent()),
        expect: () => [
          WishlistLoadingState(),
          GetWishlistSuccessState(),
        ],
        verify: (_) {
          verify(mockGetWishlist()).called(1);
        },
      );

      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, WishlistEmptySuccess] when getWishlist succeeds with empty list',
        build: () {
          when(mockGetWishlist()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tEmptyProductItems)),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const GetWishlistEvent()),
        expect: () => [
          WishlistLoadingState(),
          WishlistEmptySuccessState(),
        ],
      );

      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, WishlistFailure] when getWishlist fails',
        build: () {
          when(mockGetWishlist()).thenAnswer(
            (_) => Future.value(
              Left<Failure, List<ProductItem>>(
                TestFailures.tServerFailure,
              ),
            ),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(const GetWishlistEvent()),
        expect: () => [
          WishlistLoadingState(),
          WishlistFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });

    group('AddProductToWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, AddProductSuccess, Loading, GetWishlistSuccess] when addProduct succeeds',
        build: () {
          wishlistBloc.wishlist = TestEntities.tProductItems;
          when(mockAddProduct(params: TestParams.tWishlistParams)).thenAnswer(
            (_) => Future.value(const Right<Failure, void>(null)),
          );
          when(mockGetWishlist()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tProductItems)),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(
          AddProductToWishlistEvent(
            wishlistParams: TestParams.tWishlistParams,
          ),
        ),
        expect: () => [
          WishlistLoadingState(),
          AddProductToWishlistSuccessState(),
          WishlistLoadingState(),
          GetWishlistSuccessState(),
        ],
        verify: (_) {
          verify(
            mockAddProduct(params: TestParams.tWishlistParams),
          ).called(1);
          verify(mockGetWishlist()).called(1);
        },
      );

      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, WishlistFailure] when addProduct fails',
        build: () {
          wishlistBloc.wishlist = TestEntities.tProductItems;
          when(mockAddProduct(params: TestParams.tWishlistParams)).thenAnswer(
            (_) => Future.value(
              Left<Failure, void>(TestFailures.tServerFailure),
            ),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(
          AddProductToWishlistEvent(
            wishlistParams: TestParams.tWishlistParams,
          ),
        ),
        expect: () => [
          WishlistLoadingState(),
          WishlistFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });

    group('DeleteProductFromWishlistEvent', () {
      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, DeleteProductSuccess, Loading, GetWishlistSuccess] when deleteProduct succeeds',
        build: () {
          wishlistBloc.wishlist = TestEntities.tProductItems;
          when(
            mockDeleteProduct(params: TestParams.tWishlistParams),
          ).thenAnswer(
            (_) => Future.value(const Right<Failure, void>(null)),
          );
          when(mockGetWishlist()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tProductItems)),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(
          DeleteProductFromWishlistEvent(
            wishlistParams: TestParams.tWishlistParams,
          ),
        ),
        expect: () => [
          WishlistLoadingState(),
          DeleteProductFromWishlistSuccessState(),
          WishlistLoadingState(),
          GetWishlistSuccessState(),
        ],
        verify: (_) {
          verify(
            mockDeleteProduct(params: TestParams.tWishlistParams),
          ).called(1);
          verify(mockGetWishlist()).called(1);
        },
      );

      blocTest<WishlistBloc, WishlistState>(
        'emits [Loading, WishlistFailure] when deleteProduct fails',
        build: () {
          wishlistBloc.wishlist = TestEntities.tProductItems;
          when(
            mockDeleteProduct(params: TestParams.tWishlistParams),
          ).thenAnswer(
            (_) => Future.value(
              Left<Failure, void>(TestFailures.tServerFailure),
            ),
          );
          return wishlistBloc;
        },
        act: (bloc) => bloc.add(
          DeleteProductFromWishlistEvent(
            wishlistParams: TestParams.tWishlistParams,
          ),
        ),
        expect: () => [
          WishlistLoadingState(),
          WishlistFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
  });
}
