import 'package:e_commerce_app/features/authentication/data/models/address_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/authentication_user_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/sub_models/address_item_data_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_google_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/user_google_response.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_product_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_response.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';
import 'package:e_commerce_app/core/models/metadata_model.dart';
import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/products/data/models/products_model.dart';
import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';
import 'package:e_commerce_app/features/wishlist/data/models/wishlist_response.dart';

import 'test_data.dart';

abstract class TestModels {
  static UserModel get tUserModel => const UserModel(
    name: TestConstants.tName,
    email: TestConstants.tEmail,
    role: TestConstants.tRole,
  );
  static AuthenticatedUserModel get tAuthModel => AuthenticatedUserModel(
    message: TestConstants.tAuthSuccess,
    user: TestModels.tUserModel,
    token: TestConstants.tToken,
  );
  static AuthenticatedUserModel get tAuthWithNoTokenModel =>
      AuthenticatedUserModel(
        message: TestConstants.tAuthSuccess,
        user: TestModels.tUserModel,
        token: null,
      );
  static UserGoogleModel get tGoogleUser => UserGoogleModel(
    id: TestConstants.tGoogleId,
    name: TestConstants.tGoogleName,
    email: TestConstants.tGoogleEmail,
    phoneNumber: TestConstants.tPhone,
  );

  static UserGoogleResponse get tGoogleResponse => UserGoogleResponse(
    token: TestConstants.tGoogleToken,
    userGoogle: TestModels.tGoogleUser,
  );
  static AddressModel get tAddressModelResponse => AddressModel(
    status: TestConstants.tStatus,
    message: TestConstants.tAddressSuccessMessage,
    addresses: [tAddressItemDataResponse],
  );
  static AddressItemDataModel get tAddressItemDataResponse =>
      AddressItemDataModel(
        id: TestConstants.tId,
        name: TestConstants.tAddressName,
        details: TestConstants.tAddressDetails,
        phone: TestConstants.tPhone,
        city: TestConstants.tAddressCity,
      );

  static CategoryModel get tCategoryModel => const CategoryModel(
    id: TestConstants.tCategoryId,
    name: TestConstants.tCategoryName,
    slug: TestConstants.tCategorySlug,
    imageUrl: TestConstants.tCategoryImageUrl,
  );

  static BrandModel get tBrandModel => const BrandModel(
    id: TestConstants.tBrandId,
    name: TestConstants.tBrandName,
    slug: TestConstants.tBrandSlug,
    imageUrl: TestConstants.tBrandImageUrl,
  );

  static CartProductModel get tCartProductModel => CartProductModel(
    id: TestConstants.tProductId,
    title: TestConstants.tProductTitle,
    quantity: TestConstants.tProductQuantity,
    imageCoverUrl: TestConstants.tImageCoverUrl,
    category: tCategoryModel,
    brand: tBrandModel,
    ratingsAverage: TestConstants.tRatingsAverage,
  );

  static CartItemModel get tCartItemModel => CartItemModel(
    count: TestConstants.tCount,
    id: TestConstants.tCartItemId,
    cartProduct: tCartProductModel,
    price: TestConstants.tPrice,
  );

  static CartModel get tCartModel => CartModel(
    id: TestConstants.tCartId,
    cartOwnerId: TestConstants.tCartOwnerId,
    items: [tCartItemModel],
    totalCartPrice: TestConstants.tTotalCartPrice,
  );

  static CartModel get tEmptyCartModel => const CartModel(
    id: TestConstants.tCartId,
    cartOwnerId: TestConstants.tCartOwnerId,
    items: [],
    totalCartPrice: 0,
  );

  static CartResponse get tCartResponse => CartResponse(
    status: TestConstants.tCartStatus,
    numOfCartItems: TestConstants.tNumOfCartItems,
    cartId: TestConstants.tCartId,
    cart: tCartModel,
  );

  static CartResponse get tEmptyCartResponse => CartResponse(
    status: TestConstants.tCartStatus,
    numOfCartItems: 0,
    cartId: TestConstants.tCartId,
    cart: tEmptyCartModel,
  );

  // ─── WISHLIST TEST MODELS ────────────────────────────────────────────────
  static ProductItemModel get tProductItemModel => ProductItemModel(
    sold: TestConstants.tProductSold,
    imagesUrl: TestConstants.tProductImagesUrl,
    ratingsQuantity: TestConstants.tProductRatingsQuantity,
    id: TestConstants.tProductId,
    title: TestConstants.tProductTitle,
    slug: TestConstants.tProductSlug,
    description: 'Test product description',
    quantity: TestConstants.tProductQuantity,
    price: TestConstants.tPrice,
    imageCoverUrl: TestConstants.tImageCoverUrl,
    category: tCategoryModel,
    brand: tBrandModel,
    ratingsAverage: TestConstants.tRatingsAverage,
    createdAt: TestConstants.tProductCreatedAt,
    updatedAt: TestConstants.tProductUpdatedAt,
    priceAfterDiscount: 180,
  );

  static ProductsModel get tProductsModel => ProductsModel(
    results: 1,
    metadata: MetadataModel(
      currentPage: 1,
      numberOfPages: 1,
      limit: 20,
      nextPage: null,
      prevPage: null,
    ),
    products: [tProductItemModel],
  );

  static WishlistResponse get tWishlistResponse => WishlistResponse(
    status: TestConstants.tWishlistStatus,
    count: TestConstants.tWishlistCount,
    products: [tProductItemModel],
  );

  static WishlistResponse get tEmptyWishlistResponse => const WishlistResponse(
    status: TestConstants.tWishlistStatus,
    count: 0,
    products: [],
  );

  // ─── PAYMENT TEST MODELS ─────────────────────────────────────────────────
  static PaymentModel get tPaymentModel => PaymentModel(
    clientSecret: TestConstants.tClientSecret,
    id: 'pi_123',
    amount: 100,
    currency: TestConstants.tCurrency,
    status: 'succeeded',
  );
}
