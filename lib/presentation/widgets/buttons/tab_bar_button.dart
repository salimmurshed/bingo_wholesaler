import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class TabBarButton extends StatelessWidget {
  final bool active;
  final String text;
  final double? width;
  final double height;
  final Color color;
  final bool fit;

  const TabBarButton(
      {this.text = "",
      this.width,
      this.height = 30.0,
      this.active = true,
      this.color = AppColors.activeButtonColor,
      this.fit = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.buttonWidgetPadding,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: active ? color : AppColors.inactiveButtonColor,
          borderRadius: AppRadius.buttonWidgetRadius,
        ),
        child: Center(
          child: Padding(
            padding: fit
                ? const EdgeInsets.symmetric(horizontal: 16.0)
                : EdgeInsets.zero,
            child: Text(
              text.toUpperCase(),
              style: AppTextStyles.buttonText.copyWith(
                  color: active ? AppColors.whiteColor : AppColors.blackColor),
            ),
          ),
        ),
      ),
    );
  }
}
