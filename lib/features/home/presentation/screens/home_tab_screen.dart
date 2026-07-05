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
  bool onCategoryTapViewAll = false;
  bool onBrandTapViewAll = false;
  bool onMostSellingTapViewAll = false;
  late final HomeBloc _homeBloc;
  late final ProductBloc _productBloc;
  final List<String> _adsImageList = [
    Assets.images.oneAdBackgroundImg.path,
    Assets.images.twoAdBackgroundImg.path,
    Assets.images.threeAdBackgroundImg.path,
  ];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _homeBloc = context.read<HomeBloc>();
      _homeBloc.add(GetCategoriesEvent(params: CategoryParams()));
      _homeBloc.add(GetBrandsEvent(params: BrandParams()));
      _productBloc = context.read<ProductBloc>();
      _productBloc.add(
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
        SliverToBoxAdapter(
          child: CategoriesSection(
            homeBloc: _homeBloc,
            onCategoryTapViewAll: onCategoryTapViewAll,
            onCategoryPressed: () {
              setState(() {
                onCategoryTapViewAll = true;
              });
              _homeBloc.add(
                CategoriesLoadMoreEvent(
                  params: CategoryParams(
                    pageNumber: (_homeBloc.currentCategoryPage + 1).toString(),
                  ),
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppHeight.h16)),
        SliverToBoxAdapter(
          child: BrandsSection(
            homeBloc: _homeBloc,
            onBrandTapViewAll: onBrandTapViewAll,
            onBrandPressed: () {
              setState(() {
                onBrandTapViewAll = true;
              });
              _homeBloc.add(
                BrandsLoadMoreEvent(
                  params: BrandParams(
                    pageNumber: (_homeBloc.currentBrandPage + 1).toString(),
                  ),
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppHeight.h16)),
        SliverToBoxAdapter(
          child: MostSellingSection(
            onMostSellingTapViewAll: onMostSellingTapViewAll,
            productBloc: _productBloc,
            onMostSellingPressed: () {
              context.read<ProductBloc>().add(
                GetProductsEvent(
                  params: ProductParams(
                    pageNumber: "2",
                    soldParam: AppStrings.soldParam,
                  ),
                  isLoadMore: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
