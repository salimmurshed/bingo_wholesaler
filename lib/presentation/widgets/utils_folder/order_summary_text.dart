import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

class OrderSummaryText extends StatelessWidget {
  const OrderSummaryText(this.t1, this.t2, this.t3, {super.key});
  final String t1;
  final String t2;
  final String t3;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 55.0.wp,
          child: Text(
            t1,
            style: AppTextStyles.dashboardHeadTitleAsh,
          ),
        ),
        Expanded(
          // width: 20.0.wp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t2,
                style: AppTextStyles.dashboardHeadTitleAsh
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                t3,
                style: AppTextStyles.dashboardHeadTitleAsh
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
