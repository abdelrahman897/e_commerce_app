import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryTitle;
  final bool isSelected;
  final VoidCallback onItemClick;
  const CategoryItem({
    super.key,
    required this.categoryTitle,
    required this.isSelected,
    required this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        color: isSelected
            ? context.customColorScheme.primary
            : ColorManager.transparent,
        padding:  EdgeInsets.all(AppWidth.w8),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: isSelected,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:  AppWidth.w4 ,),
                    child: Container(
                      width: AppWidth.w8,
                      height: AppHeight.h60,
                      decoration: BoxDecoration(
                        color: context.customColorScheme.button,
                        borderRadius: BorderRadius.circular(AppRadius.r100),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    categoryTitle,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.customColorScheme.button,
                    ),
                  ),
                ),
              ],
            ).setHorizontalAndVerticalPadding(
              context,
              AppWidth.w8,
              AppHeight.h16,
              enableMediaQuery: false,
            ),
      ),
    );
  }
}
