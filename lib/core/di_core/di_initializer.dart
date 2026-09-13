import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/utils/date_formatter.dart';
import 'package:e_commerce_app/features/authentication/di/authentication_di.dart';
import 'package:e_commerce_app/features/cart/di/cart_di.dart';
import 'package:e_commerce_app/features/checkout/di/payment_di.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';
import 'package:e_commerce_app/features/home/di/home_di.dart';
import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/products/di/product_di.dart';
import 'package:e_commerce_app/features/wishlist/di/wishlist_di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

abstract final class DiInitializer {
  DiInitializer._();

  static Future<void> init() async {
    final storageDirectory = kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          );

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: storageDirectory,
    );
    await Hive.initFlutter();
    Hive
      ..registerAdapter(BrandModelAdapter())
      ..registerAdapter(CategoryModelAdapter())
      ..registerAdapter(ProductItemModelAdapter());
    await dotenv.load();
    await AppDiCore.setup();
    DateFormatter.initialize();
    Stripe.publishableKey = EnvKeys.publishableKey;
    AuthenticationDi.setup();
    HomeDi.setup();
    ProductDi.setup();
    WishlistDi.setup();
    PaymentDi.setup();
    CartDi.setup();
  }
}
