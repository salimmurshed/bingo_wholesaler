import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final Function()? onPressed;
  final bool active;
  final String text;
  final double width;
  final double height;

  const CancelButton({
    Key? key,
    this.onPressed,
    this.text = "",
    this.width = 283.0,
    this.height = 30.0,
    this.active = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.buttonWidgetPadding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.disableColor,
          elevation: 0,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.blackColor),
            borderRadius: AppRadius.buttonWidgetRadius,
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Text(
          text.toUpperCase(),
          style: AppTextStyles.buttonText.copyWith(color: AppColors.blackColor),
        ),
      ),
    );
  }
}
