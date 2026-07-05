import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_response.dart';

abstract interface class CartDataSource {
  Future<CartResponse> getCart();
  Future<CartResponse> deleteProduct({required CartParams params});
  Future<CartResponse> updateProduct({required CartParams params});
  Future<void> addProduct({required CartParams params});
}
