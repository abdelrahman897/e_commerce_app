import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/state/loading_more_state_widget.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_card_item.dart';
import 'package:flutter/material.dart';

class BrandBodySection extends StatelessWidget {
  final List<Brand> brands;
  final bool isMaxPage;
  const BrandBodySection({
    super.key,
    required this.brands,
    required this.isMaxPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h270,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppWidth.w8,
          mainAxisSpacing: AppHeight.h8,
        ),
        itemCount: isMaxPage ? brands.length : brands.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= brands.length) {
            return const LoadingMoreStateWidget();
          }
          final brand = brands[index];
          return BrandCardItem(
            title: brand.name,
            imageItemPath: brand.imageUrl,
            onTap: () => Navigator.pushNamed(
              context,
              Routes.productRoute,
              arguments: {AppConstants.categoryId: null, AppConstants.brandId: brand.id}
            ),
          );
        },
      ),
    );
  }
}
