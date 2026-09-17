import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/add_product_to_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/delete_product_from_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Infrastructure ────────────────────────────────────────────────────────
  ApiInterface,
  NetworkInfo,

  // ── Wishlist Feature ──────────────────────────────────────────────────────
  WishlistLocalDataSource,
  WishlistRemoteDataSource,
  WishlistRepository,

  // ── Use Cases ─────────────────────────────────────────────────────────────
  GetWishlist,
  AddProductToWishlist,
  DeleteProductFromWishlist,

  // Bloc
  WishlistBloc,
])
void main() {}
