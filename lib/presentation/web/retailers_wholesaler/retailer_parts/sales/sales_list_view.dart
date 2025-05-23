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

import '../../../../../const/server_status_file/server_status_file.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../secondery_bar.dart';
import 'sales_list_view_model.dart';

class RetailersSalesListView extends StatelessWidget {
  const RetailersSalesListView({super.key, this.ttx, this.uid, this.page});

  final String? ttx;
  final String? uid;
  final String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailersSalesListViewModel>.reactive(
        viewModelBuilder: () => RetailersSalesListViewModel(),
        onViewModelReady: (RetailersSalesListViewModel model) {
          model.getData(ttx, uid, page);
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
                      h1: 'View Sales Details',
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
                              h1: 'View Sales Details',
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
                                                'Sales Information',
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
                                                            200.0)
                                                        : const FlexColumnWidth(),
                                                    2: device != ScreenSize.wide
                                                        ? const FixedColumnWidth(
                                                            150.0)
                                                        : const FlexColumnWidth(),
                                                    3: const FixedColumnWidth(
                                                        200.0),
                                                    4: const FixedColumnWidth(
                                                        200.0),
                                                    5: const FixedColumnWidth(
                                                        200.0),
                                                    6: const FixedColumnWidth(
                                                        200.0),
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
                                                                .table_sNo,
                                                          ),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_saleId,
                                                          ),
                                                          dataCellHd(
                                                            "${AppLocalizations.of(context)!.table_dueDate}\n[(GMT-04:00) La Paz]",
                                                          ),
                                                          dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_currency),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_saleAmount,
                                                          ),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_saleBalance,
                                                          ),
                                                          dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_consumedAmount,
                                                          ),
                                                        ]),
                                                    for (int i = 0;
                                                        i <
                                                            model.allSales
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
                                                            "${1 + i}",
                                                          ),
                                                          dataCell(
                                                            model.allSales[i]
                                                                .uniqueId!
                                                                .lastChars(10),
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model.allSales[i]
                                                                .dueDate!,
                                                          ),
                                                          dataCell(
                                                            model.allSales[i]
                                                                .currency!,
                                                          ),
                                                          dataCellAmount(
                                                            model.allSales[i]
                                                                .amount!,
                                                          ),
                                                          dataCellAmount(
                                                            model.allSales[i]
                                                                .balance!,
                                                          ),
                                                          model.allSales[i]
                                                              .status!
                                                              .toSaleStatus(
                                                            textAlign: TextAlign
                                                                .center,
                                                            isIconAvailable:
                                                                false,
                                                            textStyle: AppTextStyles
                                                                .statusCardStatus
                                                                .copyWith(
                                                                    fontSize:
                                                                        14),
                                                            text: StatusFile
                                                                .statusForSale(
                                                                    'en',
                                                                    model
                                                                        .allSales[
                                                                            i]
                                                                        .status!,
                                                                    model
                                                                        .allSales[
                                                                            i]
                                                                        .statusDescription!),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (model.allSales.isEmpty)
                                            Utils.noDataWidget(context,
                                                height: 60.0),
                                          20.0.giveHeight,
                                          if (model.allSales.isNotEmpty)
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
                                                      model.changePage(
                                                          context, ttx, uid, v);
                                                    })
                                        ],
                                      ),
                              ],
                            ),
                            child: SecondaryBar(ttx, uid),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(
                          //       device != ScreenSize.wide ? 12.0 : 32.0),
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
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     const Text(
                          //                       'Sales Information',
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
                          //                                   200.0)
                          //                               : const FlexColumnWidth(),
                          //                           2: device != ScreenSize.wide
                          //                               ? const FixedColumnWidth(
                          //                                   150.0)
                          //                               : const FlexColumnWidth(),
                          //                           3: const FixedColumnWidth(
                          //                               200.0),
                          //                           4: const FixedColumnWidth(
                          //                               200.0),
                          //                           5: const FixedColumnWidth(
                          //                               200.0),
                          //                           6: const FixedColumnWidth(
                          //                               200.0),
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
                          //                                       .table_sNo,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_saleId,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   "${AppLocalizations.of(context)!.table_dueDate}\n[(GMT-04:00) La Paz]",
                          //                                 ),
                          //                                 dataCellHd(
                          //                                     AppLocalizations.of(
                          //                                             context)!
                          //                                         .table_currency),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_saleAmount,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_saleBalance,
                          //                                 ),
                          //                                 dataCellHd(
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .table_consumedAmount,
                          //                                 ),
                          //                               ]),
                          //                           for (int i = 0;
                          //                               i <
                          //                                   model.allSales
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
                          //                                   "${1 + i}",
                          //                                 ),
                          //                                 dataCell(
                          //                                   model.allSales[i]
                          //                                       .uniqueId!
                          //                                       .lastChars(10),
                          //                                   isCenter: false,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model.allSales[i]
                          //                                       .dueDate!,
                          //                                 ),
                          //                                 dataCell(
                          //                                   model.allSales[i]
                          //                                       .currency!,
                          //                                 ),
                          //                                 dataCellAmount(
                          //                                   model.allSales[i]
                          //                                       .amount!,
                          //                                 ),
                          //                                 dataCellAmount(
                          //                                   model.allSales[i]
                          //                                       .balance!,
                          //                                 ),
                          //                                 model.allSales[i]
                          //                                     .status!
                          //                                     .toSaleStatus(
                          //                                   textAlign: TextAlign
                          //                                       .center,
                          //                                   isIconAvailable:
                          //                                       false,
                          //                                   textStyle: AppTextStyles
                          //                                       .statusCardStatus
                          //                                       .copyWith(
                          //                                           fontSize:
                          //                                               14),
                          //                                   text: StatusFile
                          //                                       .statusForSale(
                          //                                           'en',
                          //                                           model
                          //                                               .allSales[
                          //                                                   i]
                          //                                               .status!,
                          //                                           model
                          //                                               .allSales[
                          //                                                   i]
                          //                                               .statusDescription!),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 if (model.allSales.isEmpty)
                          //                   Utils.noDataWidget(context,
                          //                       height: 60.0),
                          //                 20.0.giveHeight,
                          //                 if (model.allSales.isNotEmpty)
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
                          //                             model.changePage(
                          //                                 context, ttx, uid, v);
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
