import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/models/metadata_model.dart';

class CategoriesResponse extends Equatable {
  final int results;
  final MetadataModel metadata;
  final List<CategoryModel> categories;

  const CategoriesResponse({
    required this.results,
    required this.metadata,
    required this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      results: json[ApiKeys.results] as int,
      metadata: MetadataModel.fromJson(
        json[ApiKeys.metadata] as Map<String, dynamic>,
      ),
      categories: (json[ApiKeys.data] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object> get props => [results, metadata, categories];
}
