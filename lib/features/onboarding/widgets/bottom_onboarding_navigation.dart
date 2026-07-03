import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomOnboardingNavigation extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final int count;
  final bool isLastPage;
  final VoidCallback? onPressedPrev;
  final VoidCallback? onPressedNext;
  const BottomOnboardingNavigation({
    super.key,
    this.onPressedPrev,
    this.onPressedNext,
    required this.currentIndex,
    required this.pageController,
    required this.count,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: currentIndex != 0,
          child: CustomTextButton(
            onPressed: onPressedPrev,
            title: context.appLocalization.prev,
            colorText: ColorManager.grey,
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: count,
          effect: SwapEffect(
            activeDotColor: context.customColorScheme.button,
            dotColor: ColorManager.grey,
            radius: AppRadius.r8,
          ),
        ),

        CustomTextButton(
          onPressed: onPressedNext,
          title: isLastPage
              ? context.appLocalization.getStarted
              : context.appLocalization.next,
        ),
      ],
    );
  }
}

/*


*/
