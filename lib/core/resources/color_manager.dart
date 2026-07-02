import 'package:flutter/material.dart';

// Common Color:
abstract final class ColorManager {
  ColorManager._();
  static const Color blue = Color(0xFF0E3A99);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightWhite = Color(0xFFF4F7FF);
  static const Color black = Color(0xFF121212);
  static const Color lightBlack = Color(0xFF1E1E1E);
  static const Color grey = Color(0xFFADADAD);
  static const Color transparent = Colors.transparent;
  static const Color red = Color(0xFFE61F34);
  static const Color green = Color(0xFF42C83C);
  static const Color darkRed = Color(0xFFBB3219);
  static const Color orange = Color(0XFFF89209);
  static const Color lightBlue = Color(0XFF1E88E5);
  static const Color darkWhite = Color(0XFFEDF1F5);
}

// Light Theme:
abstract final class LightColors {
  LightColors._();
  static const Color primary = ColorManager.white;
  static const Color bottom = ColorManager.blue;
  static const Color button = ColorManager.blue;
  static const Color onButton = ColorManager.white;
  static const Color filledTextForm = ColorManager.white;
  static const Color text = ColorManager.black;
  static const Color foreground = ColorManager.blue;
  static const Color hintText = ColorManager.lightBlack;
  static const Color outLine = ColorManager.lightBlack;
  static const Color icon = ColorManager.white;
  static const Color container = ColorManager.lightWhite;
}

// Dark Theme:
abstract final class DarkColors {
  DarkColors._();
  static const Color primary = ColorManager.black;
  static const Color bottom = ColorManager.lightBlack;
  static const Color foreground = ColorManager.white;
  static const Color bottun = ColorManager.lightBlue;
  static const Color filledTextForm = ColorManager.lightBlack;
  static const Color onButton = ColorManager.white;
  static const Color text = ColorManager.white;
  static const Color hintText = ColorManager.lightBlack;
  static const Color outLine = ColorManager.lightBlack;
  static const Color icon = ColorManager.white;
  static const Color container = ColorManager.lightBlack;
}
