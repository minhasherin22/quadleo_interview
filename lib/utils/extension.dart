import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double responsiveHeight(double h) {
    return MediaQuery.sizeOf(this).height * (h / 812);
  }

  double responsiveWidth(double w) {
    return MediaQuery.sizeOf(this).width * (w / 375);
  }

  double maxHeight() {
    return MediaQuery.sizeOf(this).height;
  }

  double maxWidth() {
    return MediaQuery.sizeOf(this).width;
  }
}
