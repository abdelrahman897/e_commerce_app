import 'package:e_commerce_app/core/responsive/device_type.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final DeviceType deviceType = DeviceType.fromWidth(screenWidth);

    return switch (deviceType) {
      DeviceType.desktop => (desktop ?? tablet ?? mobile)(context),

      DeviceType.tablet => (tablet ?? mobile)(context),

      DeviceType.mobile => (mobile)(context),
    };
  }
}
