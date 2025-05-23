import 'package:flutter/material.dart';

import '../../presentation/widgets/utils_folder/validation_text.dart';
import '../app_strings.dart';
import '../utils.dart';

extension ConvertRequired on String {
  String get isRequired => "${this} *";
}

extension ValidationWidget on String {
  Widget validate() {
    return isNotEmpty ? ValidationText(this) : const SizedBox();
  }
}

extension E on String {
  String lastChars(int n) => "${AppString.stars}${substring(length - n)}";
  String emptyCheck() => isNotEmpty ? this : "-";
}

extension P on String {
  String setDeci() => contains(".") ? this : "${this}.00";
}
