import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/list_to_string.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/fie_lot_details_model/fie_lot_details_model.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/table.dart';
import 'payment_lot_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PaymentLotDetailsView extends StatelessWidget {
  const PaymentLotDetailsView({super.key, this.id, this.type});

  final String? id;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentLotDetailsViewModel>.reactive(
        viewModelBuilder: () => PaymentLotDetailsViewModel(),
        onViewModelReady: (PaymentLotDetailsViewModel model) {
          model.callDetails(id, type);
        },
        builder: (context, model, child) {
          return Scaffold(
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: AppLocalizations.of(context)!
                          .paymentLotDetails_header,
                    ),
                  ),
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
                              h1: AppLocalizations.of(context)!
                                  .paymentLotDetails_header,
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
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: device != ScreenSize.small
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(),
                                    Text(
                                      '${AppLocalizations.of(context)!.paymentLotDetails_paymentLot}${model.busy(model.fieLotList) ? "" : model.fieLotList!.data![0].lotNumber ?? 0}',
                                      style: AppTextStyles.headerText,
                                    ),
                                    const SizedBox(),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: SubmitButton(
                                        color: AppColors.webButtonColor,
                                        isRadius: false,
                                        height: 40,
                                        width: 80,
                                        onPressed: () {
                                          model.goBack(context);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .viewAll,
                                      ),
                                    ),
                                  ],
                                ),
                                20.0.giveHeight,
                                // if (model.fieLotList)
                                if (model.busy(model.fieLotList))
                                  Utils.bigLoader(),
                                model.busy(model.fieLotList)
                                    ? const SizedBox()
                                    : SingleChildScrollView(
                                        scrollDirection:
                                            device == ScreenSize.wide
                                                ? Axis.vertical
                                                : Axis.horizontal,
                                        child: SizedBox(
                                          width: device == ScreenSize.wide
                                              ? 100.0.wp
                                              : 1200,
                                          child: Column(
                                            children: [
                                              Table(
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                border: TableBorder.all(
                                                    color: AppColors
                                                        .tableHeaderBody),
                                                columnWidths: {
                                                  0: const FixedColumnWidth(
                                                      150.0), // fixed to 100 width
                                                  1: device == ScreenSize.wide
                                                      ? const FlexColumnWidth()
                                                      : const FixedColumnWidth(
                                                          150.0),
                                                  2: const FixedColumnWidth(
                                                      200.0),
                                                  3: const FixedColumnWidth(
                                                      200.0),
                                                  4: const FixedColumnWidth(
                                                      80.0), //
                                                  5: const FixedColumnWidth(
                                                      120.0), //f
                                                  6: const FixedColumnWidth(
                                                      120.0), //f
                                                  7: const FixedColumnWidth(
                                                      150.0), //f
                                                  8: const FixedColumnWidth(
                                                      100.0), //fixed to 100 width
                                                },
                                                children: [
                                                  TableRow(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .tableHeaderBody,
                                                      ),
                                                      children: [
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_LotId),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_lotType),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_dateGen),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_postingDate),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_currency),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_openBalanceAmount),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_amountPaid),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_user),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_status),
                                                      ]),
                                                  for (int i = 0;
                                                      i <
                                                          model.fieLotList!
                                                              .data!.length;
                                                      i++)
                                                    TableRow(
                                                      decoration: BoxDecoration(
                                                        border:
                                                            Utils.tableBorder,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      children: [
                                                        dataCell(
                                                            model.fieLotList!
                                                                .data![i].lotId!
                                                                .lastChars(10),
                                                            isCenter: false),
                                                        dataCell(
                                                            Utils.contractAccount(
                                                                model
                                                                    .fieLotList!
                                                                    .data![i]
                                                                    .lotType!),
                                                            isCenter: false),
                                                        dataCell(model
                                                            .fieLotList!
                                                            .data![i]
                                                            .dateGenerated!),
                                                        dataCell(model
                                                            .fieLotList!
                                                            .data![i]
                                                            .postingDate!),
                                                        dataCell(model
                                                            .fieLotList!
                                                            .data![i]
                                                            .currency!),
                                                        dataCellAmount(model
                                                                .fieLotList!
                                                                .data![i]
                                                                .openBalanceAmount ??
                                                            '0.0'),
                                                        dataCell(""),
                                                        dataCell(
                                                            model.fieLotList!
                                                                .data![i].user!
                                                                .lastChars(10),
                                                            isCenter: false),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      12.0),
                                                          child: statusBtn(
                                                              status: model
                                                                  .fieLotList!
                                                                  .data![i]
                                                                  .status!,
                                                              statusDescription: model
                                                                  .fieLotList!
                                                                  .data![i]
                                                                  .statusDescription!),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                              50.0.giveHeight,
                                              Container(
                                                color:
                                                    AppColors.tableHeaderBody,
                                                width: 100.0.wp,
                                                child: dataCellHdTitle(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .table_paymentDetails),
                                              ),
                                              30.0.giveHeight,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
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
                                                            onChanged:
                                                                (String v) {
                                                              model.searchData(
                                                                  v);
                                                            },
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Table(
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                border: TableBorder.all(
                                                    color: AppColors
                                                        .tableHeaderBody),
                                                columnWidths: const {
                                                  0: FixedColumnWidth(250.0),
                                                  1: FixedColumnWidth(150.0),
                                                  2: FixedColumnWidth(200.0),
                                                  3: FixedColumnWidth(200.0),
                                                  4: FixedColumnWidth(200.0),
                                                  5: FlexColumnWidth(),
                                                  6: FixedColumnWidth(120.0),
                                                },
                                                children: [
                                                  TableRow(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .tableHeaderBody,
                                                      ),
                                                      children: [
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_docId),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_docType),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_invoice),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_openBalance),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_amountApplied),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_businessPartnerId),
                                                        dataCellHd(AppLocalizations
                                                                .of(context)!
                                                            .table_creditLineId),
                                                      ]),
                                                ],
                                              ),
                                              for (int i = 0;
                                                  i < model.searchList.length;
                                                  i++)
                                                Table(
                                                  defaultVerticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  border: TableBorder.all(
                                                      color: AppColors
                                                          .tableHeaderBody),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(250.0),
                                                    1: FixedColumnWidth(150.0),
                                                    2: FixedColumnWidth(200.0),
                                                    3: FixedColumnWidth(200.0),
                                                    4: FixedColumnWidth(200.0),
                                                    5: FlexColumnWidth(),
                                                    6: FixedColumnWidth(120.0),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              color: AppColors
                                                                  .tableHeaderBody,
                                                              width: 1),
                                                          left: BorderSide(
                                                              color: AppColors
                                                                  .tableHeaderBody,
                                                              width: 1),
                                                          right: BorderSide(
                                                              color: AppColors
                                                                  .tableHeaderBody,
                                                              width: 1),
                                                        ),
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      children: [
                                                        dataCellHd(model
                                                            .formattedDocID(model
                                                                    .searchList[
                                                                        i]
                                                                    .partner ??
                                                                "")),
                                                        SizedBox.shrink(),
                                                        SizedBox.shrink(),
                                                        dataCellHd(model
                                                            .formatter
                                                            .format(model
                                                                .searchList[i]
                                                                .balance!)
                                                            .toString()),
                                                        dataCellHd(model
                                                            .formatter
                                                            .format(model
                                                                .searchList[i]
                                                                .amount!)
                                                            .toString()),
                                                        dataCell(''),
                                                        dataCell(''),
                                                      ],
                                                    ),
                                                    for (int j = 0;
                                                        j <
                                                            model
                                                                .dataList[i]
                                                                .paymentDetails!
                                                                .length;
                                                        j++)
                                                      TableRow(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                color: AppColors
                                                                    .tableHeaderBody,
                                                                width: 1),
                                                            left: BorderSide(
                                                                color: AppColors
                                                                    .tableHeaderBody,
                                                                width: 1),
                                                            right: BorderSide(
                                                                color: AppColors
                                                                    .tableHeaderBody,
                                                                width: 1),
                                                          ),
                                                          color: AppColors
                                                              .whiteColor,
                                                        ),
                                                        children: [
                                                          dataCell(model
                                                              .dataList[i]
                                                              .paymentDetails![
                                                                  j]
                                                              .documentId!
                                                              .lastChars(10)),
                                                          dataCell(model
                                                              .dataList[i]
                                                              .paymentDetails![
                                                                  j]
                                                              .documentType!),
                                                          dataCell(model
                                                              .dataList[i]
                                                              .paymentDetails![
                                                                  j]
                                                              .invoice!),
                                                          dataCell(model
                                                              .formatter
                                                              .format(model
                                                                      .dataList[
                                                                          i]
                                                                      .paymentDetails![
                                                                          j]
                                                                      .openBalance ??
                                                                  "0.00")
                                                              .toString()),
                                                          dataCell(model
                                                              .formatter
                                                              .format(model
                                                                      .dataList[
                                                                          i]
                                                                      .paymentDetails![
                                                                          j]
                                                                      .amountApplied ??
                                                                  "0.00")
                                                              .toString()),
                                                          dataCell(model
                                                              .formattedDocID(model
                                                                      .dataList[
                                                                          i]
                                                                      .paymentDetails![
                                                                          j]
                                                                      .businessPartnerId ??
                                                                  "")),
                                                          dataCell(model
                                                              .dataList[i]
                                                              .paymentDetails![
                                                                  j]
                                                              .creditLineId!
                                                              .lastChars(10)),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              if (!model.fieLotList!.success!)
                                                Utils.noDataWidget(context)
                                            ],
                                          ),
                                        ),
                                      ),
                                20.0.giveHeight,
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
