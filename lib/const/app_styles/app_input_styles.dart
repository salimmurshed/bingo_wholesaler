import '/presentation/widgets/alert/activation_dialog.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppInputStyles {
  /// [ActivationDialog]
  static InputDecoration blackOutlineBorder = InputDecoration(
    enabledBorder: outline,
    border: outline,
    focusedBorder: outline,
  );
  static InputDecoration blackOutlineBorderTest = InputDecoration(
    enabledBorder: outline,
    border: outline,
    focusedBorder: outline,
    fillColor: AppColors.redColor,
  );

  /// [NameTextField]
  static InputDecoration ashOutlineBorder = InputDecoration(
    // contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
    fillColor: AppColors.whiteColor,
    enabledBorder: AppInputStyles.outline,
    border: AppInputStyles.outline,
    focusedBorder: AppInputStyles.outline,
    disabledBorder: AppInputStyles.disableOutline,
    contentPadding:
        const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0, top: 12.0),
    isDense: true,
  );

  /// [NameTextField]
  static InputDecoration ashOutlineBorderDisable = InputDecoration(
    fillColor: AppColors.disableColor,
    enabledBorder: disableOutline,
    disabledBorder: disableOutline,
    contentPadding: const EdgeInsets.only(bottom: 4, left: 12),
    filled: true,
  );
  static InputDecoration ashOutlineBorderDisableWeb = InputDecoration(
    fillColor: AppColors.disableColorWeb,
    enabledBorder: disableOutline,
    disabledBorder: disableOutline,
    filled: true,
  );

  static OutlineInputBorder outline = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.cardShadow, width: 1.0),
  );

  static OutlineInputBorder disableOutline = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.borderColors),
  );
}
