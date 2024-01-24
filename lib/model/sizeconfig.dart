import 'package:flutter/material.dart';

class SizeConfig {
  static final MediaQueryData _mediaQueryData =
      MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first);
  static double screenWidth = _mediaQueryData.size.width;
  static double screenHeight = _mediaQueryData.size.height;
  static double blockSizeHorizontal = screenWidth / 100;
  static double blockSizeVertical = screenHeight / 100;
}
