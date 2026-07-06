import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String clientSecret;
  const Payment({required this.clientSecret});

  @override
  List<Object?> get props => [clientSecret];
}
