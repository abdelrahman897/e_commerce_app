import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:flutter/material.dart';

extension PaddingtoWidget on Widget {
  Widget setHorizontalPaddingOnWidget(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget setHorizontalPadding(
    BuildContext context,
    double value, {
    bool enableMediaQuery = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: enableMediaQuery ? context.width * value : value,
      ),
      child: this,
    );
  }

  Widget setVerticalPadding(
    BuildContext context,
    double value, {
    bool enableMediaQuery = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: enableMediaQuery ? context.width * value : value,
      ),
      child: this,
    );
  }

  Widget setHorizontalAndVerticalPadding(
    BuildContext context,
    double widthValue,
    double heightValue, {
    bool enableMediaQuery = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: enableMediaQuery
            ? context.width * widthValue
            : widthValue,
        vertical: enableMediaQuery
            ? context.height * heightValue
            : heightValue,
      ),
      child: this,
    );
  }

  Widget setOnlyPadding(
    BuildContext context,
    double top,
    double down,
    double right,
    double left, {
    bool enableMediaQuery = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: enableMediaQuery ? context.height * top : top,
        bottom: enableMediaQuery ? context.height * down : down,
        right: enableMediaQuery ? context.width * right : right,
        left: enableMediaQuery ? context.width * left : left,
      ),
      child: this,
    );
  }
}
