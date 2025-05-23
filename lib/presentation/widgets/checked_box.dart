import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

class CheckedBox extends StatelessWidget {
  const CheckedBox({required this.check, Key? key}) : super(key: key);
  final bool check;
  @override
  Widget build(BuildContext context) {
    return check
        ? const Icon(
            Icons.check_box,
            color: AppColors.checkBoxSelected,
          )
        : const Icon(
            Icons.check_box_outline_blank,
            color: AppColors.checkBox,
          );
  }
}
