import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  final bool isComplete;
  const OnboardingState({required this.isComplete});

  @override
  List<Object?> get props => [isComplete];
}
