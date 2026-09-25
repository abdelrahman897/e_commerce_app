import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';


class ProductInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final double? price;
  final double priceBeforeDiscount;
  final double rating;
  final VoidCallback? onPressed;
  const ProductInfoSection({
    super.key,
    required this.title,
    required this.description,
    this.price,
    required this.priceBeforeDiscount,
    required this.rating,
    this.onPressed,
  });

  String _truncateTitle(String text) {
    final words = text.split(' ');
    if (words.length <= 4) return text;
    return '${words.sublist(0, 4).join(' ')}..';
  }

  String _formatPrice(double value) => value.toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode == AppConstants.ar;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _truncateTitle(title),
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppHeight.h8),
        Text(
          _truncateTitle(description),
          style: context.textTheme.labelMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppHeight.h12),
        if (price != null)
          Row(
            spacing: AppWidth.w16,
            children: [
              Text(
                'EGP ${_formatPrice(price!)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
              ),
              Text(
                '${_formatPrice(priceBeforeDiscount)} EGP',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.customColorScheme.button,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: context.customColorScheme.button,
                ),
              ),
            ],
          )
        else
          Text(
            'EGP ${_formatPrice(priceBeforeDiscount)}',
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          ),
        SizedBox(height: AppHeight.h8),
        Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Row(
            children: [
              Text(
                context.appLocalization.reviews,
                style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
              ),
              SizedBox(width: AppWidth.w2),
              Text(
                "($rating) ",
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Assets.icons.starIcn.svg(
                width: AppWidth.w16,
                height: AppHeight.h16,
              ),
              const Spacer(),
              IconButton(
                onPressed: onPressed,
                padding: EdgeInsets.zero,
  constraints: const BoxConstraints(),
                color: context.customColorScheme.button,
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: context.customColorScheme.button,
                  size: AppIconSize.large,
                ),
              ),
            ],
          ),
        ),
      ],
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w8,
      AppHeight.h10,
      enableMediaQuery: false,
    );
  }
}
