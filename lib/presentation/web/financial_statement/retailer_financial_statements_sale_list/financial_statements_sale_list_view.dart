import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/web/financial_statement/retailer_financial_statements/financial_statements_view.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';
import '/const/web_devices.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import 'financial_statements_sale_list_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetailerFinancialStatementSaleListViewWeb extends StatelessWidget {
  const RetailerFinancialStatementSaleListViewWeb(
      {super.key, this.id, this.statePage, this.to, this.from});

  final String? id;
  final String? statePage;
  final String? to;
  final String? from;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<
            RetailerFinancialStatementSaleListViewModel>.reactive(
        viewModelBuilder: () => RetailerFinancialStatementSaleListViewModel(),
        onViewModelReady: (RetailerFinancialStatementSaleListViewModel model) {
          model.getParams(id);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          SecondaryNameAppBar(
                            h1: AppLocalizations.of(context)!.finScreen_header,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .finScreen_body,
                                      style: AppTextStyles.headerText,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .search),
                                            ),
                                            10.0.giveWidth,
                                            SizedBox(
                                              width: 100,
                                              height: 70,
                                              child: NameTextField(
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.ashColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            width: 120,
                                            height: 30,
                                            child: SubmitButton(
                                              fontWeight: FontWeight.w600,
                                              onPressed: () {
                                                model.goBack(context, statePage,
                                                    from, to);
                                              },
                                              text: 'Back',
                                              isRadius: false,
                                            ),
                                          ),
                                        ),
                                        if (!model.isBusy)
                                          if (model.enrollment ==
                                              UserTypeForWeb.retailer)
                                            if (model
                                                .allData[0].canStartPayment!)
                                              Row(
                                                children: [
                                                  10.0.giveWidth,
                                                  SizedBox(
                                                    width: 200,
                                                    height: 30,
                                                    child: SubmitButton(
                                                      isRadius: false,
                                                      onPressed: () {
                                                        model.createPayment(
                                                            context, id);
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .startPayment,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                20.0.giveHeight,
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : SingleChildScrollView(
                                        scrollDirection:
                                            device == ScreenSize.wide
                                                ? Axis.vertical
                                                : Axis.horizontal,
                                        child: SizedBox(
                                          width: device == ScreenSize.wide
                                              ? 100.0.wp
                                              : 1200,
                                          child: Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            border: TableBorder.all(
                                                color:
                                                    AppColors.tableHeaderBody),
                                            children: [
                                              TableRow(children: [
                                                Table(
                                                  columnWidths:
                                                      widthsWholesaler,
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Table(
                                                          defaultVerticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          border: TableBorder.all(
                                                              color: AppColors
                                                                  .tableHeaderBody),
                                                          columnWidths:
                                                              widthsWholesaler,
                                                          children: [
                                                            mainHeader(
                                                              context,
                                                              model.enrollment,
                                                              withDetails:
                                                                  false,
                                                              withSelection:
                                                                  false,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]),
                                              TableRow(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors
                                                        .webBackgroundColor,
                                                  ),
                                                  children: [
                                                    Table(
                                                      defaultVerticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      border: TableBorder.all(
                                                          color: AppColors
                                                              .tableHeaderBody),
                                                      columnWidths: const {
                                                        0: FlexColumnWidth(),
                                                        1: FixedColumnWidth(
                                                            80.0),
                                                        2: FixedColumnWidth(
                                                            100.0),
                                                        3: FixedColumnWidth(
                                                            80.0),
                                                      },
                                                      children: [
                                                        TableRow(children: [
                                                          dataCellInMiddle(""),
                                                          dataCellInMiddle(
                                                              model
                                                                  .financialStatementsDetailsGroupMetadata!
                                                                  .totalAmount!,
                                                              style: AppTextStyles
                                                                  .webTableBody
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900)),
                                                          dataCellInMiddle(
                                                              model
                                                                  .financialStatementsDetailsGroupMetadata!
                                                                  .totalOpenBalance!,
                                                              style: AppTextStyles
                                                                  .webTableBody
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900)),
                                                          dataCellInMiddle(""),
                                                        ])
                                                      ],
                                                    )
                                                  ]),
                                              TableRow(children: [
                                                Table(
                                                  columnWidths:
                                                      widthsWholesaler,
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Table(
                                                          border: TableBorder.all(
                                                              color: AppColors
                                                                  .tableHeaderBody),
                                                          columnWidths:
                                                              widthsWholesaler,
                                                          children: [
                                                            for (int j = 0;
                                                                j <
                                                                    model
                                                                        .allData
                                                                        .length;
                                                                j++)
                                                              bodyRowsForDetailsScreen(
                                                                model
                                                                    .allData[j],
                                                                j +
                                                                    model
                                                                        .StatFrom,
                                                                [],
                                                                model
                                                                    .enrollment,
                                                                withDetails:
                                                                    false,
                                                                withSelection:
                                                                    false,
                                                              )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                if (model.allData.isEmpty)
                                  model.isBusy
                                      ? const SizedBox()
                                      : noDataInTable(),
                                if (model.StatParPage > 1) 20.0.giveHeight,
                                model.isBusy
                                    ? const SizedBox()
                                    : PaginationWidget(
                                        totalPage: model.StatParPage < 1
                                            ? 0
                                            : model.totalPage,
                                        perPage: model.StatParPage < 1
                                            ? model.allData.length
                                            : model.StatParPage,
                                        startTo: model.StatTo,
                                        startFrom: model.StatFrom,
                                        pageNumber: model.finStatPageNumber,
                                        total: model.StatTotalData,
                                        onPageChange: (int v) {
                                          model.changePageForSale(id, v);
                                        })
                              ],
                            ),
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
//
// Widget statusBtn({String statusDescription = "", int status = 0}) {
//   return TableCell(
//     verticalAlignment: TableCellVerticalAlignment.middle,
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//       decoration: BoxDecoration(
//         color: status.toStatusFinStatWeb(),
//         borderRadius: BorderRadius.circular(3),
//       ),
//       child: AutoSizeText(
//         // group: model.my
//         statusDescription,
//         style: const TextStyle(color: AppColors.whiteColor, fontSize: 12.0),
//       ),
//     ),
//   );
// }
}
