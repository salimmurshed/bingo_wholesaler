import '/const/all_const.dart';
import '/data_models/models/routes_details_model/routes_details_model.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../data_models/models/sales_zone_details_model/sales_zone_details_model.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({
    this.locationsDetail,
    this.locationsDetailsSales,
    Key? key,
  }) : super(key: key);
  final LocationsDetails? locationsDetail;
  final LocationsDetailsSales? locationsDetailsSales;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      child: Row(
        children: [
          Image.asset(
            AppAsset.house,
            height: 32.0,
          ),
          10.0.giveWidth,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                locationsDetail == null
                    ? locationsDetailsSales!.storeName!
                    : locationsDetail!.storeName!,
                style: AppTextStyles.headerText,
              ),
              SizedBox(
                width: 70.0.wp,
                child: Text(
                  locationsDetail == null
                      ? locationsDetailsSales!.storeAddress!
                      : locationsDetail!.storeAddress!,
                  style: AppTextStyles.successStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
