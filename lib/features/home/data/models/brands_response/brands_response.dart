import 'package:e_commerce_app/core/models/metadata_model.dart';
import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';
import 'brand_model.dart';

class BrandsResponse extends Equatable {
  final int results;
  final MetadataModel metadata;
  final List<BrandModel> brands;

  const BrandsResponse({
    required this.results,
    required this.metadata,
    required this.brands,
  });

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    return BrandsResponse(
      results: json[ApiKeys.results] as int,
      metadata: MetadataModel.fromJson(
        json[ApiKeys.metadata] as Map<String, dynamic>,
      ),
      brands: (json[ApiKeys.data] as List<dynamic>)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results, metadata, brands];
}
