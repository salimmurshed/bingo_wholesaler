import 'package:auto_size_text/auto_size_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

class StatusCardCreditLine extends StatelessWidget {
  StatusCardCreditLine({
    Key? key,
    this.title = "",
    this.subTitle = '',
    this.status = 0,
    this.statusDescription = '',
    this.statusWidget,
    this.bodyFirstKey = '',
    this.bodyFirstValue = '',
    this.bodySecondKey = '',
    this.bodySecondValue = '',
    this.onTap,
  }) : super(key: key);

  final String title;

  final String subTitle;

  final int status;
  final String statusDescription;
  final Widget? statusWidget;

  final String bodyFirstKey;
  final String bodyFirstValue;

  final String bodySecondKey;
  final String bodySecondValue;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      child: InkWell(
        onTap: onTap ?? () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 37.0.wp,
                      child: AutoSizeText(
                        title,
                        // maxLines: 5,
                        style: AppTextStyles.statusCardTitle,
                      ),
                    ),
                    if (subTitle.isNotEmpty)
                      Text(
                        subTitle,
                        maxLines: 2,
                        style: AppTextStyles.statusCardSubTitle,
                      ),
                  ],
                ),
                statusWidget == null
                    ? status.toStatusFromInt(value: statusDescription)
                    : statusWidget!,
              ],
            ),
            12.0.giveHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 180.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bodyFirstKey,
                          style: AppTextStyles.bottomTexts,
                        ),
                        Text(
                          bodyFirstValue,
                          style: AppTextStyles.bottomTexts
                              .copyWith(fontWeight: AppFontWeighs.regular),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bodySecondKey,
                        style: AppTextStyles.bottomTexts,
                      ),
                      Text(
                        bodySecondValue,
                        style: AppTextStyles.bottomTexts
                            .copyWith(fontWeight: AppFontWeighs.regular),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
