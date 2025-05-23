import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import '/const/all_const.dart';
import '/const/utils.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_styles/app_text_styles.dart';

class StatusCardFourPart extends StatelessWidget {
  const StatusCardFourPart({
    this.title = "",
    this.subTitle = '',
    this.niceSubtitle = '',
    this.price = '',
    this.status = '',
    this.statusChild,
    this.isChild = false,
    this.bodyFirstKey = '',
    this.bodyFirstValue = '',
    this.bodySecondKey = '',
    this.bodySecondValue = '',
    this.firstBoxWidth = 180.0,
    this.color = AppColors.cardColor,
  });

  final String title;

  final String subTitle;
  final String niceSubtitle;
  final String price;

  final String status;
  final Widget? statusChild;

  final bool isChild;
  final String bodyFirstKey;
  final String bodyFirstValue;

  final String bodySecondKey;
  final String bodySecondValue;
  final double firstBoxWidth;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      color: color,
      isChild: isChild,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      // maxLines: 2,
                      style: AppTextStyles.statusCardTitle,
                    ),
                    if (niceSubtitle.isNotEmpty)
                      Utils.getNiceText(niceSubtitle),
                    if (subTitle.isNotEmpty)
                      Text(
                        subTitle,
                        maxLines: 2,
                        style: AppTextStyles.statusCardSubTitle,
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (price.isNotEmpty)
                    AutoSizeText(
                      softWrap: true,
                      textAlign: TextAlign.right,
                      price,
                      group: AutoSizeGroup(),
                      minFontSize: 12,
                      maxLines: 2,
                      style: AppTextStyles.statusCardTitle,
                    ),
                  status.isEmpty && statusChild == null
                      ? const SizedBox()
                      : statusChild != null
                          ? statusChild!
                          : SizedBox(
                              width: 120.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  statusWidget(
                                    color: AppColors.statusProgress,
                                    text: "",
                                  ),
                                  Flexible(
                                    child: Text(
                                      status,
                                      maxLines: 2,
                                      style: AppTextStyles.statusCardStatus
                                          .copyWith(
                                              color: AppColors.statusProgress),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: firstBoxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyFirstKey.isEmpty
                        ? const SizedBox()
                        : Utils.getNiceText(bodyFirstKey),
                    bodyFirstValue.isEmpty
                        ? const SizedBox()
                        : Utils.getNiceText(bodyFirstValue),
                  ],
                ),
              ),
              SizedBox(
                width: 300.0 - firstBoxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodySecondKey.isEmpty
                        ? const SizedBox()
                        : Utils.getNiceText(bodySecondKey),
                    bodySecondValue.isEmpty
                        ? const SizedBox()
                        : Utils.getNiceText(bodySecondValue),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
