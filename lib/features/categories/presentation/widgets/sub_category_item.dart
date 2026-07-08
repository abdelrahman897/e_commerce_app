import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final String subCategoryTitle;
  final VoidCallback? onSubCategoryItemTap;
  final String subCategoryImageUrl;
  const SubCategoryItem({
    super.key,
    required this.subCategoryTitle,
    this.onSubCategoryItemTap,
    required this.subCategoryImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubCategoryItemTap,
      child: Column(
        spacing: AppHeight.h6,
        children: [
          Expanded(child: Image.asset(subCategoryImageUrl, fit: BoxFit.cover)),
          Text(
            subCategoryTitle,
            style: context.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
