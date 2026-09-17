import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/profile.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_product.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/products/domain/entities/metadata.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'test_data.dart';

abstract class TestEntities {
  static User get tUser => const User(
    name: TestConstants.tName,
    email: TestConstants.tEmail,
    role: TestConstants.tRole,
  );
  static UserGoogle get tUserGoogle => const UserGoogle(
    id: TestConstants.tGoogleId,
    name: TestConstants.tGoogleName,
    email: TestConstants.tGoogleEmail,
    phoneNumber: TestConstants.tPhone,
  );

  static Profile get tProfile => Profile(
    name: TestConstants.tGoogleName,
    email: TestConstants.tGoogleEmail,
    phoneNumber: TestConstants.tPhone,
  );
  static Address get tAddress => Address(
    status: TestConstants.tStatus,
    message: TestConstants.tAddressSuccessMessage,
    addresses: [tAddressItemData],
  );
  static AddressItemData get tAddressItemData => AddressItemData(
    name: TestConstants.tAddressName,
    id: TestConstants.tId,
    details: TestConstants.tAddressDetails,
    city: TestConstants.tAddressCity,
  );

  static Category get tCategory => const Category(
    id: TestConstants.tCategoryId,
    name: TestConstants.tCategoryName,
    slug: TestConstants.tCategorySlug,
    imageUrl: TestConstants.tCategoryImageUrl,
  );

  static Brand get tBrand => const Brand(
    id: TestConstants.tBrandId,
    name: TestConstants.tBrandName,
    slug: TestConstants.tBrandSlug,
    imageUrl: TestConstants.tBrandImageUrl,
  );

  static CartProduct get tCartProduct => CartProduct(
    id: TestConstants.tProductId,
    title: TestConstants.tProductTitle,
    quantity: TestConstants.tProductQuantity,
    imageCoverUrl: TestConstants.tImageCoverUrl,
    category: tCategory,
    brand: tBrand,
    ratingsAverage: TestConstants.tRatingsAverage,
  );

  static CartItemData get tCartItemData => CartItemData(
    count: TestConstants.tCount,
    cartProduct: tCartProduct,
    price: TestConstants.tPrice,
  );

  static Cart get tCart => Cart(
    items: [tCartItemData],
    totalCartPrice: TestConstants.tTotalCartPrice,
  );

  static Cart get tEmptyCart => const Cart(items: [], totalCartPrice: 0);

  // ─── WISHLIST TEST ENTITIES ──────────────────────────────────────────────
  static ProductItem get tProductItem => ProductItem(
    sold: TestConstants.tProductSold,
    imagesUrl: TestConstants.tProductImagesUrl,
    ratingsQuantity: TestConstants.tProductRatingsQuantity,
    id: TestConstants.tProductId,
    title: TestConstants.tProductTitle,
    description: 'Test product description',
    quantity: TestConstants.tProductQuantity,
    price: TestConstants.tPrice,
    imageCoverUrl: TestConstants.tImageCoverUrl,
    category: tCategory,
    ratingsAverage: TestConstants.tRatingsAverage,
    priceAfterDiscount: 180,
  );

  static Products get tProducts => Products(
    metadata: const Metadata(
      currentPage: 1,
      numberOfPages: 1,
      limit: 20,
      nextPage: null,
      prevPage: null,
    ),
    products: tProductItems,
  );

  static List<ProductItem> get tProductItems => [tProductItem];
  static List<ProductItem> get tEmptyProductItems => [];

  // ─── PAYMENT TEST ENTITIES ───────────────────────────────────────────────
  static Payment get tPayment => const Payment(
    clientSecret: TestConstants.tClientSecret,
  );
}
