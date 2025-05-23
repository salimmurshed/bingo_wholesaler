import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/cards/shadow_card.dart';
import 'package:bingo/presentation/widgets/expandable/expandable.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:bingo/presentation/widgets/web_widgets/with_tab_website_base_body.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/customer_store_list/customer_store_list.dart';
import '../../widgets/web_widgets/body/table.dart';
import '../retailers_wholesaler/retailer_parts/secondery_bar.dart';
import 'location_details_view_model.dart';

class LocationDetailsView extends StatelessWidget {
  const LocationDetailsView({super.key, this.ttx, this.uid, this.sid});
  final String? ttx;
  final String? uid;
  final String? sid;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationDetailsViewModel>.reactive(
        viewModelBuilder: () => LocationDetailsViewModel(),
        onViewModelReady: (LocationDetailsViewModel model) {
          model.prefill(ttx, uid, sid);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'View Location Details',
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (device != ScreenSize.small)
                            SecondaryNameAppBar(
                              h1: 'View Location Details',
                            ),
                          WithTabWebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.0.giveHeight,
                                      SizedBox(
                                        width: 100.0.wp,
                                        child: Wrap(
                                          runSpacing: 20.0,
                                          alignment: WrapAlignment.spaceBetween,
                                          runAlignment:
                                              WrapAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller: model
                                                    .bingoStoreIdController,
                                                fieldName: "Bingo Store Id",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller: model
                                                    .locationNameController,
                                                fieldName: "Location Name",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                maxLine: 2,
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller:
                                                    model.addressController,
                                                fieldName: "Address",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller:
                                                    model.cityController,
                                                fieldName: "City",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller:
                                                    model.countryController,
                                                fieldName: "Country",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller: model
                                                    .wholesalerStoreIdController,
                                                fieldName:
                                                    "Wholesaler Store Id",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                controller: model
                                                    .selectSalesZoneController,
                                                fieldName: "Select Sales Zone",
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const CommonText(
                                                      'Front Business Photo'),
                                                  Center(
                                                    child: ImageNetwork(
                                                      image:
                                                          model.businessPhoto,
                                                      height: 20.0.wp,
                                                      width: 20.0.wp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const CommonText(
                                                      'Sign Board Photo'),
                                                  Center(
                                                    child: ImageNetwork(
                                                      image:
                                                          model.signBoardPhoto,
                                                      height: 20.0.wp,
                                                      width: 20.0.wp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ShadowCard(
                                              child: Column(
                                                children: [
                                                  ExpandablePanel(
                                                    expanded: tables(
                                                        model.scrollController,
                                                        context,
                                                        model.storeDate!
                                                            .staticRoutes!),
                                                    collapsed: const SizedBox(),
                                                    isTrue: model.tabRoute == 1,
                                                    onTap: () {
                                                      model.changeTabRoute(1);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 20, 0, 20),
                                                        width: 100.0.wp,
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15.0),
                                                                ),
                                                                color: AppColors
                                                                    .liteBlueColor),
                                                        child: const Text(
                                                          "Static Routes",
                                                          style: AppTextStyles
                                                              .appBarTitle,
                                                        )),
                                                  ),
                                                  20.0.giveHeight,
                                                  ExpandablePanel(
                                                    expanded: tables(
                                                        model.scrollController,
                                                        context,
                                                        model.storeDate!
                                                            .dynamicRoutes!),
                                                    collapsed: const SizedBox(),
                                                    isTrue: model.tabRoute == 2,
                                                    onTap: () {
                                                      model.changeTabRoute(2);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 20, 0, 20),
                                                        width: 100.0.wp,
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15.0),
                                                                ),
                                                                color: AppColors
                                                                    .liteBlueColor),
                                                        child: const Text(
                                                          "Dynamic Routes",
                                                          style: AppTextStyles
                                                              .appBarTitle,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            child: SecondaryBar(ttx, uid),
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

  Widget tables(ScrollController scrollController, BuildContext context,
      List<StaticRoutes> routes) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Center(
        child: Scrollbar(
          controller: scrollController,
          thickness: 10,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: device != ScreenSize.wide ? null : 70.0.wp,
              child: Column(
                children: [
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: const FixedColumnWidth(70.0),
                      1: const FixedColumnWidth(200.0),
                      2: device != ScreenSize.wide
                          ? const FixedColumnWidth(150.0)
                          : const FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        dataCellHd(AppLocalizations.of(context)!.sNo),
                        dataCellHd("Route Id"),
                        dataCellHd(
                            AppLocalizations.of(context)!.table_description),
                      ]),
                      for (int i = 0; i < routes.length; i++)
                        TableRow(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: dataCell("${1 + i}"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: dataCell(routes[i].routeId!),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: dataCell(routes[i].routeName!),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (routes.isEmpty) Utils.noDataWidget(context, height: 40.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
