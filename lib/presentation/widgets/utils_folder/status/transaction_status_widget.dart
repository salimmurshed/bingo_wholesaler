import 'package:flutter/material.dart';

import '../../../../const/app_colors.dart';
import '../../../../const/app_styles/app_text_styles.dart';

class TransactionStatusWidget extends StatelessWidget {
  const TransactionStatusWidget({
    super.key,
    this.color = AppColors.statusProgress,
    this.text = "",
    this.textAlign = TextAlign.start,
    this.textStyle = AppTextStyles.statusCardStatus,
  });

  final Color color;
  final String text;
  final TextAlign textAlign;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: 2,
      // softWrap: true,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 4, 2),
              child: Icon(
                Icons.circle_rounded,
                size: 10,
                color: color,
              ),
            ),
          ),
          TextSpan(text: text, style: textStyle.copyWith(color: color)),
        ],
      ),
    );
  }
}
