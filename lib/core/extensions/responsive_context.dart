import 'package:e_commerce_app/core/responsive/device_type.dart';
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  DeviceType get deviceType =>
      DeviceType.fromWidth(MediaQuery.sizeOf(this).width);

  bool get isMobile => deviceType.isMobile;
  bool get isTablet => deviceType.isTablet;
  bool get isDesktop => deviceType.isDesktop;

  int get gridColumns => deviceType.gridColumns;
}
