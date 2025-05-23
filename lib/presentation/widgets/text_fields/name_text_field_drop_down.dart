import '/const/all_const.dart';
import 'package:flutter/material.dart';

class NameTextFieldDropDown extends StatelessWidget {
  final String fieldName;
  final String value;
  final double width;

  NameTextFieldDropDown({
    Key? key,
    this.fieldName = "",
    this.value = "",
    this.width = 300.0,
  }) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = value;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldName),
          10.0.giveHeight,
          SizedBox(
            height: 45.0,
            child: TextField(
              style: AppTextStyles.formFieldTextStyle,
              controller: controller,
              readOnly: true,
              decoration: AppInputStyles.ashOutlineBorder.copyWith(
                  suffixIcon: const Icon(Icons.arrow_drop_down_rounded)),
            ),
          ),
        ],
      ),
    );
  }
}
