import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/is_dark_mode.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/button/custom_text_button.dart';
import 'package:e_commerce_app/features/onboarding/domain/onboarding_entity.dart';
import 'package:e_commerce_app/features/onboarding/widgets/onboarding_app_bar.dart';
import 'package:e_commerce_app/features/onboarding/widgets/onboarding_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPagesScreen extends StatefulWidget {
  const OnboardingPagesScreen({super.key});

  @override
  State<OnboardingPagesScreen> createState() => _OnboardingPagesScreenState();
}

class _OnboardingPagesScreenState extends State<OnboardingPagesScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;
  bool _isNavigating = false;
  late final List<OnboardingEntity> _onboardingList;

  @override
  void initState() {
    super.initState();
    _onboardingList = OnboardingEntity.onboardingList;
    _pageController = PageController();
    _pageController.addListener(_onPageChange);
  }

  void _onPageChange() {
    final page = _pageController.page;
    if (page == null) return;
    if (page % 1 == 0) {
      setState(() => _currentIndex = page.toInt());
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    if (_isNavigating) return;
    _isNavigating = true;
    await context.read<OnboardingCubit>().completeOnboarding();
    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  void _goToNextPage() {
    _pageController.animateToPage(
      _currentIndex + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _goToPreviousPage() {
    _pageController.animateToPage(
      _currentIndex - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool get _isLastPage => _currentIndex == _onboardingList.length - 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: OnboardingAppBar(
          customLeadingWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${_currentIndex+1}',
                  style: context.textTheme.titleMedium,
                ),
                TextSpan(
                  text: '/${_onboardingList.length}',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ],
            ),
          ).setHorizontalPaddingOnWidget(AppWidth.w6),
          customActionsWidgets: [
            CustomTextButton(
              onPressed: () => _finishOnboarding(),
              title: context.appLocalization.skip,
            ),
          ],
        ),
        body:
            PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final item = _onboardingList[index];
                return OnboardingPageItem(
                  title: item.title(context.appLocalization),
                  body: item.body(context.appLocalization),
                  count: _onboardingList.length,
                  currentIndex: _currentIndex,
                  imagePath: context.isDarkMode
                      ? item.imageDarkPath
                      : item.imageLightPath,
                  pageController: _pageController,
                  onPressedNext: _isLastPage
                      ? () => _finishOnboarding()
                      : _goToNextPage,
                  onPressedPrev: _goToPreviousPage,
                  isLastPage: _isLastPage,
                );
              },
              itemCount: _onboardingList.length,
            ).setHorizontalAndVerticalPadding(
              context,
              AppWidth.w16,
              AppHeight.h8,
              enableMediaQuery: false,
            ),
      ),
    );
  }
}
