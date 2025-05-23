import 'package:flutter/material.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_styles/app_text_styles.dart';

class ValidationText extends StatelessWidget {
  const ValidationText(this.text, {this.color = AppColors.redColor, super.key});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.errorTextStyle.copyWith(color: color),
    );
  }
}
