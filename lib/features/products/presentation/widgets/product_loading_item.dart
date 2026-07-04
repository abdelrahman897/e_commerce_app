import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ProductLoadingItem extends StatelessWidget {
  const ProductLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.grey,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.r16),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: context.customColorScheme.container,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(AppRadius.r16),
              ),
            ),
            child: Column(
              spacing: AppHeight.h8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: AppHeight.h10, endIndent: AppWidth.w20),
                Divider(height: AppHeight.h10, endIndent: AppWidth.w32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(height: AppHeight.h8, endIndent: AppWidth.w56),
                    Container(
                      height: context.height * 0.036,
                      width: context.width * 0.08,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
