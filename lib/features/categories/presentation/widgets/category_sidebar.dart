import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/category_item.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: context.customColorScheme.container,
          border: Border(
            top: BorderSide(
              width: AppWidth.w2,
              color: context.customColorScheme.button,
            ),
            left: context.read<LanguageCubit>().state.locale == Locale(AppConstants.en) ?   BorderSide(
              width: AppWidth.w2,
              color: context.customColorScheme.button,
            ):BorderSide.none ,
            right: context.read<LanguageCubit>().state.locale == Locale(AppConstants.ar) ? BorderSide(
              width: AppWidth.w2,
              color: context.customColorScheme.button,
            ):BorderSide.none ,
            bottom:  BorderSide(
              width: AppWidth.w2,
              color: context.customColorScheme.button,
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.r12),
            bottomLeft: Radius.circular(AppRadius.r12),
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
