import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/server_status_file/server_status_file.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import 'sale_transaction_view_model.dart';

class SaleTransactionView extends StatelessWidget {
  const SaleTransactionView({super.key, this.id, this.type, this.transaction});

  final String? id;
  final String? type;
  final String? transaction;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SaleTransactionViewModel>.reactive(
        viewModelBuilder: () => SaleTransactionViewModel(),
        onViewModelReady: (SaleTransactionViewModel model) {
          model.prefill(id, 1);
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
                      h1: 'Transaction Documents',
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
                              h1: 'Transaction Documents',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 8.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        NavButton(
                                          isBottom: transaction == null,
                                          text: AppLocalizations.of(context)!
                                              .saleDetailScreen_tab2,
                                          onTap: () {
                                            model.changeTabForSaleDetails(
                                                0, context);
                                          },
                                        ),
                                        NavButton(
                                          isBottom: transaction != null,
                                          text: AppLocalizations.of(context)!
                                              .saleDetailScreen_tab3,
                                          onTap: () {
                                            model.changeTabForSaleDetails(
                                                1, context);
                                          },
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: SubmitButton(
                                        color: AppColors.webButtonColor,
                                        isRadius: false,
                                        height: 40,
                                        width: 80,
                                        onPressed: () {
                                          // Navigator.pop(context);
                                          model.goBack(context);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .viewAll,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.dividerColor,
                                ),
                                Scrollbar(
                                  controller: model.scrollController,
                                  thickness: 10,
                                  child: SingleChildScrollView(
                                    controller: model.scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: device == ScreenSize.wide
                                          ? 100.0.wp - (80)
                                          : 1200,
                                      child: Stack(
                                        children: [
                                          Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            border: TableBorder.all(
                                                color:
                                                    AppColors.tableHeaderBody),
                                            columnWidths: {
                                              0: const FixedColumnWidth(50.0),
                                              1: device != ScreenSize.wide
                                                  ? const FixedColumnWidth(
                                                      120.0)
                                                  : const FlexColumnWidth(),
                                              2: const FixedColumnWidth(90.0),
                                              3: const FixedColumnWidth(120.0),
                                              4: const FixedColumnWidth(120.0),
                                              5: const FixedColumnWidth(100.0),
                                              6: const FixedColumnWidth(100.0),
                                              7: const FixedColumnWidth(80.0),
                                              8: const FixedColumnWidth(80.0),
                                              9: const FixedColumnWidth(100.0),
                                              10: const FixedColumnWidth(100.0),
                                              11: const FixedColumnWidth(100.0),
                                              12: const FixedColumnWidth(100.0),
                                              13: const FixedColumnWidth(100.0),
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
                                                          .table_no,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_saleId,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_docType,
                                                    ),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_docId),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_collectionLotId,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_storeName,
                                                    ),
                                                    dataCellHd(
                                                      model.enrollment ==
                                                              UserTypeForWeb
                                                                  .retailer
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .table_wholesalerName
                                                          : AppLocalizations.of(
                                                                  context)!
                                                              .table_retailerName,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_invoice,
                                                    ),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_currency),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_amount,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_openBalance,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_amountApplied,
                                                    ),
                                                    dataCellHd(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .table_postingDate,
                                                    ),
                                                    dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_status),
                                                  ]),
                                              for (int i = 0;
                                                  i < model.statements.length;
                                                  i++)
                                                TableRow(
                                                  decoration: BoxDecoration(
                                                    border: Utils.tableBorder,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  children: [
                                                    dataCell(
                                                      "${i + model.pageFrom}",
                                                      isCenter: true,
                                                    ),
                                                    dataCell(
                                                      model.statements[i].saleId
                                                          .toString()
                                                          .lastChars(10),
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .documentType!,
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .documentId!
                                                          .lastChars(10),
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .documentId!
                                                          .lastChars(10),
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .storeName!,
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.enrollment ==
                                                              UserTypeForWeb
                                                                  .retailer
                                                          ? model.statements[i]
                                                              .wholesalerName!
                                                          : model.statements[i]
                                                              .retailerName!,
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .invoice!,
                                                      isCenter: false,
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .currency!,
                                                    ),
                                                    dataCellAmount(
                                                      model.statements[i]
                                                          .amount!,
                                                    ),
                                                    dataCellAmount(
                                                      model.statements[i]
                                                          .openBalance!,
                                                    ),
                                                    dataCellAmount(
                                                      "0.00",
                                                    ),
                                                    dataCell(
                                                      model.statements[i]
                                                          .dueDate!,
                                                      isCenter: true,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: model.statements[i].status!.toStatusFinStat(
                                                            textStyle: AppTextStyles
                                                                .statusCardStatus
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.0),
                                                            value: StatusFile.statusForFinState(
                                                                "en",
                                                                model
                                                                    .statements[
                                                                        i]
                                                                    .status!,
                                                                model
                                                                    .statements[
                                                                        i]
                                                                    .statusDescription!))

                                                        // dataCell(
                                                        //   model.statements[i]
                                                        //       .statusDescription!,
                                                        // ),
                                                        ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (model.isBusy) Utils.bigLoader(),
                                if (!model.isBusy)
                                  if (model.statements.isEmpty)
                                    Utils.noDataWidget(context, height: 60.0),
                              ],
                            ),
                          ),
                          20.0.giveHeight,
                          if (model.haveStatements)
                            model.isBusy
                                ? const SizedBox()
                                : PaginationWidget(
                                    totalPage: model.totalPage,
                                    perPage: 1,
                                    startTo: model.pageTo,
                                    startFrom: model.pageFrom,
                                    pageNumber: model.pageNumber,
                                    total: model.dataTotal,
                                    onPageChange: (int v) {
                                      model.changePage(context, v);
                                    })
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
