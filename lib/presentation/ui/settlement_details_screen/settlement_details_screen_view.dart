import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/server_status_file/server_status_file.dart';
import '/const/utils.dart';
import '/presentation/ui/settlement_details_screen/settlement_details_screen_view_model.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/loader/loader.dart';

class SettlementDetailsScreenView extends StatelessWidget {
  const SettlementDetailsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    print(build.runtimeType);
    return ViewModelBuilder<SettlementDetailsScreenViewModel>.reactive(
        onViewModelReady: (SettlementDetailsScreenViewModel model) => model
            .setDatas(ModalRoute.of(context)!.settings.arguments as String),
        viewModelBuilder: () => SettlementDetailsScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBarColorRetailer,
              title: AppBarText(AppLocalizations.of(context)!
                  .settlementsDetails
                  .toUpperCase()),
            ),
            body: model.isBusy
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: AppPaddings.bodyVertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShadowCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Utils.commonText(
                                        '${AppLocalizations.of(context)!.collectionLot}${model.settlementDetailsData.lotNumber ?? ""}',
                                        style: AppTextStyles.statusCardTitle,
                                        needPadding: false),
                                    (model.settlementDetailsData.status ?? 0)
                                        .toStatusSettleMent(
                                            value:
                                                StatusFile.statusForSettlement(
                                                    model.language,
                                                    model.settlementDetailsData
                                                            .status ??
                                                        1,
                                                    model.settlementDetailsData
                                                            .statusDescription ??
                                                        "Active"))
                                  ],
                                ),
                                10.0.giveHeight,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.0.wp,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.lotType}'
                                              '${model.settlementDetailsData.lotType}',
                                              nxtln: true),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.dateGenerated}${model.settlementDetailsData.dateGenerated}',
                                              nxtln: true),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.openBalanceAmount}${model.settlementDetailsData.currency} '
                                              '${model.settlementDetailsData.openBalanceAmount}',
                                              nxtln: true),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.0.wp,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.lotId}${model.settlementDetailsData.lotId!.lastChars(10)}',
                                              nxtln: true),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.postingDate}${model.settlementDetailsData.postingDate}',
                                              nxtln: true),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.amountCollected}${model.settlementDetailsData.currency} ${model.settlementDetailsData.amountCollected}',
                                              nxtln: true),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Utils.cardGaps(),
                          Utils.commonText(
                              AppLocalizations.of(context)!.paymentDetails,
                              style: AppTextStyles.statusCardTitle,
                              needPadding: true),
                          Utils.cardToTextGaps(),
                          ShadowCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    model.userNameWithTx(),
                                    style: AppTextStyles.statusCardTitle,
                                  ),
                                ),
                                if (model.settlementDetailsData.paymentDetails!
                                    .isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 100.0),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .noDataInTable(""),
                                        style: AppTextStyles.noDataTextStyle,
                                      ),
                                    ),
                                  ),
                                for (int i = 0;
                                    i <
                                        model.settlementDetailsData
                                            .paymentDetails!.length;
                                    i++)
                                  ShadowCard(
                                    isChild: true,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Utils.commonText(
                                                model
                                                    .settlementDetailsData
                                                    .paymentDetails![i]
                                                    .invoice!,
                                                style: AppTextStyles
                                                    .dashboardHeadTitleAsh
                                                    .copyWith(
                                                        fontWeight:
                                                            AppFontWeighs
                                                                .semiBold),
                                                needPadding: false),
                                            model.settlementDetailsData
                                                .paymentDetails![i].status!
                                                .toStatusFinStat(
                                                    value: StatusFile.statusForFinState(
                                                        model.language,
                                                        model
                                                            .settlementDetailsData
                                                            .paymentDetails![i]
                                                            .status!,
                                                        model
                                                            .settlementDetailsData
                                                            .paymentDetails![i]
                                                            .statusDescription!))
                                          ],
                                        ),
                                        10.0.giveHeight,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 32.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.documentType}'
                                                      '${model.settlementDetailsData.paymentDetails![i].documentType}',
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.openBalance}${model.settlementDetailsData.currency} '
                                                      '${model.settlementDetailsData.paymentDetails![i].openBalance}',
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.creditLineID}'
                                                      '${model.settlementDetailsData.paymentDetails![i].clInternalId}',
                                                      nxtln: true),
                                                ],
                                              ),
                                            ),
                                            10.0.giveWidth,
                                            SizedBox(
                                              width: 32.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.businessPartnerID}${model.userNameWithTx()}',
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.appliedAmount}${model.settlementDetailsData.currency} ${model.settlementDetailsData.paymentDetails![i].amountApplied}',
                                                      nxtln: true),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
