import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import '../../../../const/app_sizes/app_sizes.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import 'retailers_creditline_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class RetailersCreditlineView extends StatelessWidget {
  const RetailersCreditlineView({super.key, this.uid, this.type});

  final String? uid;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailersCreditlineViewModel>.reactive(
        viewModelBuilder: () => RetailersCreditlineViewModel(),
        onViewModelReady: (RetailersCreditlineViewModel model) {
          model.getRetailerApprovedCreditLines(uid, type);
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
                      h1: 'Credit Line Details',
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
                              h1: 'Credit Line Details',
                            ),
                          Container(
                            padding: AppPaddings.webBodyPadding,
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NavButton(
                                            onTap: () {
                                              model.changeScreenTab(0);
                                            },
                                            isBottom: model.tab == 0,
                                            text: "Summary",
                                          ),
                                          NavButton(
                                            onTap: () {
                                              model.changeScreenTab(1);
                                            },
                                            isBottom: model.tab == 1,
                                            text: "Detail",
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      if (model.tab == 0)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Credit Line Header',
                                              style: AppTextStyles.headerText,
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                            Scrollbar(
                                              controller:
                                                  model.scrollController,
                                              thickness: 10,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width:
                                                      device != ScreenSize.wide
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
                                                          120.0),
                                                      2: const FixedColumnWidth(
                                                          120.0),

                                                      3: const FixedColumnWidth(
                                                          140.0),
                                                      4: const FixedColumnWidth(
                                                          150.0),
                                                      5: const FixedColumnWidth(
                                                          130.0),
                                                      6: const FixedColumnWidth(
                                                          80.0),
                                                      7: const FixedColumnWidth(
                                                          100.0),
                                                      8: const FixedColumnWidth(
                                                          100.0),
                                                      9: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              130.0)
                                                          : const FlexColumnWidth(),
                                                      10: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              130.0)
                                                          : const FlexColumnWidth(), //f
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
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_creditLineId,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_wholesalerName,
                                                            ),
                                                            dataCellHd(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .financialIns),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_bankName,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .bankAccountNumber,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .currency,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_appAmount,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_remainAmount,
                                                            ),
                                                            dataCellHd(AppLocalizations
                                                                    .of(context)!
                                                                .table_appDate),
                                                            dataCellHd(AppLocalizations
                                                                    .of(context)!
                                                                .table_minimumCommitmentDate),
                                                          ]),
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
                                                            "${1}",
                                                          ),
                                                          dataCell(
                                                            model.data!
                                                                .internalId!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model.data!
                                                                .wholesalerName!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model
                                                                .data!.fieName!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model.data!
                                                                .bankName!,
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model.data!
                                                                .bankAccountNumber!
                                                                .lastChars(4),
                                                            isCenter: false,
                                                          ),
                                                          dataCell(
                                                            model.data!
                                                                .currency!,
                                                          ),
                                                          dataCellAmount(model
                                                              .data!
                                                              .approvedAmount!),
                                                          dataCellAmount(model
                                                              .data!
                                                              .remainAmount!),
                                                          dataCell(
                                                            model.data!
                                                                .approvedDate!,
                                                            isCenter: true,
                                                          ),
                                                          model.isEdit
                                                              ? dataCell(
                                                                  model.data!
                                                                      .minimumCommitmentDate!,
                                                                  isCenter:
                                                                      true,
                                                                )
                                                              : dataCell(
                                                                  model.data!
                                                                      .minimumCommitmentDate!,
                                                                  isCenter:
                                                                      true,
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 24.0),
                                              child: Text(
                                                'View Retailer Stores\nEffective Date : ${model.data!.effectiveDate!} [${model.data!.timezone!}]',
                                                style: AppTextStyles.headerText,
                                              ),
                                            ),
                                            Scrollbar(
                                              controller:
                                                  model.scrollController,
                                              thickness: 10,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width:
                                                      device != ScreenSize.wide
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
                                                          200.0),
                                                      2: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              150.0)
                                                          : const FlexColumnWidth(),
                                                      3: const FixedColumnWidth(
                                                          200.0),
                                                      4: const FixedColumnWidth(
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
                                                                  .sNo,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_locationName,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_address,
                                                            ),
                                                            dataCellHd(AppLocalizations
                                                                    .of(context)!
                                                                .table_assignedAmount),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_consumedAmount,
                                                            ),
                                                          ]),
                                                      for (int i = 0;
                                                          i <
                                                              model
                                                                  .data!
                                                                  .retailerStoreDetails!
                                                                  .length;
                                                          i++)
                                                        TableRow(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Utils
                                                                .tableBorder,
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
                                                                "${1 + i}",
                                                                isCenter: false,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .data!
                                                                    .retailerStoreDetails![
                                                                        i]
                                                                    .name!,
                                                                isCenter: false,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .data!
                                                                    .retailerStoreDetails![
                                                                        i]
                                                                    .address!,
                                                                isCenter: false,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child:
                                                                  dataCellAmount(
                                                                Utils.stringTo2Decimal(model
                                                                    .data!
                                                                    .retailerStoreDetails![
                                                                        i]
                                                                    .amount!
                                                                    .toString()),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child:
                                                                  dataCellAmount(
                                                                Utils.stringTo2Decimal(model
                                                                    .data!
                                                                    .retailerStoreDetails![
                                                                        i]
                                                                    .consumedAmount!
                                                                    .toString()),
                                                              ),
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
                                      if (model.tab == 1)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Creditline Documents',
                                              style: AppTextStyles.headerText,
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                            Scrollbar(
                                              controller:
                                                  model.scrollController,
                                              thickness: 10,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width:
                                                      device != ScreenSize.wide
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
                                                          120.0),
                                                      2: const FixedColumnWidth(
                                                          120.0),

                                                      3: const FixedColumnWidth(
                                                          170.0),
                                                      4: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              150.0)
                                                          : const FlexColumnWidth(),
                                                      5: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              150.0)
                                                          : const FlexColumnWidth(),
                                                      6: const FixedColumnWidth(
                                                          120.0),
                                                      7: const FixedColumnWidth(
                                                          120.0),
                                                      8: const FixedColumnWidth(
                                                          150.0),
                                                      9: const FixedColumnWidth(
                                                          150.0) //f
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
                                                                  .table_storeName,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
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
                                                                  .table_currency,
                                                            ),
                                                            dataCellHd(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .table_amount),
                                                            dataCellHd(AppLocalizations
                                                                    .of(context)!
                                                                .table_openBalance),
                                                          ]),
                                                      for (int i = 0;
                                                          i <
                                                              model
                                                                  .data!
                                                                  .creditlineDocuments!
                                                                  .length;
                                                          i++)
                                                        TableRow(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Utils
                                                                .tableBorder,
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
                                                                "${1 + i}",
                                                              ),
                                                            ),
                                                            dataCell(
                                                                model
                                                                    .data!
                                                                    .creditlineDocuments![
                                                                        i]
                                                                    .saleUniqueId!
                                                                    .lastChars(
                                                                        10),
                                                                isCenter:
                                                                    false),
                                                            dataCell(
                                                              model
                                                                  .data!
                                                                  .creditlineDocuments![
                                                                      i]
                                                                  .documentType!,
                                                            ),
                                                            dataCell(
                                                              model
                                                                  .data!
                                                                  .creditlineDocuments![
                                                                      i]
                                                                  .documentTypeUniqueId!
                                                                  .lastChars(
                                                                      10),
                                                              isCenter: false,
                                                            ),
                                                            dataCell(
                                                              model
                                                                  .data!
                                                                  .creditlineDocuments![
                                                                      i]
                                                                  .storeName!,
                                                              isCenter: false,
                                                            ),
                                                            dataCell(
                                                                model
                                                                    .data!
                                                                    .creditlineDocuments![
                                                                        i]
                                                                    .storeName!,
                                                                isCenter:
                                                                    false),
                                                            dataCell(
                                                                model
                                                                    .data!
                                                                    .creditlineDocuments![
                                                                        i]
                                                                    .invoice!,
                                                                isCenter:
                                                                    false),
                                                            dataCell(model
                                                                .data!
                                                                .creditlineDocuments![
                                                                    i]
                                                                .currency!),
                                                            dataCellAmount(model
                                                                .data!
                                                                .creditlineDocuments![
                                                                    i]
                                                                .amount!
                                                                .toString()),
                                                            dataCellAmount(model
                                                                .data!
                                                                .creditlineDocuments![
                                                                    i]
                                                                .openBalance!
                                                                .toString()),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
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
}
