import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class BrandCardItem extends StatelessWidget {
  final String title;
  final String imageItemPath;
  final VoidCallback? onTap;

  const BrandCardItem({
    super.key,
    required this.title,
    required this.imageItemPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Column(
        children: [
          CustomCachedNetworkImage(
            imageItemPath: imageItemPath,
            borderRadius: BorderRadius.circular(AppRadius.r24),
          ),
          SizedBox(height: AppHeight.h8),
          AutoSizeText(title, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
