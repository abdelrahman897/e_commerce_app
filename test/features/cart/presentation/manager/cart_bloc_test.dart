import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late CartBloc cartBloc;
  late MockGetCart mockGetCart;
  late MockAddProductToCart mockAddProductToCart;
  late MockDeleteProductFromCart mockDeleteProductFromCart;
  late MockUpdateProductQuantity mockUpdateProductQuantity;

  setUp(() {
    mockGetCart = MockGetCart();
    mockAddProductToCart = MockAddProductToCart();
    mockDeleteProductFromCart = MockDeleteProductFromCart();
    mockUpdateProductQuantity = MockUpdateProductQuantity();
    cartBloc = CartBloc(
      getCart: mockGetCart,
      addProductToCart: mockAddProductToCart,
      deleteProductFromCart: mockDeleteProductFromCart,
      updateProductQuantity: mockUpdateProductQuantity,
    );
  });
  tearDown(() => cartBloc.close());

  group('cart bloc', () {
    group('GetCart Event', () {
      blocTest<CartBloc, CartState>(
        'emits [Loading, GetCartSuccess] when get cart succeeds with items',
        build: () {
          when(mockGetCart()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tCart)),
          );
          return cartBloc;
        },
        act: (bloc) => bloc.add(const GetCartEvent()),
        expect: () => [
          CartLoadingState(),
          GetCartSuccessState(),
        ],
        verify: (_) {
          verify(mockGetCart()).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
        'emits [Loading, CartEmptySuccess] when get cart succeeds with empty items',
        build: () {
          when(mockGetCart()).thenAnswer(
            (_) => Future.value(Right(TestEntities.tEmptyCart)),
          );
          return cartBloc;
        },
        act: (bloc) => bloc.add(const GetCartEvent()),
        expect: () => [
          CartLoadingState(),
          CartEmptySuccessState(),
        ],
      );
      blocTest<CartBloc, CartState>(
        'emits [Loading, CartFailure] when get cart fails',
        build: () {
          when(mockGetCart()).thenAnswer(
            (_) => Future.value(left(TestFailures.tServerFailure)),
          );
          return cartBloc;
        },
        act: (bloc) => bloc.add(const GetCartEvent()),
        expect: () => [
          CartLoadingState(),
          CartFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('AddProductToCart Event', () {
      blocTest<CartBloc, CartState>(
        'emits [Loading, AddProductToCartSuccess] when add product succeeds',
        build: () {
          when(
            mockAddProductToCart(params: TestParams.tCartParams),
          ).thenAnswer((_) => Future.value(Right(null)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          AddProductToCartEvent(cartParams: TestParams.tCartParams),
        ),
        expect: () => [
          CartLoadingState(),
          AddProductToCartSuccessState(),
        ],
        verify: (_) {
          verify(
            mockAddProductToCart(params: TestParams.tCartParams),
          ).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
        'emits [Loading, CartFailure] when add product fails',
        build: () {
          when(
            mockAddProductToCart(params: TestParams.tCartParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          AddProductToCartEvent(cartParams: TestParams.tCartParams),
        ),
        expect: () => [
          CartLoadingState(),
          CartFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('DeleteProductFromCart Event', () {
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, DeleteProductFromCartSuccess] when delete product succeeds with remaining items',
        build: () {
          when(
            mockDeleteProductFromCart(params: TestParams.tCartParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          DeleteProductFromCartEvent(cartParams: TestParams.tCartParams),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          DeleteProductFromCartSuccessState(),
        ],
        verify: (_) {
          verify(
            mockDeleteProductFromCart(params: TestParams.tCartParams),
          ).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, CartEmptySuccess] when delete product succeeds with empty cart',
        build: () {
          when(
            mockDeleteProductFromCart(params: TestParams.tCartParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tEmptyCart)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          DeleteProductFromCartEvent(cartParams: TestParams.tCartParams),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          CartEmptySuccessState(),
        ],
      );
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, CartFailure] when delete product fails',
        build: () {
          when(
            mockDeleteProductFromCart(params: TestParams.tCartParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          DeleteProductFromCartEvent(cartParams: TestParams.tCartParams),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          CartFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('UpdateProductQuantity Event', () {
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, UpdateProductQuantitySuccess] when update quantity succeeds with remaining items',
        build: () {
          when(
            mockUpdateProductQuantity(
              params: TestParams.tCartParamsWithQuantity,
            ),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          UpdateProductQuantityEvent(
            cartParams: TestParams.tCartParamsWithQuantity,
          ),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          UpdateProductQuantitySuccessState(),
        ],
        verify: (_) {
          verify(
            mockUpdateProductQuantity(
              params: TestParams.tCartParamsWithQuantity,
            ),
          ).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, CartEmptySuccess] when update quantity succeeds with empty cart',
        build: () {
          when(
            mockUpdateProductQuantity(
              params: TestParams.tCartParamsWithQuantity,
            ),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tEmptyCart)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          UpdateProductQuantityEvent(
            cartParams: TestParams.tCartParamsWithQuantity,
          ),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          CartEmptySuccessState(),
        ],
      );
      blocTest<CartBloc, CartState>(
        'emits [UpdateCartLoadingState, CartFailure] when update quantity fails',
        build: () {
          when(
            mockUpdateProductQuantity(
              params: TestParams.tCartParamsWithQuantity,
            ),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return cartBloc;
        },
        act: (bloc) => bloc.add(
          UpdateProductQuantityEvent(
            cartParams: TestParams.tCartParamsWithQuantity,
          ),
        ),
        expect: () => [
          UpdateCartLoadingState(),
          CartFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
  });
}
