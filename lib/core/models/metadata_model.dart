import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

class MetadataModel extends Equatable {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;
  final int? prevPage;
  const MetadataModel({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
    this.prevPage,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) => MetadataModel(
    currentPage: json[ApiKeys.currentPage] as int,
    numberOfPages: json[ApiKeys.numberOfPages] as int,
    limit: json[ApiKeys.limit] as int,
    nextPage: json[ApiKeys.nextPage] as int?,
    prevPage: json[ApiKeys.prevPage] as int?,
  );

  @override
  List<Object?> get props => [
    currentPage,
    numberOfPages,
    limit,
    nextPage,
    prevPage,
  ];
}
