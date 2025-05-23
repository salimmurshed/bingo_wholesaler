import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/app_styles/app_box_decoration.dart';
import 'package:flutter/material.dart';

class SelectedDropdown2<T> extends StatelessWidget {
  SelectedDropdown2(
      {Key? key,
      required this.items,
      this.dropdownValue,
      this.fieldName = "",
      this.hintText = "",
      this.withHint = true,
      this.isDisable = false,
      this.onChange})
      : super(key: key);

  defaultFunction(siteName) {}
  final List<DropdownMenuItem<T>> items;
  final T? dropdownValue;
  final String fieldName;
  final String hintText;
  final bool withHint;
  final bool isDisable;
  late Function(T?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName),
        15.0.giveHeight,
        Container(
          decoration: isDisable
              ? AppBoxDecoration.borderDecoration.copyWith(
                  color: AppColors.disableColor,
                  border: Border.all(color: AppColors.disableColor))
              : AppBoxDecoration.borderDecoration,
          height: 50.0,
          child: ButtonTheme(
            alignedDropdown: true,
            padding: AppPaddings.zero,
            disabledColor: AppColors.borderColors,
            child: DropdownButtonHideUnderline(
              child: AbsorbPointer(
                absorbing: isDisable,
                child: DropdownButton<T>(
                  style: AppTextStyles.formFieldTextStyle,
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
                        onChange!(newValue) ?? () {};
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
      ],
    );
  }
}
