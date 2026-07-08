import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/categories/domain/entities/sub_category.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/banner_ads_section.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/sub_category_item.dart';
import 'package:flutter/material.dart';

class SubCategorySection extends StatelessWidget {
  final String categoryTitle;
  final String categoryImageUrl;
  const SubCategorySection({
    super.key,
    required this.categoryTitle,
    required this.categoryImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppHeight.h6,
      children: [
        Text(
          categoryTitle,
          style: context.textTheme.titleSmall?.copyWith(
            color: context.customColorScheme.button,
          ),
        ),
        BannerAdsSection(
          categoryImageUrl: categoryImageUrl,
          categoryTitle: categoryTitle,
        ),
        SizedBox(height: AppHeight.h10,),
        GridView.builder(
          shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppHeight.h12,
            crossAxisSpacing: AppWidth.w6,
          ),
          itemBuilder: (context, index) {
            final subCategory = SubCategory.subCategoryList[index];
            return SubCategoryItem(
              subCategoryImageUrl: subCategory.imageUrl,
              subCategoryTitle: subCategory.name,
              onSubCategoryItemTap: () {},
            );
          },
          itemCount: SubCategory.subCategoryList.length,
        ),
      ],
    );
  }
}
