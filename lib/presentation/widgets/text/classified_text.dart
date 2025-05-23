import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class ClassifiedText extends StatelessWidget {
  final String text1;
  final String text2;

  const ClassifiedText({this.text1 = "", this.text2 = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.classifiedTextBottomPadding,
      child: RichText(
        text: TextSpan(
          text: text1,
          style: AppTextStyles.dashboardHeadTitleAsh,
          children: <TextSpan>[
            TextSpan(
              text: text2,
              style: AppTextStyles.dashboardHeadTitleAsh
                  .copyWith(fontWeight: AppFontWeighs.semiBold),
            ),
          ],
        ),
      ),
    );
  }
}
