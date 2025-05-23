import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/website_base_body.dart';
import 'order_list_view_model.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key, this.page});
  final String? page;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderListViewModel>.reactive(
        viewModelBuilder: () => OrderListViewModel(),
        onViewModelReady: (OrderListViewModel model) {
          model.getOrderList(page);
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
                            h1: 'View Orders',
                          ),
                        ),
                        if (model.enrollment == UserTypeForWeb.retailer)
                          Align(
                            alignment: Alignment.topRight,
                            child: SubmitButton(
                              color: AppColors.bingoGreen,
                              // active
                              isRadius: false,
                              height: 40,
                              width: 80,
                              onPressed: () {
                                // Navigator.pop(context);
                                model.addNew(context);
                              },
                              text: AppLocalizations.of(context)!.addNew,
                            ),
                          ),
                        if (model.enrollment != UserTypeForWeb.retailer)
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
                              children: [
                                SecondaryNameAppBar(
                                  h1: 'View Orders',
                                ),
                                if (model.enrollment == UserTypeForWeb.retailer)
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: SubmitButton(
                                      color: AppColors.bingoGreen,
                                      isRadius: false,
                                      height: 40,
                                      width: 80,
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        model.addNew(context);
                                      },
                                      text:
                                          AppLocalizations.of(context)!.addNew,
                                    ),
                                  ),
                              ],
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          const Text(
                                            'View Orders',
                                            style: AppTextStyles.headerText,
                                          ),
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
                                      if (model.enrollment ==
                                          UserTypeForWeb.retailer)
                                        Scrollbar(
                                          controller: model.scrollController,
                                          thickness: 10,
                                          child: SingleChildScrollView(
                                            controller: model.scrollController,
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
                                                          150.0)
                                                      : const FlexColumnWidth(),
                                                  2: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          150.0)
                                                      : const FlexColumnWidth(),
                                                  3: const FixedColumnWidth(
                                                      100.0),
                                                  4: const FixedColumnWidth(
                                                      100.0),
                                                  5: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          110.0)
                                                      : const FlexColumnWidth(),
                                                  6: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          110.0)
                                                      : const FlexColumnWidth(),
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
                                                                .sNo),
                                                        dataCellHd(
                                                            "Store Name"),
                                                        dataCellHd(
                                                            "Wholesaler"),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_currency),
                                                        dataCellHd(
                                                            "Total Amount"),
                                                        dataCellHd(
                                                            "Delivery Date"),
                                                        dataCellHd(
                                                            "Order Date"),
                                                        dataCellHd("Sales ID"),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_status),
                                                        dataCellHd(
                                                            "Order Type"),
                                                        dataCellHd("Action"),
                                                      ]),
                                                  for (int i = 0;
                                                      i < model.orders.length;
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
                                                          "${model.pageFrom + i}",
                                                          isCenter: true,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .storeName!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .wholesalerName!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .currency!,
                                                          isCenter: true,
                                                        ),
                                                        dataCellAmount(
                                                          model.orders[i]
                                                              .grandTotal!,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .deliveryDate!,
                                                          isCenter: true,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .dateOfTransaction!,
                                                          isCenter: true,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                                      .salesId! ==
                                                                  "-"
                                                              ? "-"
                                                              : model.orders[i]
                                                                  .salesId!
                                                                  .lastChars(
                                                                      10),
                                                          isCenter: false,
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .orderStatusColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0,
                                                                      vertical:
                                                                          4.0),
                                                              child: Text(
                                                                model.orders[i]
                                                                    .statusDescription!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppColors
                                                                        .whiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: FittedBox(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .orderTypeColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        4.0),
                                                                child: Text(
                                                                  model
                                                                      .orders[i]
                                                                      .orderTypeDescription!
                                                                      .replaceAll(
                                                                          ",",
                                                                          ""),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:
                                                              PopupMenuWithValue(
                                                                  onTap:
                                                                      (int v) {
                                                                    model.action(
                                                                        context,
                                                                        v,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .wholesalerUniqueId!,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .storeUniqueId!,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .orderType!,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .uniqueId!,
                                                                        model
                                                                            .orders[i]
                                                                            .orderId!);
                                                                  },
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .table_action,
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  items: [
                                                                if (model
                                                                        .orders[
                                                                            i]
                                                                        .orderType !=
                                                                    2)
                                                                  {
                                                                    "t": "Edit",
                                                                    "v": 0
                                                                  },
                                                                const {
                                                                  "t": "View",
                                                                  "v": 1
                                                                }
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (model.enrollment ==
                                          UserTypeForWeb.wholesaler)
                                        Scrollbar(
                                          controller: model.scrollController,
                                          thickness: 10,
                                          child: SingleChildScrollView(
                                            controller: model.scrollController,
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
                                                      40.0),
                                                  1: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          150.0)
                                                      : const FlexColumnWidth(),
                                                  2: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          150.0)
                                                      : const FlexColumnWidth(),
                                                  3: const FixedColumnWidth(
                                                      100.0),
                                                  4: const FixedColumnWidth(
                                                      100.0),
                                                  5: const FixedColumnWidth(
                                                      55.0),
                                                  6: const FixedColumnWidth(
                                                      110.0),
                                                  7: const FixedColumnWidth(
                                                      80.0),
                                                  8: const FixedColumnWidth(
                                                      100.0),
                                                  9: const FixedColumnWidth(
                                                      100.0),
                                                  10: const FixedColumnWidth(
                                                      90.0),
                                                  11: const FixedColumnWidth(
                                                      100.0),
                                                  12: const FixedColumnWidth(
                                                      100.0),
                                                  13: const FixedColumnWidth(
                                                      100.0),
                                                  14: const FixedColumnWidth(
                                                      100.0)
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
                                                                .sNo),
                                                        dataCellHd("Order Id"),
                                                        dataCellHd(
                                                            "Order Date"),
                                                        dataCellHd(
                                                            "Order From"),
                                                        dataCellHd("Order To"),
                                                        dataCellHd("Order Qty"),
                                                        dataCellHd(
                                                            "Order Delivery Date"),
                                                        dataCellHd("Currency"),
                                                        dataCellHd(
                                                            "Order Amount"),
                                                        dataCellHd("Status"),
                                                        dataCellHd(
                                                            "Order Type"),
                                                        dataCellHd("Sales Id"),
                                                        dataCellHd(
                                                            "Payment Method"),
                                                        dataCellHd(
                                                            "Invoice No"),
                                                        dataCellHd("Action"),
                                                      ]),
                                                  for (int i = 0;
                                                      i < model.orders.length;
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
                                                          "${model.pageFrom + i}",
                                                          isCenter: true,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .orderId!
                                                              .lastChars(10),
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .orderDate!,
                                                          isCenter: true,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .orderFrom!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .orderTo!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .orderQty!
                                                              .toString(),
                                                          isCenter: true,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: dataCell(
                                                            model.orders[i]
                                                                .deliveryDate!,
                                                          ),
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .currency!,
                                                          isCenter: true,
                                                        ),
                                                        dataCellAmount(
                                                          model.orders[i]
                                                              .orderAmount!
                                                              .toString(),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .orderStatusColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0,
                                                                      vertical:
                                                                          4.0),
                                                              child: Text(
                                                                model.orders[i]
                                                                    .statusDescription!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppColors
                                                                        .whiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: FittedBox(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .orderTypeColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        4.0),
                                                                child: Text(
                                                                  model
                                                                      .orders[i]
                                                                      .orderTypeDescription!
                                                                      .replaceAll(
                                                                          ",",
                                                                          ""),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .salesId!
                                                              .lastChars(10),
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .paymentMethodName!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model.orders[i]
                                                              .invoiceNumber!,
                                                          isCenter: false,
                                                        ),
                                                        Center(
                                                          // width: 80,
                                                          child:
                                                              PopupMenuWithValue(
                                                                  onTap:
                                                                      (int v) {
                                                                    model.action(
                                                                        context,
                                                                        v,
                                                                        model
                                                                            .userId,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .storeUniqueId!,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .orderType!,
                                                                        model
                                                                            .orders[
                                                                                i]
                                                                            .orderId!,
                                                                        model
                                                                            .orders[i]
                                                                            .orderId!);
                                                                  },
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .table_action,
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  items: [
                                                                {
                                                                  "t": "Edit",
                                                                  "v": 0
                                                                },
                                                                {
                                                                  "t": "View",
                                                                  "v": 1
                                                                }
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (model.orders.isEmpty)
                                        Utils.noDataWidget(context,
                                            height: 60.0),
                                      20.0.giveHeight,
                                      if (model.totalPage > 0)
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
