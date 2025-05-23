import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';
import 'delivery_method_list_view_model.dart';

class DeliveryMethodListView extends StatelessWidget {
  const DeliveryMethodListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryMethodListViewModel>.reactive(
        viewModelBuilder: () => DeliveryMethodListViewModel(),
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
                    title: Row(
                      children: [
                        SecondaryNameAppBar(
                          h1: 'Order Delivery Method',
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: SubmitButton(
                            color: AppColors.bingoGreen,
                            isRadius: false,
                            height: 40,
                            width: 80,
                            onPressed: () {
                              model.gotoDetails(
                                3,
                                context,
                              );
                            },
                            text: AppLocalizations.of(context)!.addNew,
                          ),
                        ),
                      ],
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
                            Row(
                              children: [
                                SecondaryNameAppBar(
                                  h1: 'Order Delivery Method',
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SubmitButton(
                                    color: AppColors.bingoGreen,
                                    isRadius: false,
                                    height: 40,
                                    width: 80,
                                    onPressed: () {
                                      model.gotoDetails(
                                        3,
                                        context,
                                      );
                                    },
                                    text: AppLocalizations.of(context)!.addNew,
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
                                            'Order Delivery Method',
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
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
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
                                                0: const FixedColumnWidth(70.0),
                                                1: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                3: const FixedColumnWidth(
                                                    150.0),
                                                4: const FixedColumnWidth(
                                                    150.0),
                                                5: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                6: const FixedColumnWidth(
                                                    150.0),
                                                7: const FixedColumnWidth(
                                                    150.0),
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
                                                        "Delivery Method ID",
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_description,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_salesZone,
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_currency),
                                                      dataCellHd(
                                                        "Shipping & Handling Cost",
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_status,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model.deliveryMethods
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        "${1 + i}",
                                                      ),
                                                      dataCell(
                                                        model.deliveryMethods[i]
                                                            .deliveryMethodId!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model.deliveryMethods[i]
                                                            .description!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model.getSaleZones(model
                                                                .deliveryMethods[
                                                                    i]
                                                                .saleZone ??
                                                            []),
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model.deliveryMethods[i]
                                                            .currency!,
                                                      ),
                                                      dataCellAmount(
                                                        model.deliveryMethods[i]
                                                            .shippingAndHandlingCost!
                                                            .toStringAsFixed(2),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: model
                                                                        .deliveryMethods[
                                                                            i]
                                                                        .status ==
                                                                    1
                                                                ? AppColors
                                                                    .statusVerified
                                                                : AppColors
                                                                    .statusReject),
                                                        child: Center(
                                                          child: Text(
                                                            model.deliveryMethods[i]
                                                                        .status ==
                                                                    1
                                                                ? "Active"
                                                                : "Inactive",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        // width: 80,
                                                        child:
                                                            PopupMenuWithValue(
                                                                onTap: (int v) {
                                                                  model.gotoDetails(
                                                                      v,
                                                                      context,
                                                                      id: model
                                                                          .deliveryMethods[
                                                                              i]
                                                                          .uniqueId!
                                                                          .toString(),
                                                                      status: model
                                                                          .deliveryMethods[
                                                                              i]
                                                                          .status!);
                                                                },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .table_action,
                                                                color: AppColors
                                                                    .contextMenuTwo,
                                                                items: [
                                                              {
                                                                "t": AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_edit,
                                                                "v": 0
                                                              },
                                                              {
                                                                "t": AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_delete,
                                                                "v": 1
                                                              },
                                                              model
                                                                          .deliveryMethods[
                                                                              i]
                                                                          .status ==
                                                                      0
                                                                  ? {
                                                                      "t": AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_active,
                                                                      "v": 2
                                                                    }
                                                                  : {
                                                                      "t": AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_inactive,
                                                                      "v": 2
                                                                    },
                                                            ]),
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
