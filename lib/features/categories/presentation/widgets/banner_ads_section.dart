import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerAdsSection extends StatelessWidget {
  final String categoryImageUrl;
  final String categoryTitle;
  const BannerAdsSection({
    super.key,
    required this.categoryImageUrl,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h100,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomCachedNetworkImage(
              imageItemPath: categoryImageUrl,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:  AppWidth.w8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryTitle, style: context.textTheme.titleSmall),
                CustomBounceableButton(
                  onTap: () {},
                  height: AppHeight.h30,
                  width: AppWidth.w100,
                  borderRadius: AppRadius.r10,
                  customChildWidget: Text(
                    context.appLocalization.shopNow,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.customColorScheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
