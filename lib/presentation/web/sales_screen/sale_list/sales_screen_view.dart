import 'package:bingo/app/app_secrets.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/web/sales_screen/sale_list/sales_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/server_status_file/server_status_file.dart';
import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../main.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/website_base_body.dart';

class SalesScreenView extends StatelessWidget {
  const SalesScreenView({
    this.page,
    this.query,
    super.key,
  });

  final String? page;
  final String? query;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesScreenViewModel>.reactive(
        viewModelBuilder: () => SalesScreenViewModel(),
        onViewModelReady: (SalesScreenViewModel model) {
          model.getAllSale(int.parse(page!), query);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: model.enrollment == UserTypeForWeb.retailer
                                ? AppLocalizations.of(context)!
                                    .saleList_retailer_header
                                : AppLocalizations.of(context)!
                                    .saleList_wholesaler_header,
                          ),
                        ),
                        if (model.enrollment == UserTypeForWeb.wholesaler)
                          Align(
                            alignment: Alignment.topRight,
                            child: SubmitButton(
                              color: AppColors.bingoGreen,
                              isRadius: false,
                              height: 40,
                              width: 80,
                              onPressed: () {
                                // Navigator.pop(context);
                                model.gotoAddSale(context);
                              },
                              text: AppLocalizations.of(context)!.addNew,
                            ),
                          ),
                        if (model.enrollment != UserTypeForWeb.wholesaler)
                          SizedBox()
                      ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SecondaryNameAppBar(
                                  h1: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? AppLocalizations.of(context)!
                                          .saleList_retailer_header
                                      : AppLocalizations.of(context)!
                                          .saleList_wholesaler_header,
                                ),
                                if (model.enrollment ==
                                    UserTypeForWeb.wholesaler)
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: SubmitButton(
                                      color: AppColors.bingoGreen,
                                      isRadius: false,
                                      height: 40,
                                      width: 80,
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        model.gotoAddSale(context);
                                      },
                                      text:
                                          AppLocalizations.of(context)!.addNew,
                                    ),
                                  ),
                              ],
                            ),
                          // WebsiteBaseBody(child: ,body: Flex(
                          //   direction: device == ScreenSize.wide
                          //       ? Axis.horizontal
                          //       : Axis.vertical,
                          //   crossAxisAlignment:
                          //   CrossAxisAlignment.start,
                          //   mainAxisAlignment:
                          //   MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       model.enrollment ==
                          //           UserTypeForWeb.retailer
                          //           ? AppLocalizations.of(
                          //           context)!
                          //           .saleList_retailer_body
                          //           : AppLocalizations.of(
                          //           context)!
                          //           .saleList_wholesaler_body,
                          //       style: AppTextStyles.headerText,
                          //     ),
                          //     Row(
                          //       crossAxisAlignment:
                          //       CrossAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding:
                          //           const EdgeInsets.only(
                          //               top: 8.0),
                          //           child: Text(
                          //               AppLocalizations.of(
                          //                   context)!
                          //                   .search),
                          //         ),
                          //         10.0.giveWidth,
                          //         SizedBox(
                          //             width: 100,
                          //             height: 50,
                          //             child: NameTextField(
                          //               controller: model
                          //                   .searchController,
                          //               onChanged:
                          //                   (String value) {
                          //                 if (value.length >
                          //                     AppSecrets
                          //                         .charsLengthSaleSearch) {
                          //                   model.changePage(
                          //                       context,
                          //                       1,
                          //                       value);
                          //                 }
                          //               },
                          //               hintStyle: AppTextStyles
                          //                   .formTitleTextStyleNormal,
                          //             ))
                          //       ],
                          //     ),
                          //   ],
                          // ),),
                          WebsiteBaseBody(
                            body: Container(
                              color: Colors.white,
                              width: 100.0.wp,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flex(
                                    direction: device == ScreenSize.wide
                                        ? Axis.horizontal
                                        : Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        model.enrollment ==
                                                UserTypeForWeb.retailer
                                            ? AppLocalizations.of(context)!
                                                .saleList_retailer_body
                                            : AppLocalizations.of(context)!
                                                .saleList_wholesaler_body,
                                        style: AppTextStyles.headerText,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .search),
                                          ),
                                          10.0.giveWidth,
                                          SizedBox(
                                              width: 100,
                                              height: 50,
                                              child: NameTextField(
                                                controller:
                                                    model.searchController,
                                                onChanged: (String value) {
                                                  if (value.length >
                                                      AppSecrets
                                                          .charsLengthSaleSearch) {
                                                    model.changePage(
                                                        context, 1, value);
                                                  }
                                                },
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  model.isBusy
                                      ? Utils.bigLoader()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (model.allSalesData.isEmpty)
                                              if (model
                                                  .busy(model.allSalesData))
                                                Utils.bigLoader(),
                                            // if (model.allSalesData.isNotEmpty)
                                            SingleChildScrollView(
                                              scrollDirection:
                                                  device == ScreenSize.wide
                                                      ? Axis.vertical
                                                      : Axis.horizontal,
                                              child: SizedBox(
                                                width: 100.0.wp - 64,
                                                child:
                                                    model.enrollment ==
                                                            UserTypeForWeb
                                                                .retailer
                                                        ? Scrollbar(
                                                            controller: model
                                                                .scrollController,
                                                            thickness: 10,
                                                            child:
                                                                SingleChildScrollView(
                                                              controller: model
                                                                  .scrollController,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: SizedBox(
                                                                width: device ==
                                                                        ScreenSize
                                                                            .wide
                                                                    ? 100.0.wp -
                                                                        (32 * 4)
                                                                    : 1200,
                                                                child: Table(
                                                                  defaultVerticalAlignment:
                                                                      TableCellVerticalAlignment
                                                                          .middle,
                                                                  border: TableBorder.all(
                                                                      color: AppColors
                                                                          .tableHeaderBody),
                                                                  columnWidths: {
                                                                    0: const FixedColumnWidth(
                                                                        50.0),
                                                                    1: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    2: const FixedColumnWidth(
                                                                        100.0),
                                                                    3: const FixedColumnWidth(
                                                                        60.0),
                                                                    4: const FixedColumnWidth(
                                                                        100.0),
                                                                    5: const FixedColumnWidth(
                                                                        100.0),
                                                                    6: const FixedColumnWidth(
                                                                        100.0), //f
                                                                    7: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    8: const FixedColumnWidth(
                                                                        85.0),
                                                                    9: const FixedColumnWidth(
                                                                        80.0),
                                                                    10: const FixedColumnWidth(
                                                                        100.0),
                                                                    11: const FixedColumnWidth(
                                                                        100.0),
                                                                    12: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    13: const FixedColumnWidth(
                                                                        100.0),
                                                                  },
                                                                  children: [
                                                                    TableRow(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              AppColors.tableHeaderColor,
                                                                        ),
                                                                        children: [
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_srNO),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_dOI),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_invoiceTo),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_fIE),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_bingoOrderId),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_orderID),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_invoiceNumber),
                                                                          dataCellHd(
                                                                              "${AppLocalizations.of(context)!.table_dueDate}\n[(GMT- 04:00) La Paz]"),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_currency),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_amount),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_balance),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_totalOwe),
                                                                          dataCellHd(AppLocalizations.of(context)!
                                                                              .status
                                                                              .toUpperCamelCase()),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.action),
                                                                        ]),
                                                                    for (int i =
                                                                            0;
                                                                        i < model.allSalesData.length;
                                                                        i++)
                                                                      TableRow(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Utils.tableBorder,
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                        ),
                                                                        children: [
                                                                          dataCell(
                                                                            "${model.saleFrom + i}",
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            Utils.contractAccount(model.allSalesData[i].saleDate!),
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].wholesalerName!,
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].fieName!.toString(),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].bingoOrderId!.isEmpty
                                                                                ? "-"
                                                                                : model.allSalesData[i].bingoOrderId!.lastChars(10).toString(),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].orderNumber!.toString(),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].invoiceNumber!.toString(),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].dueDate!.toString(),
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].currency!.toString(),
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCellAmount(model
                                                                              .allSalesData[i]
                                                                              .amount!),
                                                                          dataCellAmount(model
                                                                              .allSalesData[i]
                                                                              .totalOwed!),
                                                                          dataCellAmount(model
                                                                              .allSalesData[i]
                                                                              .totalOwed!),
                                                                          Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                              child: model.allSalesData[i].status!.toSaleStatus(textAlign: TextAlign.center, isIconAvailable: false, textStyle: AppTextStyles.statusCardStatus.copyWith(fontSize: 14), text: StatusFile.statusForSale('en', model.allSalesData[i].status!, model.allSalesData[i].statusDescription!)),
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                            child:
                                                                                PopupMenuWithValue(
                                                                              onTap: (int v) {
                                                                                Utils.fPrint(v.toString());
                                                                                model.gotoDetails(v, context, model.allSalesData[i].uniqueId!);
                                                                              },
                                                                              text: AppLocalizations.of(context)!.table_action,
                                                                              color: AppColors.contextMenuTwo,
                                                                              items: [
                                                                                {
                                                                                  "t": AppLocalizations.of(context)!.webActionButtons_view,
                                                                                  "v": 0
                                                                                },
                                                                                if (model.allSalesData[i].status == 0 || model.allSalesData[i].status == 3)
                                                                                  {
                                                                                    "t": AppLocalizations.of(context)!.webActionButtons_approve,
                                                                                    "v": 1
                                                                                  },
                                                                                if (model.allSalesData[i].status == 0 || model.allSalesData[i].status == 3)
                                                                                  {
                                                                                    "t": AppLocalizations.of(context)!.webActionButtons_reject,
                                                                                    "v": 2
                                                                                  },
                                                                                if (model.allSalesData[i].status == 1)
                                                                                  {
                                                                                    "t": AppLocalizations.of(context)!.webActionButtons_startPayment,
                                                                                    "v": 3
                                                                                  },
                                                                                if (model.allSalesData[i].status == 7)
                                                                                  {
                                                                                    "t": AppLocalizations.of(context)!.confirmDelivery,
                                                                                  },

                                                                                // AppLocalizations.of(context)!.webActionButtons_edit
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Scrollbar(
                                                            controller: model
                                                                .scrollController,
                                                            thickness: 10,
                                                            child:
                                                                SingleChildScrollView(
                                                              controller: model
                                                                  .scrollController,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: SizedBox(
                                                                width: device ==
                                                                        ScreenSize
                                                                            .wide
                                                                    ? 100.0.wp -
                                                                        (32 * 4)
                                                                    : 1400,
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
                                                                        130.0),
                                                                    2: const FixedColumnWidth(
                                                                        100.0),
                                                                    3: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            60.0),
                                                                    4: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    5: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    6: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    7: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    8: device ==
                                                                            ScreenSize
                                                                                .wide
                                                                        ? const FlexColumnWidth()
                                                                        : const FixedColumnWidth(
                                                                            100.0),
                                                                    9: const FixedColumnWidth(
                                                                        100.0),
                                                                    10: const FixedColumnWidth(
                                                                        100.0),
                                                                    11: const FixedColumnWidth(
                                                                        100.0),
                                                                    12: const FixedColumnWidth(
                                                                        120.0),
                                                                    13: const FixedColumnWidth(
                                                                        100.0),
                                                                  },
                                                                  children: [
                                                                    TableRow(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              AppColors.tableHeaderColor,
                                                                        ),
                                                                        children: [
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_srNO),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_saleId),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_WholeSalerInvoiceNo),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_bingoOrderId),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_orderID),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_from),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_fIE),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_saleDate),
                                                                          dataCellHd(
                                                                              "${AppLocalizations.of(context)!.table_dueDate}\n[(GMT- 04:00) La Paz]"),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_currency),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_amount),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.table_balance),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.status),
                                                                          dataCellHd(
                                                                              AppLocalizations.of(context)!.action),
                                                                        ]),
                                                                    for (int i =
                                                                            0;
                                                                        i < model.allSalesData.length;
                                                                        i++)
                                                                      TableRow(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Utils.tableBorder,
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                        ),
                                                                        children: [
                                                                          dataCell(
                                                                            "${model.saleFrom + i}",
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            Utils.contractAccount(model.allSalesData[i].uniqueId!.lastChars(10)),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].invoiceNumber!,
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].bingoOrderId!.isEmpty
                                                                                ? "-"
                                                                                : model.allSalesData[i].bingoOrderId!.lastChars(10),
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].orderNumber!,
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].retailerName!,
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].fieName!,
                                                                            isCenter:
                                                                                false,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].saleDate!,
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].dueDate!,
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCell(
                                                                            model.allSalesData[i].currency!,
                                                                            isCenter:
                                                                                true,
                                                                          ),
                                                                          dataCellAmount(model
                                                                              .allSalesData[i]
                                                                              .amount!),
                                                                          dataCellAmount(model
                                                                              .allSalesData[i]
                                                                              .balance!),
                                                                          model.allSalesData[i].status!.toSaleStatus(
                                                                              textAlign: TextAlign.center,
                                                                              isIconAvailable: false,
                                                                              textStyle: AppTextStyles.statusCardStatus.copyWith(fontSize: 14),
                                                                              text: StatusFile.statusForSale('en', model.allSalesData[i].status!, model.allSalesData[i].statusDescription!)),
                                                                          Center(
                                                                            child:
                                                                                PopupMenuWithValue(
                                                                              onTap: (int v) {
                                                                                Utils.fPrint(v.toString());
                                                                                model.gotoDetails(v, context, model.allSalesData[i].uniqueId!);
                                                                              },
                                                                              text: AppLocalizations.of(context)!.table_action,
                                                                              color: AppColors.contextMenuTwo,
                                                                              items: [
                                                                                {
                                                                                  "t": AppLocalizations.of(context)!.webActionButtons_view,
                                                                                  "v": 0
                                                                                },
                                                                                {
                                                                                  "t": AppLocalizations.of(context)!.webActionButtons_edit,
                                                                                  "v": 1
                                                                                },
                                                                                if (model.allSalesData[i].status != 1 || model.allSalesData[i].status != 2 || model.allSalesData[i].status != 8)
                                                                                  {
                                                                                    "t": AppLocalizations.of(context)!.cancelButton.toUpperCamelCase(),
                                                                                    "v": 2
                                                                                  },
                                                                              ],
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
                                            ),

                                            if (model.allSalesData.isEmpty)
                                              Utils.noDataWidget(context,
                                                  height: 60.0),
                                            20.0.giveHeight,

                                            model.busy(model.allSalesData)
                                                ? const SizedBox()
                                                : PaginationWidget(
                                                    totalPage:
                                                        model.salePage < 1
                                                            ? 0
                                                            : model.totalPage,
                                                    perPage: model.salePage < 1
                                                        ? model
                                                            .allSalesData.length
                                                        : model.salePage,
                                                    startTo: model.saleTo,
                                                    startFrom: model.saleFrom,
                                                    pageNumber:
                                                        model.saleNumber,
                                                    total: model.saleTotal,
                                                    onPageChange: (int v) {
                                                      model.changePage(
                                                          context, v, query);
                                                    })
                                          ],
                                        ),
                                ],
                              ),
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
