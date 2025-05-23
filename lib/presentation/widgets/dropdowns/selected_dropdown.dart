import 'package:flutter/foundation.dart';

import '../text/common_text.dart';
import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/app_styles/app_box_decoration.dart';
import 'package:flutter/material.dart';

class SelectedDropdown<T> extends StatelessWidget {
  SelectedDropdown(
      {Key? key,
      required this.items,
      this.dropdownValue,
      this.fieldName = "",
      this.hintText = "",
      this.withHint = true,
      this.isDisable = false,
      this.hintStyle,
      required this.onChange,
      this.style})
      : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final T? dropdownValue;
  final String fieldName;
  final String hintText;
  final bool withHint;
  final bool isDisable;
  final TextStyle? hintStyle;
  late Function(T) onChange;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldName.isNotEmpty)
          style != null
              ? CommonText(fieldName, style: style)
              : CommonText(
                  fieldName,
                  style: AppTextStyles.formTitleTextStyle
                      .copyWith(color: AppColors.blackColor),
                ),
        // CommonText(fieldName,
        //     style: AppTextStyles.formTitleTextStyle
        //         .copyWith(color: AppColors.blackColor)),
        if (fieldName.isNotEmpty) kIsWeb ? 4.0.giveHeight : 10.0.giveHeight,
        Container(
          // margin: const EdgeInsets.only(bottom: 12.0),
          decoration: isDisable
              ? AppBoxDecoration.borderDecoration.copyWith(
                  color: AppColors.disableColor,
                  border: Border.all(color: AppColors.disableColor))
              : AppBoxDecoration.borderDecoration
                  .copyWith(color: AppColors.whiteColor),
          height: kIsWeb ? 35.0 : 45.0,
          child: ButtonTheme(
            alignedDropdown: true,
            padding: AppPaddings.zero,
            disabledColor: AppColors.borderColors,
            child: DropdownButtonHideUnderline(
              child: AbsorbPointer(
                absorbing: isDisable,
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                  ),
                  child: DropdownButton<T>(
                    style: hintStyle ?? AppTextStyles.formFieldTextStyle,
                    icon: Visibility(
                        visible: !isDisable,
                        child: const Icon(Icons.arrow_drop_down_outlined)),
                    elevation: 8,
                    itemHeight: 50.0,
                    hint: Text(
                      hintText,
                      style: AppTextStyles.formFieldHintTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    isDense: false,
                    isExpanded: true,
                    value: dropdownValue,
                    items: items
                        .map(
                          (e) => e,
                        )
                        .toList(),
                    onChanged: (newValue) {
                      // onChange(newValue!) ?? () {};
                      if (newValue != null) {
                        if (!isDisable) {
                          onChange(newValue) ?? () {};
                        }
                      } else {
                        null;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
