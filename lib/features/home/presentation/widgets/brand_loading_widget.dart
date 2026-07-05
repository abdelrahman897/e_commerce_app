import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_card_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BrandLoadingWidget extends StatelessWidget {
  static const int _skeletonCount = 6;
  static final List<Brand> _skeletonItems = List.generate(
    _skeletonCount,
    (_) => Brand.skeleton(),
  );
  const BrandLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h250,
      child: Skeletonizer(
        enabled: true,
        child: SizedBox(
          height: AppHeight.h250,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppWidth.w8,
              mainAxisSpacing: AppHeight.h8,
            ),
            itemCount: _skeletonItems.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final brand = _skeletonItems[index];
              return BrandCardItem(
                title: brand.name,
                imageItemPath: brand.imageUrl,
              );
            },
          ),
        ),
      ),
    );
  }
}
