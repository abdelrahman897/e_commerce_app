import 'package:e_commerce_app/features/cart/data/datasources/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_product_quantity.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Cart Feature ──────────────────────────────────────────────────────────
  CartDataSource,
  CartRepository,

  // ── Use Cases ─────────────────────────────────────────────────────────────
  GetCart,
  AddProductToCart,
  DeleteProductFromCart,
  UpdateProductQuantity,

  // Bloc
  CartBloc,
])
void main() {}
