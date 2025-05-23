import 'package:bingo/const/app_colors.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';

import '../../../../../const/app_styles/app_text_styles.dart';

class RoleDetails extends StatelessWidget {
  const RoleDetails(this.list, this.title, {Key? key}) : super(key: key);
  final List<String> list;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: list
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${String.fromCharCode(9899)}   $e",
                      style: AppTextStyles.dashboardHeadTitleAsh,
                    ),
                  ))
              .toList(),
        ),
      ),
      actions: [
        SubmitButton(
          height: 45.0,
          width: 45.0,
          isRadius: false,
          text: "Close",
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
