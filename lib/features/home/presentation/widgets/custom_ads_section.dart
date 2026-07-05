import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomAdsSection extends StatefulWidget {
  final List<String> adsImagePath;
  final Duration autoPlayDuration;

  const CustomAdsSection({
    super.key,
    required this.adsImagePath,
    this.autoPlayDuration = const Duration(milliseconds: 2500),
  });

  @override
  State<CustomAdsSection> createState() => _CustomAdsSectionState();
}

class _CustomAdsSectionState extends State<CustomAdsSection> {
  int _currentIndex = 0;
  late final CarouselSliderController _carouselSliderController;
  @override
  void initState() {
    super.initState();
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
     if (widget.adsImagePath.isEmpty) {
      return const SizedBox.shrink();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          controller: _carouselSliderController,
          items: widget.adsImagePath
              .map(
                (element) => ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r16),
                  child: Image.asset(
                    element,
                    height: AppHeight.h200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: AppHeight.h200,
            initialPage: 0,
            enlargeCenterPage: true,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: AppHeight.h8),
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.adsImagePath.length,
            duration: const Duration(milliseconds: 300),
            effect: ExpandingDotsEffect(
              dotWidth: AppWidth.w8,
              dotHeight: AppHeight.h8,
              dotColor: ColorManager.white,
              paintStyle: PaintingStyle.fill,
              activeDotColor: context.customColorScheme.button,
            ),
          ),
        ),
      ],
    );
  }
}
