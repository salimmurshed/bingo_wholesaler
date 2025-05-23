import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
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
import 'fie_financial_statements_sale_list_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieFinancialStatementSaleListViewWeb extends StatelessWidget {
  FieFinancialStatementSaleListViewWeb(
      {super.key, this.id, required this.enroll});

  String? id;
  String? enroll;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FieFinancialStatementSaleListViewModel>.reactive(
        viewModelBuilder: () => FieFinancialStatementSaleListViewModel(),
        onViewModelReady: (FieFinancialStatementSaleListViewModel model) {
          model.getParams(id, enroll);
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
                      h1: 'View all Financials',
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
                              h1: 'View all Financials',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.busy(model.StatdataAllSale)
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: '$enroll',
                                              style: AppTextStyles.headerText
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationStyle:
                                                    TextDecorationStyle.solid,
                                                decorationThickness: 2,
                                                height: 1.5,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      ' Financial Statements List',
                                                  style: AppTextStyles
                                                      .headerText
                                                      .copyWith(
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Row(
                                          //   children: [
                                          //     NavButton(
                                          //       isBottom:
                                          //           enroll!.toLowerCase() ==
                                          //               "wholesaler",
                                          //       text: "Wholesaler",
                                          //       onTap: () {
                                          //         model
                                          //             .changeFieClientsStatementScreen(
                                          //                 id!,
                                          //                 context,
                                          //                 "Wholesaler");
                                          //       },
                                          //     ),
                                          //     NavButton(
                                          //       isBottom:
                                          //           enroll!.toLowerCase() ==
                                          //               "retailer",
                                          //       text: "Retailer",
                                          //       onTap: () {
                                          //         model
                                          //             .changeFieClientsStatementScreen(
                                          //                 id!,
                                          //                 context,
                                          //                 "Retailer");
                                          //       },
                                          //     ),
                                          //     NavButton(
                                          //       isBottom:
                                          //           enroll!.toLowerCase() ==
                                          //               "fie",
                                          //       text: "FIE",
                                          //       onTap: () {
                                          //         Utils.fPrint(enroll!.toUpperCase() ==
                                          //             "fie");
                                          //         model
                                          //             .changeFieClientsStatementScreen(
                                          //                 id!, context, "FIE");
                                          //       },
                                          //     ),
                                          //     NavButton(
                                          //       isBottom:
                                          //           enroll!.toLowerCase() ==
                                          //               "bingo",
                                          //       text: "Bingo",
                                          //       onTap: () {
                                          //         model
                                          //             .changeFieClientsStatementScreen(
                                          //                 id!,
                                          //                 context,
                                          //                 "Bingo");
                                          //       },
                                          //     ),
                                          //   ],
                                          // ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SizedBox(
                                              width: 120,
                                              height: 30,
                                              child: SubmitButton(
                                                fontWeight: FontWeight.w600,
                                                onPressed: () {
                                                  model.goBack(context, enroll);
                                                },
                                                text: 'Back',
                                                isRadius: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(AppLocalizations.of(
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      SingleChildScrollView(
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
                                            columnWidths: const {
                                              0: FixedColumnWidth(
                                                  50.0), // fixed to 100 width
                                              1: FixedColumnWidth(150.0),
                                              2: FixedColumnWidth(100.0),
                                              3: FixedColumnWidth(150.0),
                                              4: FixedColumnWidth(150.0), //
                                              5: FixedColumnWidth(100.0), //f
                                              6: FixedColumnWidth(100.0),
                                              7: FixedColumnWidth(100.0),
                                              8: FixedColumnWidth(100.0),
                                              9: FixedColumnWidth(100.0),
                                              10: FixedColumnWidth(100.0),
                                              11: FixedColumnWidth(
                                                  100.0), //fixed to 100 width
                                            },
                                            children: [
                                              TableRow(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors
                                                        .tableHeaderColor,
                                                  ),
                                                  children: [
                                                    dataCellHd("Sr. No."),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .saleId),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .documentType
                                                        .replaceAll(" ", "\n")),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .documentId),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .contractAccount
                                                        .replaceAll(" ", "\n")),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .dateGenerated
                                                        .replaceAll(" ", "\n")),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .dueDate
                                                        .replaceAll(" ", "\n")),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .invoice),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .currency
                                                        .toUpperCamelCase()),
                                                    dataCellHd(AppLocalizations
                                                            .of(context)!
                                                        .amount
                                                        .toUpperCamelCase()),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .openBalance),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .status),
                                                  ]),
                                              for (int i = 0;
                                                  i <
                                                      model.StatdataAllSale
                                                          .length;
                                                  i++)
                                                TableRow(
                                                  decoration: BoxDecoration(
                                                    border: Utils.tableBorder,
                                                    color: AppColors
                                                        .tableHeaderBody,
                                                  ),
                                                  children: [
                                                    dataCell(
                                                        "${model.StatFrom + i}"),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .saleUniqueId!
                                                        .lastChars(10)),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .documentType!),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .documentId!
                                                        .lastChars(10)),
                                                    dataCell(Utils
                                                        .contractAccount(model
                                                            .StatdataAllSale[i]
                                                            .contractAccount!)),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .dateGenerated!),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .dueDate!),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .invoice!),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .currency!),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .amount!
                                                        .toString()),
                                                    dataCell(model
                                                        .StatdataAllSale[i]
                                                        .openBalance!
                                                        .toString()),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12.0),
                                                      child: statusBtn(
                                                          status: model
                                                              .StatdataAllSale[
                                                                  i]
                                                              .status!,
                                                          statusDescription: model
                                                              .StatdataAllSale[
                                                                  i]
                                                              .statusDescription!),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (model.StatdataAllSale.isEmpty)
                                        Utils.noDataWidget(context),
                                      20.0.giveHeight,
                                      if (model.StatParPage > 1)
                                        model.busy(model.StatdataAllSale)
                                            ? const SizedBox()
                                            : PaginationWidget(
                                                totalPage: model.StatParPage < 1
                                                    ? 0
                                                    : model.totalPage,
                                                perPage: model.StatParPage < 1
                                                    ? model
                                                        .StatdataAllSale.length
                                                    : model.StatParPage,
                                                startTo: model.StatTo,
                                                startFrom: model.StatFrom,
                                                pageNumber:
                                                    model.finStatPageNumber,
                                                total: model.StatTotalData,
                                                onPageChange: (int v) {
                                                  model.changePage(v, enroll);
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

  Widget statusBtn({String statusDescription = "", int status = 0}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: status.toStatusFinStatWeb(),
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
