import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

import '../../../../const/web_devices.dart';
import '../../text_fields/name_text_field.dart';

class SaleTextField extends StatelessWidget {
  const SaleTextField(this.title, this.invoiceToController,
      {this.width,
      this.enable = false,
      this.readOnly = false,
      this.isNumber = false,
      this.isFloat = false,
      this.onChanged,
      Key? key})
      : super(key: key);
  final String title;
  final TextEditingController? invoiceToController;
  final double? width;
  final bool enable;
  final bool readOnly;
  final bool isNumber;
  final bool isFloat;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: device != ScreenSize.wide ? 90.0.wp : width ?? 29.0.wp,
      // height: 45.0,
      child: NameTextField(
        onChanged: onChanged,
        isNumber: isNumber,
        isFloat: isFloat,
        height: 45.0,
        enable: enable,
        readOnly: readOnly,
        controller: invoiceToController,
        hintStyle: AppTextStyles.formTitleTextStyleNormal,
        fieldName: title,
      ),
    );
  }
}
