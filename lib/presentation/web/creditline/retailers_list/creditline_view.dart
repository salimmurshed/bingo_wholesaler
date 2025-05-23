import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/website_base_body.dart';
import 'creditline_view_model.dart';

class CreditlineView extends StatelessWidget {
  const CreditlineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditlineViewModel>.reactive(
        viewModelBuilder: () => CreditlineViewModel(),
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
                            h1: AppLocalizations.of(context)!
                                .creditlineScreen_header,
                          ),
                        ),
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
              controller: model.scrollController,
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
                                  .creditlineScreen_header,
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .creditlineScreen_body,
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
                                                1: const FixedColumnWidth(
                                                    120.0),
                                                2: const FixedColumnWidth(
                                                    120.0),

                                                3: const FixedColumnWidth(
                                                    100.0),
                                                4: const FixedColumnWidth(
                                                    110.0),
                                                5: const FixedColumnWidth(
                                                    110.0),
                                                6: const FixedColumnWidth(80.0),
                                                7: const FixedColumnWidth(
                                                    100.0),
                                                8: const FixedColumnWidth(
                                                    120.0),
                                                9: const FixedColumnWidth(
                                                    120.0),
                                                10: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        140.0)
                                                    : const FlexColumnWidth(),
                                                11: const FixedColumnWidth(
                                                    110.0),
                                                12: const FixedColumnWidth(
                                                    120.0), //f
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
                                                            .sr,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .creditLineID,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .wholesaler
                                                            .toUpperCamelCase(),
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .financialIns),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .activationDate,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .expirationDate,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .currency,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .approvedAmount,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .currentBalance,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .amountAvailable,
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .utilization),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .status),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .action),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model.creditlineRequest
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
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .internalId!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .wholesalerName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .fieName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .approvedDate!,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .expirationDate!,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .currency!,
                                                      ),
                                                      dataCellAmount(
                                                        model
                                                            .creditlineRequest[
                                                                i]
                                                            .approvedAmount!,
                                                      ),
                                                      dataCellAmount(
                                                        '${model.creditlineRequest[i].currentBalance}',
                                                      ),
                                                      dataCellAmount(
                                                        '${model.creditlineRequest[i].amountAvailable} ',
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Card(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            child:
                                                                LinearProgressIndicator(
                                                              color: AppColors
                                                                  .bingoGreen,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .creditlineUtilizationBackGround,
                                                              minHeight: 20,
                                                              value: model
                                                                  .getPercentage(
                                                                      i),
                                                            ),
                                                          ),
                                                        ),
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
                                                                        .creditlineRequest[
                                                                            i]
                                                                        .statusDescription!
                                                                        .toLowerCase() ==
                                                                    "active"
                                                                ? AppColors
                                                                    .statusVerified
                                                                : AppColors
                                                                    .statusReject),
                                                        child: Center(
                                                          child: Text(
                                                            model
                                                                .creditlineRequest[
                                                                    i]
                                                                .statusDescription!,
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
                                                                  model.action(
                                                                      v,
                                                                      context,
                                                                      model
                                                                          .creditlineRequest[
                                                                              i]
                                                                          .uniqueId!);
                                                                },
                                                                text: AppLocalizations
                                                                        .of(
                                                                            context)!
                                                                    .table_action,
                                                                color: AppColors
                                                                    .contextMenuTwo,
                                                                items: model.creditlineRequest[i]
                                                                            .statusDescription!
                                                                            .toLowerCase() ==
                                                                        "active"
                                                                    ? [
                                                                        {
                                                                          't': AppLocalizations.of(context)!
                                                                              .webActionButtons_view,
                                                                          'v': 0
                                                                        },
                                                                        {
                                                                          't': AppLocalizations.of(context)!
                                                                              .webActionButtons_edit,
                                                                          'v': 1
                                                                        },
                                                                        {
                                                                          't': model.creditlineRequest[i].statusDescription!.toLowerCase() == "active"
                                                                              ? AppLocalizations.of(context)!.webActionButtons_inactive
                                                                              : AppLocalizations.of(context)!.webActionButtons_active,
                                                                          'v': 2
                                                                        },
                                                                        {
                                                                          't': AppLocalizations.of(context)!
                                                                              .webActionButtons_crReview,
                                                                          'v': 3
                                                                        }
                                                                      ]
                                                                    : [
                                                                        {
                                                                          't': AppLocalizations.of(context)!
                                                                              .webActionButtons_view,
                                                                          'v': 0
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
                                      if (model.creditlineRequest.isEmpty)
                                        Utils.noDataWidget(context)
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
