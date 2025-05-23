import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../secondery_bar.dart';
import 'location_list_view_model.dart';

class RetailersLocationListView extends StatelessWidget {
  const RetailersLocationListView({super.key, this.ttx, this.uid});

  final String? ttx;
  final String? uid;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailersLocationListViewModel>.reactive(
        viewModelBuilder: () => RetailersLocationListViewModel(),
        onViewModelReady: (RetailersLocationListViewModel model) {
          model.getData(ttx, uid);
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
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flex(
                                            direction:
                                                device == ScreenSize.small
                                                    ? Axis.vertical
                                                    : Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Location Information',
                                                style: AppTextStyles.headerText,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .search),
                                                  ),
                                                  10.0.giveWidth,
                                                  SizedBox(
                                                      width: 100,
                                                      height: 50,
                                                      child: NameTextField(
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                          Scrollbar(
                                            controller: model.scrollController,
                                            thickness: 10,
                                            child: SingleChildScrollView(
                                              controller:
                                                  model.scrollController,
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                width: device != ScreenSize.wide
                                                    ? null
                                                    : 100.0.wp - 64 - 64,
                                                child: Table(
                                                  defaultVerticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  border: TableBorder.all(
                                                      color: AppColors
                                                          .tableHeaderBody),
                                                  columnWidths: {
                                                    0: const FixedColumnWidth(
                                                        70.0),
                                                    1: const FixedColumnWidth(
                                                        70.0),
                                                    2: const FixedColumnWidth(
                                                        100.0),
                                                    3: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            150.0)
                                                        : const FlexColumnWidth(),
                                                    4: const FixedColumnWidth(
                                                        120.0),
                                                    5: const FixedColumnWidth(
                                                        120.0),
                                                    6: const FixedColumnWidth(
                                                        120.0),
                                                    7: const FixedColumnWidth(
                                                        150.0),
                                                    8: const FixedColumnWidth(
                                                        150.0),
                                                  },
                                                  children: [
                                                    TableRow(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: AppColors
                                                              .tableHeaderColor,
                                                        ),
                                                        children: [
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .sNo,
                                                          ),
                                                          dataCellHd(
                                                            "Bingo Store Id",
                                                          ),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_locationName,
                                                          ),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_address),
                                                          dataCellHd(
                                                            "City",
                                                          ),
                                                          dataCellHd(
                                                            "Country",
                                                          ),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_wholesalerStoreId,
                                                          ),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_salesZone),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_action,
                                                          ),
                                                        ]),
                                                    for (int i = 0;
                                                        i <
                                                            model.locationData
                                                                .length;
                                                        i++)
                                                      TableRow(
                                                        decoration:
                                                            BoxDecoration(
                                                          border:
                                                              Utils.tableBorder,
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: dataCell(
                                                                "${1 + i}"),
                                                          ),
                                                          dataCell(model
                                                              .locationData[i]
                                                              .bingoStoreId!
                                                              .toString()),
                                                          dataCell(
                                                            model
                                                                .locationData[i]
                                                                .name!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .locationData[i]
                                                                .address!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .locationData[i]
                                                                .city!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .locationData[i]
                                                                .country!,
                                                            isCenter: false,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child:
                                                                NameTextField(
                                                              hintStyle: AppTextStyles
                                                                  .formTitleTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .ashColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                              enable: false,
                                                              controller: model
                                                                  .wholesalerStoreIdControllers[i],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child:
                                                                NameTextField(
                                                              hintStyle:
                                                                  AppTextStyles
                                                                      .formTitleTextStyleNormal,
                                                              enable: false,
                                                              controller: model
                                                                  .saleZoneControllers[i],
                                                            ),
                                                          ),
                                                          Center(
                                                            child:
                                                                PopupMenuWithValue(
                                                                    onTap: (int
                                                                        v) {
                                                                      model.gotoDetails(
                                                                          context,
                                                                          ttx,
                                                                          uid,
                                                                          model
                                                                              .locationData[i]
                                                                              .uniqueId!);
                                                                    },
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .webActionButtons_title,
                                                                    color: AppColors
                                                                        .contextMenuTwo,
                                                                    items: [
                                                                  {
                                                                    't': AppLocalizations.of(
                                                                            context)!
                                                                        .webActionButtons_view,
                                                                    'v': 0
                                                                  }
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            child: SecondaryBar(ttx, uid),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(
                          //       device != ScreenSize.wide ? 12.0 : 8.0),
                          //   color: Colors.white,
                          //   width: 100.0.wp,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //
                          //       model.isBusy
                          //           ? Utils.bigLoader()
                          //           : Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Flex(
                          //                   direction:
                          //                       device == ScreenSize.small
                          //                           ? Axis.vertical
                          //                           : Axis.horizontal,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     const Text(
                          //                       'Location Information',
                          //                       style: AppTextStyles.headerText,
                          //                     ),
                          //                     Row(
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Padding(
                          //                           padding:
                          //                               const EdgeInsets.only(
                          //                                   top: 8.0),
                          //                           child: Text(
                          //                               AppLocalizations.of(
                          //                                       context)!
                          //                                   .search),
                          //                         ),
                          //                         10.0.giveWidth,
                          //                         SizedBox(
                          //                             width: 100,
                          //                             height: 70,
                          //                             child: NameTextField(
                          //                               hintStyle: AppTextStyles
                          //                                   .formTitleTextStyle
                          //                                   .copyWith(
                          //                                       color: AppColors
                          //                                           .ashColor,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .normal),
                          //                             ))
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Scrollbar(
                          //                   controller: model.scrollController,
                          //                   thickness: 10,
                          //                   child: SingleChildScrollView(
                          //                     controller:
                          //                         model.scrollController,
                          //                     scrollDirection: Axis.horizontal,
                          //                     child: SizedBox(
                          //                       width: device != ScreenSize.wide
                          //                           ? null
                          //                           : 100.0.wp - 64 - 64,
                          //                       child: Table(
                          //                         defaultVerticalAlignment:
                          //                             TableCellVerticalAlignment
                          //                                 .middle,
                          //                         border: TableBorder.all(
                          //                             color: AppColors
                          //                                 .tableHeaderBody),
                          //                         columnWidths: {
                          //                           0: const FixedColumnWidth(
                          //                               70.0),
                          //                           1: const FixedColumnWidth(
                          //                               70.0),
                          //                           2: const FixedColumnWidth(
                          //                               100.0),
                          //                           3: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   150.0)
                          //                               : const FlexColumnWidth(),
                          //                           4: const FixedColumnWidth(
                          //                               120.0),
                          //                           5: const FixedColumnWidth(
                          //                               120.0),
                          //                           6: const FixedColumnWidth(
                          //                               120.0),
                          //                           7: const FixedColumnWidth(
                          //                               150.0),
                          //                           8: const FixedColumnWidth(
                          //                               150.0),
                          //                         },
                          //                         children: [
                          //                           TableRow(
                          //                               decoration:
                          //                                   const BoxDecoration(
                          //                                 color: AppColors
                          //                                     .tableHeaderColor,
                          //                               ),
                          //                               children: [
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .sNo,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   "Bingo Store Id",
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_locationName,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_address),
                          //                                 dataCellHd(
                          //                                   "City",
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   "Country",
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_wholesalerStoreId,
                          //                                 ),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_salesZone),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_action,
                          //                                 ),
                          //                               ]),
                          //                           for (int i = 0;
                          //                               i <
                          //                                   model.locationData
                          //                                       .length;
                          //                               i++)
                          //                             TableRow(
                          //                               decoration:
                          //                                   BoxDecoration(
                          //                                 border:
                          //                                     Utils.tableBorder,
                          //                                 color: AppColors
                          //                                     .whiteColor,
                          //                               ),
                          //                               children: [
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               8.0),
                          //                                   child: dataCell(
                          //                                       "${1 + i}"),
                          //                                 ),
                          //                                 dataCell(model
                          //                                     .locationData[i]
                          //                                     .bingoStoreId!
                          //                                     .toString()),
                          //                                 dataCell(
                          //                                   model
                          //                                       .locationData[i]
                          //                                       .name!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .locationData[i]
                          //                                       .address!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .locationData[i]
                          //                                       .city!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .locationData[i]
                          //                                       .country!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               8.0),
                          //                                   child:
                          //                                       NameTextField(
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                     enable: false,
                          //                                     controller: model
                          //                                         .wholesalerStoreIdControllers[i],
                          //                                   ),
                          //                                 ),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               8.0),
                          //                                   child:
                          //                                       NameTextField(
                          //                                     hintStyle:
                          //                                         AppTextStyles
                          //                                             .formTitleTextStyleNormal,
                          //                                     enable: false,
                          //                                     controller: model
                          //                                         .saleZoneControllers[i],
                          //                                   ),
                          //                                 ),
                          //                                 Center(
                          //                                   child:
                          //                                       PopupMenuWithValue(
                          //                                           onTap: (int
                          //                                               v) {
                          //                                             model.gotoDetails(
                          //                                                 context,
                          //                                                 ttx,
                          //                                                 uid,
                          //                                                 model
                          //                                                     .locationData[i]
                          //                                                     .uniqueId!);
                          //                                           },
                          //                                           text: AppLocalizations.of(
                          //                                                   context)!
                          //                                               .webActionButtons_title,
                          //                                           color: AppColors
                          //                                               .contextMenuTwo,
                          //                                           items: [
                          //                                         {
                          //                                           't': AppLocalizations.of(
                          //                                                   context)!
                          //                                               .webActionButtons_view,
                          //                                           'v': 0
                          //                                         }
                          //                                       ]),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //     ],
                          //   ),
                          // ),
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
