import 'package:auto_size_text/auto_size_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';

class ProgressStatusCard extends StatelessWidget {
  ProgressStatusCard({
    Key? key,
    this.title = "",
    this.subTitle = '',
    this.status = 0,
    this.statusDescription = '',
    this.language = '',
    this.bodyFirstKey = '',
    this.bodySecondKey = '',
    this.onTap,
    required this.getFrictionOfAvailability,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final int status;
  final String statusDescription;
  final String language;
  final String bodyFirstKey;
  final String bodySecondKey;
  Function()? onTap;
  double getFrictionOfAvailability;

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
                    width: 200,
                    child: AutoSizeText(
                      title,
                      maxLines: 2,
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
              Flexible(
                // width: 120.0,
                child: status.toStatusFromInt(
                    value: StatusFile.statusForCreditline(
                        language, status, statusDescription)),
              ),
            ],
          ),
          12.0.giveHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180.0,
                child: Utils.getNiceText(
                  bodyFirstKey,
                  style: AppTextStyles.bottomTexts,
                ),
              ),
              SizedBox(
                width: 120.0,
                child: Utils.getNiceText(
                  bodySecondKey,
                  style: AppTextStyles.bottomTexts,
                ),
              ),
            ],
          ),
          15.0.giveHeight,
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              minHeight: 10.0,
              backgroundColor: const Color(0xffEBEBEB),
              color: const Color(0xff5DC151),
              value: getFrictionOfAvailability,
            ),
          )
        ],
      ),
    ));
  }
}
