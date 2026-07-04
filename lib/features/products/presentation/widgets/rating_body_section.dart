import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingBodySection extends StatelessWidget {
  final double productRatingAverage;
  final int productRatingsQuantity;
  final int numberOfProductSold;
  final Widget customChildWidget;
  const RatingBodySection({
    super.key,
    required this.productRatingAverage,
    required this.productRatingsQuantity,
    required this.numberOfProductSold,
    required this.customChildWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          context.read<LanguageCubit>().state.locale == Locale(AppConstants.ar)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.customColorScheme.container,
              border: Border.all(
                color: context.customColorScheme.button,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppRadius.r20),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppWidth.w16,
              vertical: AppHeight.h8,
            ),
            child: Text(
              "$numberOfProductSold Sold",
              style: context.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: AppWidth.w16,),
          Assets.icons.starIcn.svg(
          width: AppWidth.w16,
        height: AppHeight.h16,
          ),
          SizedBox(width: AppWidth.w2,),
          Text(
            "$productRatingAverage ($productRatingsQuantity)",
            style: context.textTheme.labelLarge,
          ),
          Spacer(),
          customChildWidget,
        ],
      ),
    );
  }
}
