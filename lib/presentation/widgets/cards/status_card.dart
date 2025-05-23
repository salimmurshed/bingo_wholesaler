import 'package:auto_size_text/auto_size_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    this.title = "",
    this.subTitle = '',
    this.status = '',
    this.statusWidget,
    this.bodyFirstKey = '',
    this.bodyFirstValue = '',
    this.bodySecondKey = '',
    this.bodySecondValue = '',
    this.onTap,
    this.statusWidth = 210.0,
  }) : super(key: key);

  final String title;

  final String subTitle;

  final String status;
  final Widget? statusWidget;

  final String bodyFirstKey;
  final String bodyFirstValue;

  final String bodySecondKey;
  final String bodySecondValue;
  final double statusWidth;
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
                SizedBox(
                  width: 100.0.wp - statusWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        title,
                        maxLines: 2,
                        style: AppTextStyles.statusCardTitle,
                      ),
                      if (subTitle.isNotEmpty)
                        Text(
                          subTitle,
                          maxLines: 2,
                          style: AppTextStyles.statusCardSubTitle,
                        ),
                    ],
                  ),
                ),
                statusWidget == null
                    ? Expanded(
                        // width: 120.0,
                        child: statusNamesEnumFromServer(status).toStatus(),
                      )
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
