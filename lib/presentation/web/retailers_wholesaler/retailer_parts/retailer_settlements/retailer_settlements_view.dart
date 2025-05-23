import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
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
import 'retailer_settlements_view_model.dart';

class RetailerSettlementsView extends StatelessWidget {
  const RetailerSettlementsView({super.key, this.uid, this.ttx});

  final String? uid;
  final String? ttx;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerSettlementsViewModel>.reactive(
        viewModelBuilder: () => RetailerSettlementsViewModel(),
        onViewModelReady: (RetailerSettlementsViewModel model) {
          model.getData(ttx);
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
                      h1: 'View Settlement Details',
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
                              h1: 'View Settlement Details',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Settlement Information',
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
                                                        100.0), // fixed to 100 width
                                                    1: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    2: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    3: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    4: const FixedColumnWidth(
                                                        120.0), //
                                                    5: const FixedColumnWidth(
                                                        130.0), //f
                                                    6: const FixedColumnWidth(
                                                        200.0), //f
                                                    //fixed to 100 width
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
                                                                  .table_settNo),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_postingDate),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_LotId),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_currency),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_amount),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_status),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_action),
                                                        ]),
                                                    for (int i = 0;
                                                        i <
                                                            model.settlementList
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
                                                          dataCell("${1 + i}"),
                                                          dataCell(model
                                                              .settlementList[i]
                                                              .postingDate!),
                                                          dataCell(
                                                            model
                                                                .settlementList[
                                                                    i]
                                                                .lotId!
                                                                .lastChars(10),
                                                            isCenter: false,
                                                          ),
                                                          dataCell(model
                                                              .settlementList[i]
                                                              .currency!),
                                                          dataCellAmount(model
                                                              .settlementList[i]
                                                              .amount!
                                                              .toString()),
                                                          statusBtn(
                                                              status: model
                                                                  .settlementList[
                                                                      i]
                                                                  .status!,
                                                              statusDescription: model
                                                                  .settlementList[
                                                                      i]
                                                                  .statusDescription!),
                                                          Center(
                                                            child:
                                                                PopupMenuWithValue(
                                                                    onTap: (v) {
                                                                      model.gotoDetails(
                                                                          context,
                                                                          model
                                                                              .settlementList[
                                                                                  i]
                                                                              .lotId,
                                                                          model
                                                                              .settlementList[i]
                                                                              .type);
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
                                                                  },
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (model.settlementList.isEmpty)
                                            Utils.noDataWidget(context)
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
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     const Text(
                          //                       'Settlement Information',
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
                          //                               100.0), // fixed to 100 width
                          //                           1: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           2: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           3: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           4: const FixedColumnWidth(
                          //                               120.0), //
                          //                           5: const FixedColumnWidth(
                          //                               130.0), //f
                          //                           6: const FixedColumnWidth(
                          //                               200.0), //f
                          //                           //fixed to 100 width
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
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_settNo),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_postingDate),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_LotId),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_currency),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_amount),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_status),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_action),
                          //                               ]),
                          //                           for (int i = 0;
                          //                               i <
                          //                                   model.settlementList
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
                          //                                 dataCell("${1 + i}"),
                          //                                 dataCell(model
                          //                                     .settlementList[i]
                          //                                     .postingDate!),
                          //                                 dataCell(
                          //                                   model
                          //                                       .settlementList[
                          //                                           i]
                          //                                       .lotId!
                          //                                       .lastChars(10),
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(model
                          //                                     .settlementList[i]
                          //                                     .currency!),
                          //                                 dataCellAmount(model
                          //                                     .settlementList[i]
                          //                                     .amount!
                          //                                     .toString()),
                          //                                 statusBtn(
                          //                                     status: model
                          //                                         .settlementList[
                          //                                             i]
                          //                                         .status!,
                          //                                     statusDescription: model
                          //                                         .settlementList[
                          //                                             i]
                          //                                         .statusDescription!),
                          //                                 Center(
                          //                                   child:
                          //                                       PopupMenuWithValue(
                          //                                           onTap: (v) {
                          //                                             model.gotoDetails(
                          //                                                 context,
                          //                                                 model
                          //                                                     .settlementList[
                          //                                                         i]
                          //                                                     .lotId,
                          //                                                 model
                          //                                                     .settlementList[i]
                          //                                                     .type);
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
                          //                                         },
                          //                                       ]),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 if (model.settlementList.isEmpty)
                          //                   Utils.noDataWidgetTable(context)
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

  Widget statusBtn({String statusDescription = "", int status = 0}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: status.toStatusSettlementStatWeb(),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          statusDescription,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 12.0),
        ),
      ),
    );
  }
}
