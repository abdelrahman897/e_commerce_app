import 'test_data.dart';

abstract class TestJson {
  TestJson._();
  static Map<String, dynamic> get authenticationSuccess => {
    'message': 'Authentication successful',
    'user': {'name': 'Ahmed', 'email': 'ahmed1234@gmail.com', 'role': 'user'},
    'token': 'test_token_123',
    'statusMsg': null,
  };

  static Map<String, dynamic> get authenticationWithNoToken => {
    'message': 'OTP sent',
    'user': null,
    'token': null,
    'statusMsg': 'pending',
  };
  static Map<String, dynamic> get addressSuccessResponse => {
    'status': TestConstants.tStatus,
    'message': TestConstants.tAddressSuccessMessage,
    'data': addressItemDataSuccessResponse,
  };
  static List<Map<String, dynamic>> get addressItemDataSuccessResponse => [
    {
      '_id': TestConstants.tId,
      'name': TestConstants.tName,
      'details': TestConstants.tAddressDetails,
      'phone': TestConstants.tPhone,
      'city': TestConstants.tAddressCity,
    },
  ];
  static Map<String, dynamic> get addressEmptySuccessResponse => {
    'status': TestConstants.tStatus,
    'message': TestConstants.tAddressEmptySuccessMessage,
    'data': [],
  };

  static Map<String, dynamic> get cartSuccessResponse => {
    'status': TestConstants.tCartStatus,
    'numOfCartItems': TestConstants.tNumOfCartItems,
    'cartId': TestConstants.tCartId,
    'data': cartModelSuccessResponse,
  };

  static Map<String, dynamic> get cartEmptySuccessResponse => {
    'status': TestConstants.tCartStatus,
    'numOfCartItems': 0,
    'cartId': TestConstants.tCartId,
    'data': cartEmptyModelResponse,
  };

  static Map<String, dynamic> get cartModelSuccessResponse => {
    '_id': TestConstants.tCartId,
    'cartOwner': TestConstants.tCartOwnerId,
    'products': [cartItemSuccessResponse],
    'totalCartPrice': TestConstants.tTotalCartPrice,
  };

  static Map<String, dynamic> get cartEmptyModelResponse => {
    '_id': TestConstants.tCartId,
    'cartOwner': TestConstants.tCartOwnerId,
    'products': <Map<String, dynamic>>[],
    'totalCartPrice': 0,
  };

  static Map<String, dynamic> get cartItemSuccessResponse => {
    'count': TestConstants.tCount,
    '_id': TestConstants.tCartItemId,
    'product': cartProductSuccessResponse,
    'price': TestConstants.tPrice,
  };

  static Map<String, dynamic> get cartProductSuccessResponse => {
    '_id': TestConstants.tProductId,
    'title': TestConstants.tProductTitle,
    'quantity': TestConstants.tProductQuantity,
    'imageCover': TestConstants.tImageCoverUrl,
    'category': {
      '_id': TestConstants.tCategoryId,
      'name': TestConstants.tCategoryName,
      'slug': TestConstants.tCategorySlug,
      'image': TestConstants.tCategoryImageUrl,
    },
    'brand': {
      '_id': TestConstants.tBrandId,
      'name': TestConstants.tBrandName,
      'slug': TestConstants.tBrandSlug,
      'image': TestConstants.tBrandImageUrl,
    },
    'ratingsAverage': TestConstants.tRatingsAverage,
  };

  // ─── WISHLIST JSON ───────────────────────────────────────────────────────
  static Map<String, dynamic> get wishlistSuccessResponse => {
    'status': TestConstants.tWishlistStatus,
    'count': TestConstants.tWishlistCount,
    'data': [productItemSuccessResponse],
  };

  static Map<String, dynamic> get wishlistEmptySuccessResponse => {
    'status': TestConstants.tWishlistStatus,
    'count': 0,
    'data': <Map<String, dynamic>>[],
  };

  static Map<String, dynamic> get productItemSuccessResponse => {
    'sold': TestConstants.tProductSold,
    'images': TestConstants.tProductImagesUrl,
    'ratingsQuantity': TestConstants.tProductRatingsQuantity,
    '_id': TestConstants.tProductId,
    'title': TestConstants.tProductTitle,
    'slug': TestConstants.tProductSlug,
    'description': 'Test product description',
    'quantity': TestConstants.tProductQuantity,
    'price': TestConstants.tPrice,
    'imageCover': TestConstants.tImageCoverUrl,
    'category': {
      '_id': TestConstants.tCategoryId,
      'name': TestConstants.tCategoryName,
      'slug': TestConstants.tCategorySlug,
      'image': TestConstants.tCategoryImageUrl,
    },
    'brand': {
      '_id': TestConstants.tBrandId,
      'name': TestConstants.tBrandName,
      'slug': TestConstants.tBrandSlug,
      'image': TestConstants.tBrandImageUrl,
    },
    'ratingsAverage': TestConstants.tRatingsAverage,
    'createdAt': '2024-01-01T00:00:00.000Z',
    'updatedAt': '2024-01-02T00:00:00.000Z',
    'priceAfterDiscount': 180,
  };

  // ─── PRODUCTS JSON ────────────────────────────────────────────────────────
  static Map<String, dynamic> get productsSuccessResponse => {
    'results': 1,
    'metadata': {
      'currentPage': 1,
      'numberOfPages': 1,
      'limit': 20,
      'nextPage': null,
      'prevPage': null,
    },
    'data': [productItemSuccessResponse],
  };

  static Map<String, dynamic> get productsEmptyResponse => {
    'results': 0,
    'metadata': {
      'currentPage': 1,
      'numberOfPages': 0,
      'limit': 20,
      'nextPage': null,
      'prevPage': null,
    },
    'data': <Map<String, dynamic>>[],
  };

  static Map<String, dynamic> get productsMultiplePageResponse => {
    'results': 2,
    'metadata': {
      'currentPage': 2,
      'numberOfPages': 3,
      'limit': 20,
      'nextPage': 3,
      'prevPage': 1,
    },
    'data': [productItemSuccessResponse, productItemSuccessResponse],
  };

  // ─── PAYMENT JSON ────────────────────────────────────────────────────────
  static Map<String, dynamic> get paymentSuccessResponse => {
    'id': 'pi_123',
    'object': 'payment_intent',
    'amount': 10000,
    'amount_capturable': 0,
    'amount_received': 0,
    'client_secret': TestConstants.tClientSecret,
    'currency': TestConstants.tCurrency,
    'status': 'succeeded',
    'capture_method': 'automatic',
    'confirmation_method': 'automatic',
    'livemode': false,
    'payment_method_types': ['card'],
  };
}
