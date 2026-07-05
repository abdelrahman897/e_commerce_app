import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_card_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryLoadingWidget extends StatelessWidget {
  static const int _skeletonCount = 6;
  static final List<Category> _skeletonItems = List.generate(
    _skeletonCount,
    (_) => Category.skeleton(),
  );
  const CategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h250,
      child: Skeletonizer(
        enabled: true,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppWidth.w8,
            mainAxisSpacing: AppHeight.h8,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: _skeletonCount,
          itemBuilder: (context, index) => CategoryCardItem(
            title: _skeletonItems[index].name,
            imageItemPath: _skeletonItems[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
