import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class NetworkImageError extends StatelessWidget {
  const NetworkImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppHeight.h2,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: context.customColorScheme.text,
            ),
            Text(
              context.appLocalization.notFound,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
