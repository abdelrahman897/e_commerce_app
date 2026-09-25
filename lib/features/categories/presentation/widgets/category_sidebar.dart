import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/category_item.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:flutter/material.dart';

class CategorySidebar extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  const CategorySidebar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final side = BorderSide(
      width: AppWidth.w2,
      color: context.customColorScheme.button,
    );
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: context.customColorScheme.container,
          border: BorderDirectional(top: side, bottom: side, start: side),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppRadius.r12),
            bottomStart: Radius.circular(AppRadius.r12),
          ),
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            final bool isSelected = index == selectedIndex;
            return CategoryItem(
              categoryTitle: category.name,
              isSelected: isSelected,
              onItemClick: () => onCategorySelected(index),
            );
          },
          itemCount: categories.length,
        ),
      ),
    );
  }
}
