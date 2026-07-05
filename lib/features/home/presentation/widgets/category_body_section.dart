import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/state/loading_more_state_widget.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_card_item.dart';
import 'package:flutter/material.dart';

class CategoryBodySection extends StatelessWidget {
  final List<Category> categories;
  final bool isMaxPage;
  const CategoryBodySection({
    super.key,
    required this.categories,
    required this.isMaxPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h270,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppHeight.h10,
          mainAxisSpacing: AppWidth.w10,
        ),
        itemCount: isMaxPage ? categories.length : categories.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= categories.length) {
            return const LoadingMoreStateWidget();
          }
          final category = categories[index];
          return CategoryCardItem(
            title: category.name,
            imageItemPath: category.imageUrl,
            onTap: () => Navigator.pushNamed(
              context,
              Routes.productRoute,
              arguments: {AppConstants.categoryId: category.id, AppConstants.brandId: null},
            ),
          );
        },
      ),
    );
  }
}
