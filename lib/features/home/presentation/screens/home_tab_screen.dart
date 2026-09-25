import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brands_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/categories_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_ads_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/most_selling_section.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final List<String> _adsImageList = [
    Assets.images.oneAdBackgroundImg.path,
    Assets.images.twoAdBackgroundImg.path,
    Assets.images.threeAdBackgroundImg.path,
  ];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<HomeBloc>()
        ..add(GetCategoriesEvent(params: CategoryParams()))
        ..add(GetBrandsEvent(params: BrandParams()));
      context.read<ProductBloc>().add(
        GetProductsEvent(
          params: ProductParams(soldParam: AppStrings.soldParam),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAdsSection(adsImagePath: _adsImageList),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppHeight.h16)),
        const SliverToBoxAdapter(child: CategoriesSection()),
        SliverToBoxAdapter(child: SizedBox(height: AppHeight.h18)),
        const SliverToBoxAdapter(child: BrandsSection()),
        SliverToBoxAdapter(child: SizedBox(height: AppHeight.h18)),
        const SliverToBoxAdapter(child: MostSellingSection()),
      ],
    );
  }
}
