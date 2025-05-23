import 'dart:ui' as ui;

import 'package:flutter/material.dart';

extension PercentSized on double {
  static double get pixelRatio => ui.window.devicePixelRatio;
  static Size get size => ui.window.physicalSize / pixelRatio;
  static double get width => size.width;
  static double get height => size.height;
  double get hp => (height * (this / 100));
  double get wp => (width * (this / 100));
}

//create gaps
extension Gap on double {
  Widget get giveHeight => SizedBox(
        height: this,
      );

  Widget get giveWidth => SizedBox(
        width: this,
      );
}
