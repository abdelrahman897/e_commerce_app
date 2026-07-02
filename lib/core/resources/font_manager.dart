import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class FontWeightManager {
  FontWeightManager._();
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight extraBold = FontWeight.w900;
}

abstract final class FontSize {
  FontSize._();

  // Display
  static double get s57 => 57.0.sp;
  static double get s45 => 45.0.sp;
  static double get s36 => 36.0.sp;

  // Headline
  static double get s32 => 32.0.sp;
  static double get s28 => 28.0.sp;
  static double get s24 => 24.0.sp;

  // Title
  static double get s22 => 22.0.sp;
  static double get s20 => 20.0.sp;
  static double get s18 => 18.0.sp;
  static double get s16 => 16.0.sp;
  static double get s14 => 14.0.sp;

  // Body / Label
  static double get s12 => 12.0.sp;
  static double get s11 => 11.0.sp;
}
