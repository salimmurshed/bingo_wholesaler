import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/special_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../data_models/models/customer_settlement_list/customer_settlement_list.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/sales_details_card.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/cards/status_card_four_part.dart';
import 'customer_settlement_detail_view_model.dart';

class CustomerSettlementDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSettlementDetailsViewModel>.reactive(
        onViewModelReady: (CustomerSettlementDetailsViewModel m) => m.setData(
            ModalRoute.of(context)!.settings.arguments
                as CustomerSettlementData),
        viewModelBuilder: () => CustomerSettlementDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(
                  AppLocalizations.of(context)!.settlementDetail.toUpperCase()),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.cardBody,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadowCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  model.settlementDetail.lotId!.isEmpty
                                      ? AppLocalizations.of(context)!.stars
                                      : model.settlementDetail.lotId!
                                          .lastChars(10),
                                  style: AppTextStyles.dashboardHeadTitle
                                      .copyWith(
                                          fontWeight: AppFontWeighs.semiBold),
                                ),
                              ),
                              10.0.giveWidth,
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "${model.settlementDetail.currency!} ${model.settlementDetail.amount!.toString()}",
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.dashboardHeadTitle
                                      .copyWith(
                                          fontWeight: AppFontWeighs.semiBold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: AppPaddings.salesDetailsDeviderPadding,
                            child: const Divider(
                              color: AppColors.dividerColor,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.status,
                            style: AppTextStyles.dashboardHeadTitle,
                          ),
                          model.settlementDetail.status!.toSaleStatus(
                              text: model.settlementDetail.statusDescription!),
                          Padding(
                            padding: AppPaddings.salesDetailsDeviderPadding,
                            child: const Divider(
                              color: AppColors.dividerColor,
                            ),
                          ),
                          SalesDetails(
                            data: [
                              "${AppLocalizations.of(context)!.lotId}"
                                  "${model.settlementDetail.lotId!.lastChars(10)}",
                              "${AppLocalizations.of(context)!.lotType}"
                                  "${model.settlementDetail.lotType!}",
                              "${AppLocalizations.of(context)!.dateGenerated}"
                                  "${model.settlementDetail.dateGenerated!}",
                              "${AppLocalizations.of(context)!.postingDate}"
                                  "${model.settlementDetail.postingDate!}",
                              "${AppLocalizations.of(context)!.openBalanceAmount}"
                                  "${model.settlementDetail.openBalance!}",
                              "${model.settlementDetail.type == 1 ? AppLocalizations.of(context)!.amountCollected : AppLocalizations.of(context)!.amountPaid}"
                                  "${model.settlementDetail.amount!}",
                              "${AppLocalizations.of(context)!.user}"
                                  "${model.settlementDetail.user!}",
                            ],
                          ),
                          10.0.giveHeight,
                        ],
                      ),
                    ),
                    18.0.giveHeight,
                    Text(
                      AppLocalizations.of(context)!.paymentDetails,
                      style: AppTextStyles.dashboardHeadTitle
                          .copyWith(fontWeight: AppFontWeighs.semiBold),
                    ),
                    if (model.settlementDetail.paymentDetail!.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.noDataInTable(""),
                            style: AppTextStyles.noDataTextStyle,
                          ),
                        ),
                      ),
                    for (int i = 0;
                        i < model.settlementDetail.paymentDetail!.length;
                        i++)
                      StatusCardFourPart(
                        price:
                            "${model.settlementDetail.currency} ${model.settlementDetail.paymentDetail![i].amount!.setDeci()}",
                        title: model.settlementDetail.paymentDetail![i]
                            .documentTypeUniqueId!
                            .lastChars(10),
                        subTitle:
                            "${model.settlementDetail.paymentDetail![i].documentType}\n",
                        bodyFirstKey:
                            "${AppLocalizations.of(context)!.invoice}\n"
                            "${model.settlementDetail.paymentDetail![i].invoice}\n",
                        bodyFirstValue: model.settlementDetail.paymentDetail![i]
                                    .partnerName!.isEmpty &&
                                model.settlementDetail.paymentDetail![i]
                                    .tempTxAddress!.isEmpty
                            ? "${AppLocalizations.of(context)!.businessPartnerID} ${SpecialKeys.bingo} (${AppLocalizations.of(context)!.stars})"
                            : "${AppLocalizations.of(context)!.businessPartnerID} "
                                "${model.settlementDetail.paymentDetail![i].partnerName}\n(${model.settlementDetail.paymentDetail![i].tempTxAddress!.lastChars(10)})",
                        bodySecondKey:
                            "${AppLocalizations.of(context)!.openBalance}\n"
                            "${model.settlementDetail.currency} ${model.settlementDetail.paymentDetail![i].openBalance!.setDeci()}\n",
                        bodySecondValue:
                            "${AppLocalizations.of(context)!.appliedAmount}\n"
                            "${model.settlementDetail.currency} ${model.settlementDetail.paymentDetail![i].appliedAmount!.setDeci()} \n\n${AppLocalizations.of(context)!.creditLineID} ${model.settlementDetail.paymentDetail![i].creditLineId}",
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
