import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/web/retailers_wholesaler/retailer_parts/retailer_credit_line/details/retailer_creditline_details_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../widgets/web_widgets/body/table.dart';
import '../../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../../secondery_bar.dart';

class RetailerCreditlineDetailsView extends StatelessWidget {
  const RetailerCreditlineDetailsView({super.key, this.id, this.uid, this.ttx});
  final String? id;
  final String? uid;
  final String? ttx;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerCreditlineDetailsViewModel>.reactive(
        viewModelBuilder: () => RetailerCreditlineDetailsViewModel(),
        onViewModelReady: (RetailerCreditlineDetailsViewModel model) {
          model.getData(id);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Expanded(
                      child: SecondaryNameAppBar(
                        h1: 'Retailer Details',
                      ),
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
                              h1: 'Credit Line Header',
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
                                          Row(
                                            children: [
                                              NavButton(
                                                onTap: () {
                                                  model.changeSelectedTerms(0);
                                                },
                                                isBottom:
                                                    model.internalTabNumber ==
                                                        0,
                                                text: "Summary",
                                              ),
                                              NavButton(
                                                onTap: () {
                                                  model.changeSelectedTerms(1);
                                                },
                                                isBottom:
                                                    model.internalTabNumber ==
                                                        1,
                                                text: "Details",
                                              )
                                            ],
                                          ),
                                          if (model.internalTabNumber == 0)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Credit Line Documents',
                                                    style: AppTextStyles
                                                        .headerText,
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
                                                      width: device !=
                                                              ScreenSize.wide
                                                          ? null
                                                          : 100.0.wp - 64 - 16,
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
                                                                  ScreenSize
                                                                      .wide
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
                                                                      .table_creditLineId,
                                                                ),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_wholesalerName,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_financialInstitution),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_bankName,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_bankAccountNo),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_approveAmount,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_remainAmount),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_appDate,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_minimumCommitmentDate),
                                                              ]),
                                                          if (model
                                                              .approvedCreditlines
                                                              .isEmpty)
                                                            Utils.noDataWidget(
                                                                context,
                                                                height: 60.0),
                                                          for (int i = 0;
                                                              i <
                                                                  model
                                                                      .approvedCreditlines
                                                                      .length;
                                                              i++)
                                                            TableRow(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              children: [
                                                                dataCell(
                                                                    "${1 + i}"),
                                                                dataCell(
                                                                  model
                                                                      .approvedCreditlines[
                                                                          i]
                                                                      .creditlineId!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .approvedCreditlines[
                                                                          i]
                                                                      .wholesalerName!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .approvedCreditlines[
                                                                          i]
                                                                      .financialInstitution!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .approvedCreditlines[
                                                                          i]
                                                                      .bankName!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(model
                                                                    .approvedCreditlines[
                                                                        i]
                                                                    .bankAccountNumber!),
                                                                dataCellAmount((model
                                                                    .approvedCreditlines[
                                                                        i]
                                                                    .approvedAmount!)),
                                                                dataCellAmount((model
                                                                    .approvedCreditlines[
                                                                        i]
                                                                    .remainingAmount!)),
                                                                dataCell(model
                                                                    .approvedCreditlines[
                                                                        i]
                                                                    .dateApproved!),
                                                                dataCell(model
                                                                    .approvedCreditlines[
                                                                        i]
                                                                    .minimumCommitmentDate!),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                50.0.giveHeight,
                                                const Text(
                                                  'View Retailer Stores',
                                                  style:
                                                      AppTextStyles.headerText,
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
                                                      width: device !=
                                                              ScreenSize.wide
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
                                                                  ScreenSize
                                                                      .wide
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
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_assignedAmount),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_consumedAmount,
                                                                ),
                                                              ]),
                                                          if (model
                                                              .retailerStores
                                                              .isEmpty)
                                                            Utils.noDataWidget(
                                                                context,
                                                                height: 60.0),
                                                          for (int i = 0;
                                                              i <
                                                                  model
                                                                      .retailerStores
                                                                      .length;
                                                              i++)
                                                            TableRow(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              children: [
                                                                dataCell(
                                                                    "${1 + i}"),
                                                                dataCell(
                                                                  model
                                                                      .retailerStores[
                                                                          i]
                                                                      .locationName!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .retailerStores[
                                                                          i]
                                                                      .address!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCellAmount(model
                                                                    .retailerStores[
                                                                        i]
                                                                    .assignedAmount!),
                                                                dataCellAmount(model
                                                                    .retailerStores[
                                                                        i]
                                                                    .consumedAmount!),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (model.internalTabNumber == 1)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Credit Line Header',
                                                    style: AppTextStyles
                                                        .headerText,
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
                                                      width: device !=
                                                              ScreenSize.wide
                                                          ? null
                                                          : 100.0.wp - 64 - 16,
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
                                                                  ScreenSize
                                                                      .wide
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
                                                                      .table_saleId,
                                                                ),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_docType,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_docId),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_storeName,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_retailerName),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_invoice,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_currency),
                                                                dataCellHd(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .table_amount,
                                                                ),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_openBalance),
                                                              ]),
                                                          if (model.detailsData
                                                              .isEmpty)
                                                            Utils.noDataWidget(
                                                                context,
                                                                height: 60.0),
                                                          for (int i = 0;
                                                              i <
                                                                  model
                                                                      .detailsData
                                                                      .length;
                                                              i++)
                                                            TableRow(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              children: [
                                                                dataCell(
                                                                    "${1 + i}"),
                                                                dataCell(
                                                                  model
                                                                      .detailsData[
                                                                          i]
                                                                      .saleId!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(model
                                                                    .detailsData[
                                                                        i]
                                                                    .documentType!),
                                                                dataCell(
                                                                  model
                                                                      .detailsData[
                                                                          i]
                                                                      .documentId!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .detailsData[
                                                                          i]
                                                                      .storeName!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .detailsData[
                                                                          i]
                                                                      .retailerName!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(
                                                                  model
                                                                      .detailsData[
                                                                          i]
                                                                      .invoice!,
                                                                  isCenter:
                                                                      false,
                                                                ),
                                                                dataCell(model
                                                                    .detailsData[
                                                                        i]
                                                                    .currency!),
                                                                dataCellAmount(model
                                                                    .detailsData[
                                                                        i]
                                                                    .amount!),
                                                                dataCellAmount(model
                                                                    .detailsData[
                                                                        i]
                                                                    .openBalance!),
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
}
