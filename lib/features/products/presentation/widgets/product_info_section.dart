import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: context.height * 0.002),
        Text(
          _truncateTitle(description),
          style: context.textTheme.labelMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: context.height * 0.01),
        if (price != null)
          Row(
            spacing: AppWidth.w4,
            children: [
              Text(
                "EGP $price",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium,
              ),
              Text(
                "$priceBeforeDiscount EGP ",
                style: context.textTheme.labelSmall?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: context.customColorScheme.button,
                ),
              ),
            ],
          )
        else
          Text(
            "EGP $priceBeforeDiscount",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium,
          ),
        SizedBox(height: AppHeight.h2),
        Directionality(
          textDirection: context.read<LanguageCubit>().state.locale.languageCode == (AppConstants.ar) ?TextDirection.rtl:TextDirection.ltr,
          child: Row(
            children: [
              Text(
                context.appLocalization.reviews,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: AppWidth.w6),
              Text("($rating) ", style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              )),
              Assets.icons.starIcn.svg(
                width: AppWidth.w16,
                height: AppHeight.h16,
              ),
              Spacer(),
              IconButton(
                onPressed: onPressed,
                color: context.customColorScheme.button,
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: context.customColorScheme.button,
                  size: AppIconSize.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w4,
      AppHeight.h4,
      enableMediaQuery: false,
    );
  }
}
