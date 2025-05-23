import 'package:bingo/presentation/widgets/cards/shadow_card.dart';

import '/const/all_const.dart';
import '/const/utils.dart';
import 'package:flutter/material.dart';

import '../../../const/app_sizes/app_sizes.dart';

class AccountBalanceCard extends StatelessWidget {
  final String title;
  final List<String> subTitleList;

  const AccountBalanceCard(
      {super.key, this.title = "", this.subTitleList = const []});

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      child: Container(
        width: 90.0.wp,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: AppRadius.accountBalanceCardRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.getNiceText(title,
                style: AppTextStyles.statusCardTitle
                    .copyWith(fontWeight: AppFontWeighs.light)),
            if (subTitleList.isNotEmpty)
              Wrap(
                runSpacing: 10.0,
                children: [
                  for (int i = 0; i < subTitleList.length; i++)
                    SizedBox(
                      width: 40.0.wp,
                      child: Utils.getNiceText(subTitleList[i], nxtln: true),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
