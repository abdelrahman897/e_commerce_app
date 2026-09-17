import 'package:e_commerce_app/core/handler/payment_handler/payment_interface_handler.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_data_source.dart';
import 'package:e_commerce_app/features/checkout/domain/repositories/payment_repository.dart';
import 'package:e_commerce_app/features/checkout/domain/usecases/create_payment_intent.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Infrastructure ────────────────────────────────────────────────────────
  PaymentInterfaceHandler,

  // ── Checkout Feature ──────────────────────────────────────────────────────
  PaymentDataSource,
  PaymentRepository,

  // ── Use Cases ─────────────────────────────────────────────────────────────
  CreatePaymentIntent,

  // Bloc
  PaymentBloc,

  // ── Third-party ───────────────────────────────────────────────────────────
  Stripe,
])
void main() {}
