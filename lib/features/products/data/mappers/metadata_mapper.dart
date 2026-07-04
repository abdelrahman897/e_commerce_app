import 'package:e_commerce_app/core/models/metadata_model.dart';
import 'package:e_commerce_app/features/products/domain/entities/metadata.dart';

extension MetadataMapper on MetadataModel {
  Metadata get toEntity => Metadata(
    currentPage: currentPage,
    numberOfPages: numberOfPages,
    limit: limit,
    nextPage: nextPage,
    prevPage: prevPage,
  );
}
