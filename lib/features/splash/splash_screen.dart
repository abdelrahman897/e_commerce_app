import 'package:e_commerce_app/core/extensions/is_dark_mode.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    
    Navigator.pushReplacementNamed(context, Routes.mainOnboardingRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.isDarkMode
                ? Assets.images.darkRouteSplashBackgroundImg.provider()
                : Assets.images.lightRouteSplashBackgroundImg.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: context.isDarkMode
              ? Assets.images.darkRouteSplashScreenLogoImg.svg()
              : Assets.images.lightRouteSplashScreenLogoImg.svg(),
        ),
      ),
    );
  }
}
