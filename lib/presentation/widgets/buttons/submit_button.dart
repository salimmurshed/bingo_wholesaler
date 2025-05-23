import 'package:flutter/foundation.dart';

import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function()? onPressed;
  final bool active;
  final bool isPadZero;
  final String text;
  final double width;
  final double height;
  final Color color;
  final bool isRetailer;
  final bool isRadius;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final EdgeInsets? textPadding;

  const SubmitButton(
      {super.key,
      this.onPressed,
      this.text = "",
      this.width = 283.0,
      this.height = 30.0,
      this.active = true,
      this.isPadZero = false,
      this.color = AppColors.bingoGreen,
      this.isRetailer = true,
      this.isRadius = true,
      this.fontWeight,
      this.fontColor,
      this.textPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadZero ? EdgeInsets.zero : AppPaddings.buttonWidgetPadding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: textPadding,
          foregroundColor: active ? color : AppColors.inactiveButtonColor,
          backgroundColor: active ? color : AppColors.inactiveButtonColor,
          minimumSize: Size(width, height),
          // foregroundColor: active ? color : AppColors.inactiveButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: isRadius
                ? AppRadius.buttonWidgetRadius
                : AppRadius.buttonWidgetRadiusZero,
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Text(
          text.toUpperCase(),
          style: AppTextStyles.buttonText.copyWith(
              fontWeight:
                  fontWeight ?? (kIsWeb ? FontWeight.w600 : FontWeight.w500),
              color: fontColor ??
                  (active ? AppColors.whiteColor : AppColors.blackColor)),
        ),
      ),
    );
  }
}
