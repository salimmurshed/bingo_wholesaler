import '/main.dart';
import 'package:flutter/cupertino.dart';

enum ScreenSize { small, medium, wide }

ScreenSize device = ScreenSize.small;

void changedDeviceOrientation(BuildContext context) {
  if (MediaQuery.of(context).size.width < 475) {
    device = ScreenSize.small;
  } else if (MediaQuery.of(context).size.width < 1000) {
    device = ScreenSize.medium;
  } else {
    device = ScreenSize.wide;
  }
}
