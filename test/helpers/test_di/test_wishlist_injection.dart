import 'package:e_commerce_app/features/wishlist/domain/usecases/add_product_to_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/delete_product_from_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';

import '../mocks/mock_wishlist.mocks.dart';
import 'base_test_injection.dart';

class WishlistTestInjection {
  WishlistTestInjection._();

  // ── Mocks available for tests ────────────────────────────────────────────
  static late MockGetWishlist mockGetWishlist;
  static late MockAddProductToWishlist mockAddProductToWishlist;
  static late MockDeleteProductFromWishlist mockDeleteProductFromWishlist;
  static late MockWishlistBloc mockWishlistBloc;

  // ─────────────────────────────────────────────────────────────────────────
  /// Register all wishlist mocks in getIt
  /// Must call BaseTestInjection.init() first
  // ─────────────────────────────────────────────────────────────────────────
  static void register() {
    // 1. Create mocks
    mockGetWishlist = MockGetWishlist();
    mockAddProductToWishlist = MockAddProductToWishlist();
    mockDeleteProductFromWishlist = MockDeleteProductFromWishlist();
    mockWishlistBloc = MockWishlistBloc();

    // 2. Register use case mocks in getIt
    testGetIt
      ..registerFactory<GetWishlist>(() => mockGetWishlist)
      ..registerFactory<AddProductToWishlist>(() => mockAddProductToWishlist)
      ..registerFactory<DeleteProductFromWishlist>(
        () => mockDeleteProductFromWishlist,
      );

    // 3. Register bloc with mocked use cases
    testGetIt.registerFactory<WishlistBloc>(
      () => WishlistBloc(
        getWishlist: mockGetWishlist,
        deleteProductFromWishlist: mockDeleteProductFromWishlist,
        addProductToWishlist: mockAddProductToWishlist,
      ),
    );
  }
}
