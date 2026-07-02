import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.animations.emptyList.lottie());
  }
}
