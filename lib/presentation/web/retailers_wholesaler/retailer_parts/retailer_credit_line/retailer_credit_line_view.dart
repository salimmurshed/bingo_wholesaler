import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../secondery_bar.dart';
import 'retailer_credit_line_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class RetailerCreditLineView extends StatelessWidget {
  const RetailerCreditLineView({super.key, this.uid, this.ttx});

  final String? uid;
  final String? ttx;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerCreditLineViewModel>.reactive(
        viewModelBuilder: () => RetailerCreditLineViewModel(),
        onViewModelReady: (RetailerCreditLineViewModel model) {
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
                      h1: 'Retailer Details',
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
                              h1: 'Retailer Details',
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
                                                'View Retailer Credit Line',
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
                                                    1: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            118.0)
                                                        : const FlexColumnWidth(),
                                                    2: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    3: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    4: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    5: const FixedColumnWidth(
                                                        100.0),
                                                    6: const FixedColumnWidth(
                                                        100.0),
                                                    7: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            100.0)
                                                        : const FlexColumnWidth(),
                                                    8: const FixedColumnWidth(
                                                        100.0),
                                                    9: const FixedColumnWidth(
                                                        100.0),
                                                    10: const FixedColumnWidth(
                                                        100.0),
                                                    11: const FixedColumnWidth(
                                                        122.0),
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
                                                                  .table_sNo),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_clId),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_retailer),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_fie),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_appAmount),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_appDate),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_expDate),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_currentBalance),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_amountAvailable),
                                                          dataCellHd(AppLocalizations
                                                                  .of(context)!
                                                              .table_utilization),
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
                                                            model
                                                                .customerCreditline
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
                                                          dataCell(
                                                            "${i + 1}",
                                                          ),
                                                          dataCell(
                                                              model
                                                                  .customerCreditline[
                                                                      i]
                                                                  .clInternalId!,
                                                              isCenter: false),
                                                          dataCell(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .retailerName!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .fieName!,
                                                            isCenter: false,
                                                          ),
                                                          dataCellAmount(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .approvedCreditLineAmount!,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .clApprovedDate!,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .expirationDate!,
                                                          ),
                                                          dataCellAmount(
                                                            model
                                                                .customerCreditline[
                                                                    i]
                                                                .consumedAmount!,
                                                          ),
                                                          dataCellAmount(model.availableAmount(
                                                              model
                                                                  .customerCreditline[
                                                                      i]
                                                                  .approvedCreditLineAmount!,
                                                              model
                                                                  .customerCreditline[
                                                                      i]
                                                                  .consumedAmount!)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                color: AppColors
                                                                    .bingoGreen,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .creditlineUtilizationBackGround,
                                                                minHeight: 20,
                                                                value: model
                                                                    .getPercentage(
                                                                        i),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        3),
                                                            child: Center(
                                                              child: CommonText(
                                                                model
                                                                    .customerCreditline[
                                                                        i]
                                                                    .statusDescription!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      AppFontSize
                                                                          .s14,
                                                                  color: model.customerCreditline[i].statusDescription!
                                                                              .toLowerCase() ==
                                                                          "active"
                                                                      ? AppColors
                                                                          .statusVerified
                                                                      : AppColors
                                                                          .statusReject,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Material(
                                                              color:
                                                                  Colors.white,
                                                              child: PopupMenuButton<
                                                                      int>(
                                                                  color: Colors
                                                                      .white,
                                                                  splashRadius:
                                                                      20.0,
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          40),
                                                                  onSelected:
                                                                      (int v) {
                                                                    model.action(
                                                                        context,
                                                                        model
                                                                            .customerCreditline[i]
                                                                            .uniqueId!,
                                                                        uid,
                                                                        ttx);
                                                                  },
                                                                  elevation:
                                                                      8.0,
                                                                  tooltip: "",
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return [
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            0,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .webActionButtons_view,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ];
                                                                  },
                                                                  child: Card(
                                                                    color: AppColors
                                                                        .contextMenuTwo,
                                                                    elevation:
                                                                        2,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10.0,
                                                                          vertical:
                                                                              2.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context)!.actions,
                                                                            style:
                                                                                const TextStyle(color: AppColors.whiteColor),
                                                                          ),
                                                                          const Icon(
                                                                              Icons.keyboard_arrow_down_sharp,
                                                                              color: AppColors.whiteColor)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (model.customerCreditline.isEmpty)
                                            Utils.noDataWidget(context),
                                          20.0.giveHeight,
                                          if (model
                                              .customerCreditline.isNotEmpty)
                                            model.isBusy
                                                ? const SizedBox()
                                                : PaginationWidget(
                                                    totalPage: model.totalPage,
                                                    perPage: 1,
                                                    startTo: model.pageTo,
                                                    startFrom: model.pageFrom,
                                                    pageNumber:
                                                        model.pageNumber,
                                                    total: model.dataTotal,
                                                    onPageChange: (int v) {
                                                      // model.changePage(context, v);
                                                    })
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
                          //                       'View Retailer Credit Line',
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
                          //                           1: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   118.0)
                          //                               : const FlexColumnWidth(),
                          //                           2: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           3: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           4: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           5: const FixedColumnWidth(
                          //                               100.0),
                          //                           6: const FixedColumnWidth(
                          //                               100.0),
                          //                           7: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   100.0)
                          //                               : const FlexColumnWidth(),
                          //                           8: const FixedColumnWidth(
                          //                               100.0),
                          //                           9: const FixedColumnWidth(
                          //                               100.0),
                          //                           10: const FixedColumnWidth(
                          //                               100.0),
                          //                           11: const FixedColumnWidth(
                          //                               122.0),
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
                          //                                         .table_sNo),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_clId),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_retailer),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_fie),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_appAmount),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_appDate),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_expDate),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_currentBalance),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_amountAvailable),
                          //                                 dataCellHd(AppLocalizations
                          //                                         .of(context)!
                          //                                     .table_utilization),
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
                          //                                   model
                          //                                       .customerCreditline
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
                          //                                 dataCell(
                          //                                   "${i + 1}",
                          //                                 ),
                          //                                 dataCell(
                          //                                     model
                          //                                         .customerCreditline[
                          //                                             i]
                          //                                         .clInternalId!,
                          //                                     isCenter: false),
                          //                                 dataCell(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .retailerName!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .fieName!,
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCellAmount(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .approvedCreditLineAmount!,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .clApprovedDate!,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .expirationDate!,
                          //                                 ),
                          //                                 dataCellAmount(
                          //                                   model
                          //                                       .customerCreditline[
                          //                                           i]
                          //                                       .consumedAmount!,
                          //                                 ),
                          //                                 dataCellAmount(model.availableAmount(
                          //                                     model
                          //                                         .customerCreditline[
                          //                                             i]
                          //                                         .approvedCreditLineAmount!,
                          //                                     model
                          //                                         .customerCreditline[
                          //                                             i]
                          //                                         .consumedAmount!)),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               8.0),
                          //                                   child: ClipRRect(
                          //                                     borderRadius:
                          //                                         BorderRadius
                          //                                             .circular(
                          //                                                 50.0),
                          //                                     child:
                          //                                         LinearProgressIndicator(
                          //                                       color: AppColors
                          //                                           .bingoGreen,
                          //                                       backgroundColor:
                          //                                           AppColors
                          //                                               .creditlineUtilizationBackGround,
                          //                                       minHeight: 20,
                          //                                       value: model
                          //                                           .getPercentage(
                          //                                               i),
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                                 Container(
                          //                                   margin:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               20),
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           vertical:
                          //                                               3),
                          //                                   child: Center(
                          //                                     child: CommonText(
                          //                                       model
                          //                                           .customerCreditline[
                          //                                               i]
                          //                                           .statusDescription!,
                          //                                       style:
                          //                                           TextStyle(
                          //                                         fontSize:
                          //                                             AppFontSize
                          //                                                 .s14,
                          //                                         color: model.customerCreditline[i].statusDescription!
                          //                                                     .toLowerCase() ==
                          //                                                 "active"
                          //                                             ? AppColors
                          //                                                 .statusVerified
                          //                                             : AppColors
                          //                                                 .statusReject,
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                           horizontal:
                          //                                               10),
                          //                                   child: Material(
                          //                                     color:
                          //                                         Colors.white,
                          //                                     child: PopupMenuButton<
                          //                                             int>(
                          //                                         color: Colors
                          //                                             .white,
                          //                                         splashRadius:
                          //                                             20.0,
                          //                                         offset:
                          //                                             const Offset(
                          //                                                 0,
                          //                                                 40),
                          //                                         onSelected:
                          //                                             (int v) {
                          //                                           model.action(
                          //                                               context,
                          //                                               model
                          //                                                   .customerCreditline[i]
                          //                                                   .uniqueId!,
                          //                                               uid,
                          //                                               ttx);
                          //                                         },
                          //                                         elevation:
                          //                                             8.0,
                          //                                         tooltip: "",
                          //                                         itemBuilder:
                          //                                             (BuildContext
                          //                                                 context) {
                          //                                           return [
                          //                                             PopupMenuItem<
                          //                                                 int>(
                          //                                               height:
                          //                                                   30,
                          //                                               value:
                          //                                                   0,
                          //                                               child:
                          //                                                   Text(
                          //                                                 AppLocalizations.of(context)!
                          //                                                     .webActionButtons_view,
                          //                                                 style:
                          //                                                     const TextStyle(
                          //                                                   fontSize:
                          //                                                       12,
                          //                                                   color:
                          //                                                       AppColors.ashColor,
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //                                           ];
                          //                                         },
                          //                                         child: Card(
                          //                                           color: AppColors
                          //                                               .contextMenuTwo,
                          //                                           elevation:
                          //                                               2,
                          //                                           shape:
                          //                                               RoundedRectangleBorder(
                          //                                             borderRadius:
                          //                                                 BorderRadius.circular(
                          //                                                     3),
                          //                                           ),
                          //                                           child:
                          //                                               Padding(
                          //                                             padding: const EdgeInsets
                          //                                                 .symmetric(
                          //                                                 horizontal:
                          //                                                     10.0,
                          //                                                 vertical:
                          //                                                     2.0),
                          //                                             child:
                          //                                                 Row(
                          //                                               children: [
                          //                                                 Text(
                          //                                                   AppLocalizations.of(context)!.actions,
                          //                                                   style:
                          //                                                       const TextStyle(color: AppColors.whiteColor),
                          //                                                 ),
                          //                                                 const Icon(
                          //                                                     Icons.keyboard_arrow_down_sharp,
                          //                                                     color: AppColors.whiteColor)
                          //                                               ],
                          //                                             ),
                          //                                           ),
                          //                                         )),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 if (model.customerCreditline.isEmpty)
                          //                   Utils.noDataWidgetTable(context),
                          //                 20.0.giveHeight,
                          //                 if (model
                          //                     .customerCreditline.isNotEmpty)
                          //                   model.isBusy
                          //                       ? const SizedBox()
                          //                       : PaginationWidget(
                          //                           totalPage: model.totalPage,
                          //                           perPage: 1,
                          //                           startTo: model.pageTo,
                          //                           startFrom: model.pageFrom,
                          //                           pageNumber:
                          //                               model.pageNumber,
                          //                           total: model.dataTotal,
                          //                           onPageChange: (int v) {
                          //                             // model.changePage(context, v);
                          //                           })
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
