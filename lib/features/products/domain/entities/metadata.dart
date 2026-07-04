import 'package:equatable/equatable.dart';

class Metadata extends Equatable {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;
  final int? prevPage;
  const Metadata({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
    this.prevPage,
  });

  @override
  List<Object?> get props => [
    currentPage,
    numberOfPages,
    limit,
    nextPage,
    prevPage,
  ];
}
