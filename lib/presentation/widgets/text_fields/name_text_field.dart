import '../text/common_text.dart';
import 'package:flutter/foundation.dart';
import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final TextEditingController? controller;
  final bool isError;
  final bool obscureText;
  final bool readOnly;
  final bool isNumber;
  final bool isFloat;
  final bool enable;
  final bool isCapital;
  final int maxLine;
  final Widget? widget;
  final FocusNode? focus;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final double height;
  final bool isCalender;

  const NameTextField({
    Key? key,
    this.controller,
    this.fieldName = "",
    this.hintText = "",
    this.isError = false,
    this.obscureText = false,
    this.readOnly = false,
    this.isNumber = false,
    this.isFloat = false,
    this.enable = true,
    this.isCapital = false,
    this.maxLine = 1,
    this.onChanged,
    this.focus,
    this.onTap,
    this.widget,
    this.textInputAction,
    this.style,
    this.hintStyle,
    this.height = 45.0,
    this.isCalender = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldName.isEmpty
              ? const SizedBox()
              : style != null
                  ? CommonText(fieldName, style: style)
                  : CommonText(
                      fieldName,
                      style: AppTextStyles.formTitleTextStyle
                          .copyWith(color: AppColors.blackColor),
                    ),
          if (fieldName.isNotEmpty) kIsWeb ? 4.0.giveHeight : 10.0.giveHeight,
          SizedBox(
            height: kIsWeb
                ? 35 * (maxLine == 1 ? 1 : 3)
                : maxLine > 4
                    ? null
                    : height * maxLine - (45 * (maxLine - 1)),
            child: TextFormField(
              focusNode: focus,
              textInputAction: textInputAction,
              textCapitalization: isCapital
                  ? TextCapitalization.sentences
                  : TextCapitalization.none,
              scrollPadding: EdgeInsets.zero,
              onChanged: onChanged,
              onTap: onTap,
              maxLines: maxLine,
              style: !enable
                  ? AppTextStyles.formTitleTextStyleNormal
                  : hintStyle != null
                      ? hintStyle?.copyWith(decoration: TextDecoration.none)
                      : AppTextStyles.formFieldTextStyle.copyWith(
                          fontWeight:
                              kIsWeb ? FontWeight.w900 : FontWeight.w500,
                          color: enable
                              ? AppColors.blackColor
                              : AppColors.ashColor),
              enabled: enable,
              keyboardType: isNumber
                  ? const TextInputType.numberWithOptions(
                      decimal: true, signed: false)
                  : TextInputType.text,
              readOnly: readOnly,
              obscureText: obscureText,
              inputFormatters: [
                if (kIsWeb && isNumber) FilteringTextInputFormatter.digitsOnly,
                if (kIsWeb && isFloat)
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                isNumber
                    ? FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]+.?[0-9]*'))
                    : FilteringTextInputFormatter.deny("   "),
              ],
              decoration: widget != null
                  ? AppInputStyles.ashOutlineBorder.copyWith(
                      suffixIcon: widget,
                      isDense: true,
                    )
                  : enable
                      ? AppInputStyles.ashOutlineBorder.copyWith(
                          isDense: true,
                          contentPadding: kIsWeb
                              ? const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 12)
                              : const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 12),
                          hintText: hintText,
                          hintStyle: AppTextStyles.formFieldHintTextStyle,
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          suffixIcon: isCalender
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: AppColors.ashColor,
                                  ),
                                )
                              : null,
                        )
                      : kIsWeb
                          ? AppInputStyles.ashOutlineBorderDisableWeb.copyWith(
                              suffixIcon: isCalender
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: AppColors.ashColor,
                                      ),
                                    )
                                  : null,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 12))
                          : AppInputStyles.ashOutlineBorderDisable.copyWith(
                              isDense: false,
                            ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
