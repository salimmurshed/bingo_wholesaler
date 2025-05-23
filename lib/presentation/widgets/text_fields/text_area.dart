import 'package:flutter/material.dart';

import '../../../const/all_const.dart';

class TextArea extends StatelessWidget {
  const TextArea(
      {this.controller, this.height = 80.0, this.readOnly = true, Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final double height;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        readOnly: readOnly,
        scrollPadding: EdgeInsets.zero,
        maxLines: 10,
        style: AppTextStyles.formTitleTextStyle
            .copyWith(color: AppColors.ashColor, fontWeight: FontWeight.normal),
        decoration: readOnly
            ? AppInputStyles.ashOutlineBorderDisable.copyWith(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12))
            : AppInputStyles.ashOutlineBorder.copyWith(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12),
                hintStyle: AppTextStyles.formFieldHintTextStyle,
                fillColor: AppColors.whiteColor,
                filled: true),
        controller: controller,
      ),
    );
  }
}
