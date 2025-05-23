import '/const/all_const.dart';
import '/data_models/models/all_sales_model/all_sales_model.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRReader extends StatelessWidget {
  QRReader(this.allSalesData, this.isRetailer, {Key? key}) : super(key: key);
  AllSalesData allSalesData;
  bool isRetailer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0.hp,
      width: 100.0.wp,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          50.0.giveHeight,
          Text(
            allSalesData.retailerName!,
            style: AppTextStyles.statusCardTitle.copyWith(
              color: AppColors.ashColor,
            ),
          ),
          Text(
            allSalesData.fieName!,
            style: AppTextStyles.bottomTexts,
          ),
          Text(
            "${AppLocalizations.of(context)!.balance}: ${allSalesData.balance!}",
            style: AppTextStyles.bottomTexts,
          ),
          Text(
            "${AppLocalizations.of(context)!.date}: ${allSalesData.dueDate!}",
            style: AppTextStyles.bottomTexts,
          ),
          Text(
            "${AppLocalizations.of(context)!.fie}: ${allSalesData.fieName!}",
            style: AppTextStyles.bottomTexts,
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CancelButton(
                  width: 30.0.wp,
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  text: AppLocalizations.of(context)!.rejectSell.toUpperCase(),
                ),
                CancelButton(
                  width: 30.0.wp,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  text: AppLocalizations.of(context)!.acceptSell.toUpperCase(),
                ),
              ],
            ),
          ),
          50.0.giveHeight,
        ],
      ),
    );
  }
}
