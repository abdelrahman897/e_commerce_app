
import 'package:e_commerce_app/features/onboarding/widgets/bottom_onboarding_navigation.dart';
import 'package:e_commerce_app/features/onboarding/widgets/paragraph_section.dart';
import 'package:flutter/material.dart';

class OnboardingPageItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final PageController pageController;
  final String body;
  final int count;
  final bool isLastPage;
  final int currentIndex;
  final VoidCallback? onPressedPrev;
  final VoidCallback? onPressedNext;

  const OnboardingPageItem({
    super.key,
    required this.currentIndex,
    required this.imagePath,
    required this.title,
    required this.body,
    required this.count,
    required this.pageController,
    this.onPressedPrev,
    this.onPressedNext, required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath),
        ParagraphSection(title: title, body: body),
        const Spacer(),
        BottomOnboardingNavigation(
          currentIndex: currentIndex,
          pageController: pageController,
          count: count,
          isLastPage: isLastPage,
          onPressedNext: onPressedNext,
          onPressedPrev: onPressedPrev,
        ),
      ],
    );
  }
}
