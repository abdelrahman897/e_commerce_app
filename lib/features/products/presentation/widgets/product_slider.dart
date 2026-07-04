import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/core/widget/button/toggle_favourite_button.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductSlider extends StatefulWidget {
  final List<String> items;
  final VoidCallback? onTap;
  const ProductSlider({super.key, required this.items, this.onTap});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  late final CarouselSliderController _carouselSliderController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          controller: _carouselSliderController,
          items: widget.items
              .map(
                (element) => CustomCachedNetworkImage(
                  imageItemPath: element,
                  borderRadius: BorderRadius.circular(AppRadius.r16),
                  borderColor: context.customColorScheme.button,
                  imageHeight: AppHeight.h250,
                ),
              )
              .toList(),
          options: CarouselOptions(
            aspectRatio: AppWidth.w200 / AppHeight.h150,
            initialPage: 0,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          top: context.height * 0.01,
          right: context.width * 0.02,
          child: CustomBounceableButton(
            height: context.height * 0.036,
            width: context.width * 0.08,
            customChildWidget: ToggleFavouriteButton(onTap: widget.onTap),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: AppHeight.h8),
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.items.length,
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
