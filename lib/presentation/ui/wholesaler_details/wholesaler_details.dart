import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/retailer_associated_wholesaler_list/retailer_associated_wholesaler_list.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';

class WholesalerDetailsView extends StatelessWidget {
  const WholesalerDetailsView(this.data, {super.key});

  final RetailerAssociatedWholesalerListData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColorRetailer,
        title: AppBarText(
            AppLocalizations.of(context)!.wholesalerDetails.toUpperCase()),
      ),
      body: SizedBox(
        height: 100.0.hp,
        child: Padding(
          padding: AppPaddings.bodyVertical,
          child: SingleChildScrollView(
            physics: Utils.pullScrollPhysic,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Utils.commonText(
                      AppLocalizations.of(context)!.companyInformation,
                      needPadding: true,
                      style: AppTextStyles.dashboardHeadBoldTitle
                          .copyWith(color: AppColors.blackColor),
                    ),
                    const SizedBox(),
                  ],
                ),
                Utils.cardToTextGaps(),
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.commonText(
                        '${data.wholesalerName}',
                        needPadding: false,
                        style: AppTextStyles.dashboardHeadBoldTitle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      18.0.giveHeight,
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40.0.wp,
                            child: Utils.getNiceText(
                                "${AppLocalizations.of(context)!.taxId}:${data.taxId}",
                                nxtln: true),
                          ),
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.associationDate}:${data.associationDate}",
                              nxtln: true),
                        ],
                      ),
                      12.0.giveHeight,
                      SizedBox(
                        width: 319.0,
                        child: Utils.getNiceText(
                            "${AppLocalizations.of(context)!.companyAddress}:${data.address}",
                            nxtln: true),
                      ),
                    ],
                  ),
                ),
                Utils.cardGaps(),
                Utils.commonText(
                    AppLocalizations.of(context)!.contactInformation,
                    needPadding: true,
                    style: AppTextStyles.dashboardHeadBoldTitle
                        .copyWith(color: AppColors.blackColor)),
                Utils.cardToTextGaps(),
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.0.wp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Utils.getNiceText(
                                    "${AppLocalizations.of(context)!.firstName}:${data.firstName!.emptyCheck()}",
                                    nxtln: true),
                                15.0.giveHeight,
                                Utils.getNiceText(
                                    "${AppLocalizations.of(context)!.position}:${data.position!.emptyCheck()}",
                                    nxtln: true),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.getNiceText(
                                  "${AppLocalizations.of(context)!.lastName}:${data.lastName!.emptyCheck()}",
                                  nxtln: true),
                              15.0.giveHeight,
                              Utils.getNiceText(
                                  "${AppLocalizations.of(context)!.id}:${data.contactId!.emptyCheck()}",
                                  nxtln: true),
                            ],
                          ),
                        ],
                      ),
                      15.0.giveHeight,
                      Utils.getNiceText(
                          "${AppLocalizations.of(context)!.phoneNo}:${data.phoneNumber!.emptyCheck()}",
                          nxtln: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
