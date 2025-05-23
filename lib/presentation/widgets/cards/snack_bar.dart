import '/const/all_const.dart';
import 'package:flutter/material.dart';

class SnackBarRepo extends StatelessWidget {
  const SnackBarRepo({super.key, this.text = "", this.success = false});

  final String text;
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: success
              ? AppColors.messageColorError
              : AppColors.messageColorSuccess,
          borderRadius: BorderRadius.circular(10.0)),
      height: 45.0,
      width: 100.0.wp,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
