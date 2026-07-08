import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/category_sidebar.dart';
import 'package:e_commerce_app/features/categories/presentation/widgets/sub_category_section.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabScreen extends StatefulWidget {
  const CategoriesTabScreen({super.key});

  @override
  State<CategoriesTabScreen> createState() => _CategoriesTabScreenState();
}

class _CategoriesTabScreenState extends State<CategoriesTabScreen> {
  late final HomeBloc _homeBloc;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _homeBloc = context.read<HomeBloc>();
      _homeBloc.add(GetAllCategoriesEvent());
    }
  }

  void _onCategorySelected(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, categoryState) {
        switch (categoryState) {
          case HomeLoadingState():
            return const Center(child: CircularProgressIndicator());
          case GetAllCategoriesSuccessState():
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: AppWidth.w12,
              children: [
                CategorySidebar(
                  categories: categoryState.categories,
                  selectedIndex: _selectedIndex,
                  onCategorySelected: _onCategorySelected,
                ),
                Expanded(
                  flex: 7,
                  child: SubCategorySection(
                    categoryTitle:
                        categoryState.categories[_selectedIndex].name,
                    categoryImageUrl:
                        categoryState.categories[_selectedIndex].imageUrl,
                  ),
                ),
              ],
            );

          case HomeFailureState():
            return FailureStateWidget(
              failureMessage: categoryState.failureMessage,
              textStyle: context.textTheme.bodyMedium,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
