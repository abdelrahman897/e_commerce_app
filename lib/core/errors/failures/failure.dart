import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String message;
  const Failure({this.statusCode, required this.message});
  @override
  String toString() => '$runtimeType(code: $statusCode, message: $message)';

  @override
  List<Object?> get props => [statusCode, message];
}
