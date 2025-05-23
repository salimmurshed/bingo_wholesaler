import '/const/all_const.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/customer_store_list/customer_store_list.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/sales_details_card.dart';
import 'customer_location_details_model.dart';

class CustomerLocationDetails extends StatelessWidget {
  const CustomerLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerLocationDetailsModel>.reactive(
        onViewModelReady: (CustomerLocationDetailsModel model) => model.setData(
            ModalRoute.of(context)!.settings.arguments as CustomerStoreData),
        viewModelBuilder: () => CustomerLocationDetailsModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(
                  AppLocalizations.of(context)!.location.toUpperCase()),
            ),
            body: Padding(
              padding: AppPaddings.bodyVertical,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadowCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.customerData.name!,
                            style: AppTextStyles.dashboardHeadTitle
                                .copyWith(fontWeight: AppFontWeighs.semiBold),
                          ),
                          5.0.giveHeight,
                          Row(
                            children: [
                              Image.asset(
                                AppAsset.locator,
                                scale: 1.3,
                              ),
                              10.0.giveWidth,
                              SizedBox(
                                width: 70.0.wp,
                                child: Text(
                                  model.customerData.address!,
                                  maxLines: 2,
                                  style: AppTextStyles.statusCardSubTitle,
                                ),
                              ),
                            ],
                          ),
                          20.0.giveHeight,
                          SalesDetails(
                            data: [
                              "${AppLocalizations.of(context)!.bingoStoreID}"
                                  " ${model.customerData.bingoStoreId}",
                              "${AppLocalizations.of(context)!.city}:"
                                  " ${model.customerData.city}",
                              "${AppLocalizations.of(context)!.country}:"
                                  " ${model.customerData.country}",
                              "${AppLocalizations.of(context)!.wholesalerId}:"
                                  " ${model.customerData.wStoreId}",
                              "${AppLocalizations.of(context)!.salesZone}:"
                                  " ${model.customerData.salesZoneId}",
                              "${AppLocalizations.of(context)!.description}:"
                                  " ${model.customerData.remarks}",
                            ],
                          ),
                          20.0.giveHeight,
                          SizedBox(
                            width: 35.0.wp,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                backgroundColor: AppColors.inactiveButtonColor,
                              ),
                              onPressed: () {
                                model.gotoPhotos(context);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.image_outlined,
                                    color: AppColors.blackColor,
                                  ),
                                  10.0.giveWidth,
                                  Text(
                                    AppLocalizations.of(context)!.photos,
                                    style: const TextStyle(
                                        color: AppColors.blackColor),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Utils.cardGaps(),
                    Utils.commonText(
                        AppLocalizations.of(context)!.routesInformation,
                        style: AppTextStyles.headerText,
                        needPadding: true),
                    Utils.cardToTextGaps(),
                    ShadowCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            key: const Key("0"),
                            onExpansionChanged: (v) {
                              if (v) {
                                model.changeRoute(0);
                              } else {
                                model.changeRoute(-1);
                              }
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                            collapsedBackgroundColor: AppColors.accentColor,
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            title: Text(
                              AppLocalizations.of(context)!.staticRoutes,
                              style: AppTextStyles.statusCardTitle
                                  .copyWith(fontWeight: AppFontWeighs.semiBold),
                            ),
                            children: [
                              model.customerData.staticRoutes!.isEmpty
                                  ? Utils.noDataWidget(context, height: 40)
                                  : Column(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                model.customerData.staticRoutes!
                                                    .length;
                                            i++)
                                          Container(
                                            width: 100.0.wp,
                                            padding: AppMargins.smallBoxPadding,
                                            margin: const EdgeInsets.only(
                                                bottom: 8.0),
                                            decoration: AppBoxDecoration
                                                .dashboardCardDecoration
                                                .copyWith(
                                              borderRadius:
                                                  AppRadius.salesDetailsRadius,
                                              border: Border.all(
                                                color: AppColors
                                                    .shimmerHighlightColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.routeID} 	${model.customerData.staticRoutes![i].routeId}",
                                                      style: AppTextStyles
                                                          .dashboardHeadTitleAsh
                                                          .copyWith(
                                                              height: 2.0),
                                                    ),
                                                    Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.descriptioN} 	"
                                                      "${model.customerData.staticRoutes![i].routeName}",
                                                      style: AppTextStyles
                                                          .dashboardHeadTitleAsh
                                                          .copyWith(
                                                              height: 2.0),
                                                    ),
                                                  ],
                                                ),
                                                10.0.giveWidth,
                                                Utils.getNiceText(
                                                  "${AppLocalizations.of(context)!.sNo}: ${model.customerData.staticRoutes![i].id}",
                                                  style: AppTextStyles
                                                      .dashboardHeadTitleAsh
                                                      .copyWith(height: 2.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                            ],
                          ),
                          26.0.giveHeight,
                          ExpansionTile(
                            key: const Key("1"),
                            onExpansionChanged: (v) {
                              if (v) {
                                model.changeRoute(1);
                              } else {
                                model.changeRoute(-1);
                              }
                            },
                            collapsedBackgroundColor: AppColors.accentColor,
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            title: Text(
                              AppLocalizations.of(context)!.dynamicRoutes,
                              style: AppTextStyles.statusCardTitle
                                  .copyWith(fontWeight: AppFontWeighs.semiBold),
                            ),
                            children: [
                              model.customerData.dynamicRoutes!.isEmpty
                                  ? Utils.noDataWidget(context, height: 40)
                                  : Column(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                model.customerData
                                                    .dynamicRoutes!.length;
                                            i++)
                                          Container(
                                            width: 100.0.wp,
                                            padding: AppMargins.smallBoxPadding,
                                            margin: const EdgeInsets.only(
                                                bottom: 8.0),
                                            decoration: AppBoxDecoration
                                                .dashboardCardDecoration
                                                .copyWith(
                                              borderRadius:
                                                  AppRadius.salesDetailsRadius,
                                              border: Border.all(
                                                color: AppColors
                                                    .shimmerHighlightColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.routeID} 	${model.customerData.dynamicRoutes![i].routeId}",
                                                      style: AppTextStyles
                                                          .dashboardHeadTitleAsh
                                                          .copyWith(
                                                              height: 2.0),
                                                    ),
                                                    Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.descriptioN} 	"
                                                      "${model.customerData.dynamicRoutes![i].routeName}",
                                                      style: AppTextStyles
                                                          .dashboardHeadTitleAsh
                                                          .copyWith(
                                                              height: 2.0),
                                                    ),
                                                  ],
                                                ),
                                                10.0.giveWidth,
                                                Utils.getNiceText(
                                                  "${AppLocalizations.of(context)!.sNo}: ${model.customerData.dynamicRoutes![i].id}",
                                                  style: AppTextStyles
                                                      .dashboardHeadTitleAsh
                                                      .copyWith(height: 2.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
