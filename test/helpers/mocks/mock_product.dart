import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_data_source.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/domain/usecases/get_products.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Infrastructure ────────────────────────────────────────────────────────
  ApiInterface,
  NetworkInfo,

  // ── Products Feature ──────────────────────────────────────────────────────
  ProductDataSource,
  ProductRepository,

  // ── Use Cases ─────────────────────────────────────────────────────────────
  GetProducts,

  // Bloc
  ProductBloc,
])
void main() {}
