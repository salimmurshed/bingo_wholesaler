import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../const/all_const.dart';
import '../../../widgets/text/common_text.dart';

Widget textField(
    {TextEditingController? controller,
    bool readOnly = false,
    TextAlign align = TextAlign.center}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 35.0,
      child: TextField(
        textAlign: align,
        readOnly: readOnly,
        enabled: !readOnly,
        controller: controller,
        style: AppTextStyles.formTitleTextStyleNormal,
        decoration: !readOnly
            ? AppInputStyles.ashOutlineBorder.copyWith(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
              )
            : AppInputStyles.ashOutlineBorderDisableWeb.copyWith(
                contentPadding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 12.0, top: 12.0)),
      ),
    ),
  );
}

Widget textFieldAmount(
    {TextEditingController? controller,
    ValueChanged<String>? func,
    required bool isView,
    bool isCenter = true}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 45.0,
      child: TextField(
        textAlign: isCenter ? TextAlign.center : TextAlign.right,
        enabled: isView,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
        ],
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        controller: controller,
        style: AppTextStyles.formTitleTextStyleNormal,
        decoration: AppInputStyles.ashOutlineBorder.copyWith(
          hintStyle: AppTextStyles.formTitleTextStyle.copyWith(
              color: AppColors.ashColor, fontWeight: FontWeight.normal),
        ),
        onChanged: (String v) {
          func!(v);
        },
      ),
    ),
  );
}

Widget summaryItem(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CommonText(
        title,
        style: AppTextStyles.retailerStoreCard.copyWith(height: 2),
      ),
      CommonText(
        value,
        style: AppTextStyles.retailerStoreCard.copyWith(height: 2),
      ),
    ],
  );
}
