import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../const/all_const.dart';

class CommonText extends StatelessWidget {
  const CommonText(this.fieldName, {this.style, Key? key}) : super(key: key);
  final String fieldName;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: fieldName.replaceAll('*', ''),
          style: style ??
              AppTextStyles.formTitleTextStyle
                  .copyWith(color: AppColors.blackColor),
          children: [
            if (fieldName.contains('*'))
              TextSpan(
                  text: '*',
                  style: AppTextStyles.formTitleTextStyle
                      .copyWith(color: AppColors.redColor))
          ]),
    );
  }
}
