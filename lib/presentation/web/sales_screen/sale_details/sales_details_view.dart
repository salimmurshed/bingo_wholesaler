import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/data_models/models/sale_details_transection_model/sale_details_transection_model.dart';
import 'package:bingo/presentation/web/sales_screen/sale_details/sales_details_view_model.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../const/app_styles/app_box_decoration.dart';
import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/cards/shimmer.dart';
import '../../../widgets/dropdowns/selected_dropdown.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/shimmer.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/text_fields/sale_text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaleDetailsView extends StatelessWidget {
  const SaleDetailsView({super.key, this.id, this.type, this.transaction});

  final String? id;
  final String? type;
  final String? transaction;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SaleDetailsViewModel>.reactive(
        viewModelBuilder: () => SaleDetailsViewModel(),
        onViewModelReady: (SaleDetailsViewModel model) {
          model.callApi(id!, type!, transaction);
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
                      h1: "View ${model.status} (Sales Orders) Details",
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
                              h1: "View ${model.status} (Sales Orders) Details",
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 8.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        if (model.isEdit)
                                          NavButton(
                                            isBottom: true,
                                            text: AppLocalizations.of(context)!
                                                .saleDetailScreen_tab1,
                                            onTap: () {
                                              model.changeTabForSaleDetails(
                                                  0, context);
                                            },
                                          ),
                                        if (!model.isEdit)
                                          NavButton(
                                            isBottom: transaction == null,
                                            text: AppLocalizations.of(context)!
                                                .saleDetailScreen_tab2,
                                            onTap: () {
                                              model.changeTabForSaleDetails(
                                                  0, context);
                                            },
                                          ),
                                        if (!model.isEdit)
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
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       bottom: 12.0, top: 20.0),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             top: 8.0),
                                          //         child: Text(
                                          //           "Available amount to selected store is ${model.currency} ${model.availableAmount}",
                                          //           style: AppTextStyles
                                          //               .saleAvailabilityStyle,
                                          //         ),
                                          //       ),
                                          //       const SizedBox(),
                                          //     ],
                                          //   ),
                                          // ),
                                          // const Divider(
                                          // color: AppColors.dividerColor,),
                                          if (model.isBusy) Utils.bigLoader(),
                                          if (!model.isBusy)
                                            Column(
                                              children: [
                                                if (model
                                                        .selectedTabForSaleDetails ==
                                                    0)
                                                  saleDetails(model, context)
                                                else
                                                  transactions(
                                                      context,
                                                      model
                                                          .saleDetailsTransection
                                                          .data![0]
                                                          .tranctionDetails!,
                                                      model)
                                              ],
                                            )
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Column saleDetails(SaleDetailsViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0.wp,
          child: Wrap(
            runSpacing: 20.0,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            children: [
              SaleTextField(
                AppLocalizations.of(context)!.invoiceTo,
                model.invoiceToController,
              ),
              SaleTextField(
                  AppLocalizations.of(context)!.fieName.replaceAll(":", ""),
                  model.fieNameController),
              SaleTextField(
                  AppLocalizations.of(context)!
                      .dateOfInvoice
                      .replaceAll(":", ""),
                  model.dateInvoiceController),
              SaleTextField(
                  AppLocalizations.of(context)!
                      .duePaymentDate
                      .replaceAll(":", ""),
                  model.duePaymentDateController),
              SizedBox(
                width: device != ScreenSize.wide ? 90.0.wp : 29.0.wp,
                // height: 70,
                child: SelectedDropdown<String>(
                  hintStyle: AppTextStyles.formTitleTextStyle.copyWith(
                      color: AppColors.ashColor, fontWeight: FontWeight.normal),
                  isDisable: true,
                  fieldName:
                      AppLocalizations.of(context)!.currency.toUpperCamelCase(),
                  dropdownValue: model.currency,
                  items: model.saleCurrencies
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChange: (String v) {},
                ),
              ),
              if (!model.isEdit)
                SaleTextField(
                    AppLocalizations.of(context)!
                        .amount
                        .toUpperCamelCase()
                        .replaceAll(":", ""),
                    model.amountController),
              if (model.isEdit)
                SizedBox(
                  width: device != ScreenSize.wide ? 90.0.wp : 29.0.wp,
                  child: Flex(
                    direction: device == ScreenSize.small
                        ? Axis.vertical
                        : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: device == ScreenSize.wide
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      SaleTextField(
                          AppLocalizations.of(context)!
                              .amountReserved
                              .replaceAll(":", ""),
                          model.reservedAmountController,
                          width: (28.0.wp / 2) - 15),
                      SaleTextField(
                          AppLocalizations.of(context)!
                              .currentAmount
                              .replaceAll(":", ""),
                          model.currentAmountController,
                          width: (28.0.wp / 2) - 15),
                    ],
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SaleTextField(
                      AppLocalizations.of(context)!
                          .invoiceNumber
                          .replaceAll(":", "")
                          .isRequired,
                      model.invoiceNumberController,
                      enable: model.isEdit ? true : false),
                  if (model.invoiceValidation.isNotEmpty)
                    Text(
                      model.invoiceValidation,
                      style: AppTextStyles.errorTextStyle,
                    )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SaleTextField(
                      AppLocalizations.of(context)!
                          .orderNumber
                          .replaceAll(":", "")
                          .isRequired,
                      model.orderNumberController,
                      enable: model.isEdit ? true : false),
                  if (model.orderValidation.isNotEmpty)
                    Text(
                      model.orderValidation,
                      style: AppTextStyles.errorTextStyle,
                    )
                ],
              ),
              SaleTextField(
                  AppLocalizations.of(context)!
                      .bingoStoreID
                      .replaceAll(":", ""),
                  model.bingoStoreIdController),
              if (!model.isBusy)
                SizedBox(
                  width: device != ScreenSize.wide ? 90.0.wp : 29.0.wp,
                  // height: 70,
                  child: SelectedDropdown<String>(
                    hintStyle: AppTextStyles.formTitleTextStyle.copyWith(
                        color: AppColors.ashColor,
                        fontWeight: FontWeight.normal),
                    isDisable: true,
                    fieldName: AppLocalizations.of(context)!.salesStep,
                    dropdownValue: model.saleType,
                    items: model.saleSteps
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChange: (String v) {},
                  ),
                ),
            ],
          ),
        ),
        20.0.giveHeight,
        SizedBox(
          width: 90.0.wp,
          child: NameTextField(
            controller: model.descriptionController,
            maxLine: 5,
            enable: false,
            hintStyle: AppTextStyles.formTitleTextStyle.copyWith(
                color: AppColors.ashColor, fontWeight: FontWeight.normal),
            fieldName:
                AppLocalizations.of(context)!.description.toUpperCamelCase(),
          ),
        ),
        20.0.giveHeight,
        if (model.enrollment == UserTypeForWeb.wholesaler)
          if (model.isEdit)
            if (model.saleDetailsTransection.data![0].status != 1 ||
                model.saleDetailsTransection.data![0].status != 2 ||
                model.saleDetailsTransection.data![0].status != 8)
              model.buttonBusy
                  ? Utils.loaderBusy()
                  : SubmitButton(
                      color: AppColors.bingoGreen,
                      onPressed: () {
                        model.update(context);
                      },
                      isRadius: false,
                      height: 55,
                      width: 140,
                      text: AppLocalizations.of(context)!.update,
                    )
      ],
    );
  }

  Widget transactions(
      BuildContext context,
      List<SaleTranctionDetails> saleTranctionDetails,
      SaleDetailsViewModel model) {
    return SingleChildScrollView(
      scrollDirection:
          device == ScreenSize.wide ? Axis.vertical : Axis.horizontal,
      child: SizedBox(
        width: device == ScreenSize.wide ? 100.0.wp : 1200,
        child: Column(
          children: [
            if (saleTranctionDetails.isEmpty)
              model.isBusy
                  ? const SizedBox()
                  : SizedBox(
                      width: 100.0.wp,
                      height: 200,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.noData),
                      ),
                    ),
            if (saleTranctionDetails.isNotEmpty)
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Scrollbar(
                  controller: model.scrollController,
                  thickness: 10,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: model.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width:
                          device != ScreenSize.wide ? null : 100.0.wp - 64 - 64,
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border:
                            TableBorder.all(color: AppColors.tableHeaderBody),
                        columnWidths: {
                          0: const FixedColumnWidth(70.0),
                          1: const FixedColumnWidth(80.0),
                          2: const FixedColumnWidth(100.0),
                          // device != ScreenSize.wide
                          //     ? const FixedColumnWidth(100.0)
                          //     : const FlexColumnWidth(),
                          3: device != ScreenSize.wide
                              ? const FixedColumnWidth(100.0)
                              : const FlexColumnWidth(),
                          // 3: const FixedColumnWidth(100.0),
                          4: const FixedColumnWidth(100.0),
                          5: const FixedColumnWidth(100.0),
                          6: const FixedColumnWidth(100.0), //f
                          7: const FixedColumnWidth(100.0),
                          8: const FixedColumnWidth(100.0),
                          9: const FixedColumnWidth(100.0),
                          10: const FixedColumnWidth(100.0),
                          11: const FixedColumnWidth(100.0),
                          12: const FixedColumnWidth(70.0),
                          13: const FixedColumnWidth(100.0),
                        },
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color: AppColors.tableHeaderColor,
                              ),
                              children: [
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_no),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_saleId),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_docType),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_docId),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_collectionLotId),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_storeName),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_retailerName),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_invoice),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_currency),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_amount),
                                dataCellHd(
                                    AppLocalizations.of(context)!.openBalance),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_amountApplied),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_postingDate),
                                dataCellHd(
                                    AppLocalizations.of(context)!.status),
                              ]),
                          for (int i = 0; i < saleTranctionDetails.length; i++)
                            TableRow(
                              decoration: BoxDecoration(
                                border: Utils.tableBorder,
                                color: AppColors.whiteColor,
                              ),
                              children: [
                                dataCell("${i}"),
                                dataCell(saleTranctionDetails[i]
                                    .saleUniqueId!
                                    .lastChars(10)),
                                dataCell(saleTranctionDetails[i].documentType!),
                                dataCell(saleTranctionDetails[i]
                                    .documentId!
                                    .lastChars(10)),
                                dataCell(saleTranctionDetails[i]
                                        .collectionLotId!
                                        .isEmpty
                                    ? "-"
                                    : saleTranctionDetails[i]
                                        .collectionLotId!
                                        .lastChars(10)),
                                dataCell(saleTranctionDetails[i].storeName!),
                                dataCell(saleTranctionDetails[i].retailerName!),
                                dataCell(saleTranctionDetails[i].invoice!),
                                dataCell(saleTranctionDetails[i].currency!),
                                dataCell(
                                    saleTranctionDetails[i].amount!.toString()),
                                dataCell(saleTranctionDetails[i].openBalance!),
                                dataCell(
                                    saleTranctionDetails[i].appliedAmount!),
                                dataCell(saleTranctionDetails[i].postingDate!),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 4.0),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: model.statusColor(
                                              saleTranctionDetails[i].status!)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 4.0),
                                        child: Text(
                                          saleTranctionDetails[i]
                                              .statusDescription!
                                              .toString(),
                                          style: AppTextStyles.webBtnTxtStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
