import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

class AlertDialogWeb extends StatelessWidget {
  const AlertDialogWeb({this.header, this.body, this.widget, Key? key})
      : super(key: key);
  final String? header;
  final String? body;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(header ?? ""),
      content: SizedBox(
        width: 30.0.wp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(body ?? ""),
              ),
            ),
            if (widget != null) widget!
          ],
        ),
      ),
    );
  }
}
