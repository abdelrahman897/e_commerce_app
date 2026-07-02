import 'package:e_commerce_app/core/responsive/break_points.dart';

enum DeviceType {
  tablet,
  mobile,
  desktop;

  static DeviceType fromWidth(double width) {
    if (width >= BreakPoints.desktop) return DeviceType.desktop;
    if (width >= BreakPoints.mobile) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  int get gridColumns => switch (this) {
    DeviceType.mobile => 2,
    DeviceType.tablet => 4,
    DeviceType.desktop => 6,
  };

  // shortcut
  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop;
}
