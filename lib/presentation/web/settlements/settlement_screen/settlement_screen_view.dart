import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/website_base_body.dart';
import 'settlement_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettlementScreenView extends StatelessWidget {
  const SettlementScreenView({super.key, this.page, this.p});

  final String? page;
  final String? p;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettlementScreenViewModel>.reactive(
        viewModelBuilder: () => SettlementScreenViewModel(),
        onViewModelReady: (SettlementScreenViewModel model) {
          model.setPage(page!, p);
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
                      h1: 'View all Settlement',
                    ),
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: model.isBusy
                    ? Utils.bigLoader()
                    : Column(
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
                                    h1: 'View all Settlement',
                                  ),
                                WebsiteBaseBody(
                                  body: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (model.enrollment ==
                                              UserTypeForWeb.fie)
                                            Row(
                                              children: [
                                                NavButton(
                                                  isBottom:
                                                      page!.toLowerCase() ==
                                                          "settlements",
                                                  text: "Settlements",
                                                  onTap: () {
                                                    model.changeSettlementTab(
                                                        context, "settlements");
                                                  },
                                                ),
                                                NavButton(
                                                  isBottom:
                                                      page!.toLowerCase() ==
                                                          "accounting",
                                                  text: "Accounting",
                                                  onTap: () {
                                                    model.changeSettlementTab(
                                                        context, "accounting");
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (model.enrollment !=
                                              UserTypeForWeb.fie)
                                            const Text(
                                              'View all Settlement',
                                              style: AppTextStyles.headerText,
                                            ),
                                          if (model.enrollment ==
                                              UserTypeForWeb.fie)
                                            Flex(
                                              mainAxisAlignment: page!
                                                          .toLowerCase() ==
                                                      'settlements'
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.start,
                                              direction:
                                                  device != ScreenSize.wide
                                                      ? Axis.vertical
                                                      : Axis.horizontal,
                                              children: [
                                                Text(
                                                  page!.toUpperCamelCase(),
                                                  style:
                                                      AppTextStyles.headerText,
                                                ),
                                                if (page!.toLowerCase() ==
                                                    'settlements')
                                                  model.isAddButtonBusy
                                                      ? Utils.webLoader()
                                                      : Row(
                                                          children: [
                                                            SubmitButton(
                                                              color: AppColors
                                                                  .bingoGreen,
                                                              text:
                                                                  "Add Payment Lot",
                                                              isRadius: false,
                                                              width: 150,
                                                              onPressed: () {
                                                                model.addPaymentCollectionLot(
                                                                    isPayment:
                                                                        true);
                                                              },
                                                            ),
                                                            SubmitButton(
                                                              color: AppColors
                                                                  .bingoGreen,
                                                              text:
                                                                  "Add Collection Lot",
                                                              isRadius: false,
                                                              width: 150,
                                                              onPressed: () {
                                                                model.addPaymentCollectionLot(
                                                                    isPayment:
                                                                        false);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                if (page!.toLowerCase() ==
                                                    'accounting')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: device !=
                                                                ScreenSize.wide
                                                            ? 12.0
                                                            : 0.0),
                                                    child: SizedBox(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 16.0,
                                                        ),
                                                        child: Flex(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment: device !=
                                                                  ScreenSize
                                                                      .small
                                                              ? MainAxisAlignment
                                                                  .center
                                                              : MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          direction: device !=
                                                                  ScreenSize
                                                                      .wide
                                                              ? Axis.vertical
                                                              : Axis.horizontal,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      model.openDateTime(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        SizedBox(
                                                                      width: device ==
                                                                              ScreenSize.small
                                                                          ? 165.0
                                                                          : 400.0,
                                                                      child:
                                                                          AbsorbPointer(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              model.dateController,
                                                                          enabled:
                                                                              false,
                                                                          textCapitalization:
                                                                              TextCapitalization.sentences,
                                                                          scrollPadding:
                                                                              EdgeInsets.zero,
                                                                          style: AppTextStyles
                                                                              .formFieldTextStyle
                                                                              .copyWith(color: AppColors.blackColor),
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              AppInputStyles.ashOutlineBorderDisable,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  30.0.giveWidth,
                                                                  SubmitButton(
                                                                    onPressed:
                                                                        () {
                                                                      model
                                                                          .searchBasedOnDate();
                                                                    },
                                                                    color: AppColors
                                                                        .bingoGreen,
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .submitButton,
                                                                    isRadius:
                                                                        false,
                                                                    height:
                                                                        50.0,
                                                                    width: 50.0,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: device !=
                                                                            ScreenSize.wide
                                                                        ? 12.0
                                                                        : 0.0),
                                                                child: SizedBox(
                                                                  width: 700,
                                                                  child: model
                                                                          .isButtonBusy
                                                                      ? Center(
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                Image.asset(AppAsset.webLoad),
                                                                          ),
                                                                        )
                                                                      : Flex(
                                                                          mainAxisAlignment: device == ScreenSize.small
                                                                              ? MainAxisAlignment.spaceBetween
                                                                              : MainAxisAlignment.center,
                                                                          direction: device == ScreenSize.small
                                                                              ? Axis.vertical
                                                                              : Axis.horizontal,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: device != ScreenSize.wide ? 0 : 10.0),
                                                                              child: SubmitButton(
                                                                                onPressed: () {
                                                                                  model.downloadAccount(false);
                                                                                },
                                                                                color: AppColors.bingoGreen,
                                                                                text: "Download Accounting Information (XML File)",
                                                                                isRadius: false,
                                                                                height: 50.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: device != ScreenSize.wide ? 0 : 10.0),
                                                                              child: SubmitButton(
                                                                                onPressed: () {
                                                                                  model.downloadAccount(true);
                                                                                },
                                                                                color: AppColors.bingoGreen,
                                                                                text: "Download Accounting Information (CSV File)",
                                                                                isRadius: false,
                                                                                height: 50.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                                      SingleChildScrollView(
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
                                                if (model.screen
                                                        .toLowerCase() ==
                                                    'settlements')
                                                  Stack(
                                                    children: [
                                                      settlementCardRetailerWholesaler(
                                                          model,
                                                          context,
                                                          model.enrollment ==
                                                              UserTypeForWeb
                                                                  .fie),
                                                    ],
                                                  )
                                                else
                                                  Stack(
                                                    children: [
                                                      accountingCardFie(page!,
                                                          context, model),
                                                    ],
                                                  ),
                                              ],
                                            )),
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

  Widget settlementCardRetailerWholesaler(
      SettlementScreenViewModel model, BuildContext context, bool isFie) {
    return isFie
        ? Center(
            child: model.busy(model.settlementListFie)
                ? SizedBox(
                    child: Center(
                      child: Utils.bigLoader(),
                    ),
                  )
                : Column(
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border:
                            TableBorder.all(color: AppColors.tableHeaderBody),
                        columnWidths: const {
                          0: FixedColumnWidth(100.0), // fixed to 100 width
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          3: FlexColumnWidth(),
                          4: FixedColumnWidth(120.0), //
                          5: FixedColumnWidth(130.0), //f
                          6: FixedColumnWidth(200.0), //f
                          7: FixedColumnWidth(200.0), //f
                          8: FixedColumnWidth(200.0), //f
                          //fixed to 100 width
                        },
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color: AppColors.tableHeaderColor,
                              ),
                              children: [
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_settNo),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_lotType),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_genDate),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_postingDate),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_LotId),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_currency),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_amount),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_status),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_action),
                              ]),
                          for (int i = 0;
                              i < model.settlementListFie.length;
                              i++)
                            TableRow(
                              decoration: BoxDecoration(
                                border: Utils.tableBorder,
                                color: AppColors.whiteColor,
                              ),
                              children: [
                                dataCell("${1 + i}"),
                                dataCell(model.settlementListFie[i].lotType!),
                                dataCell(
                                    model.settlementListFie[i].dateGenerated!),
                                dataCell(
                                    model.settlementListFie[i].effectiveDate!),
                                dataCell(
                                    model.settlementListFie[i].lotId!
                                        .lastChars(10),
                                    isCenter: false),
                                dataCell(model.settlementListFie[i].currency!),
                                dataCell(model.settlementListFie[i].amount!
                                    .toString()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: statusBtn(
                                      status:
                                          model.settlementListFie[i].status!,
                                      statusDescription: model
                                          .settlementListFie[i]
                                          .statusDescription!),
                                ),
                                Center(
                                  child: PopupMenuWithValue(
                                      onTap: (int v) {
                                        model.gotoDetails(
                                            context,
                                            model.settlementListFie[i].lotId!,
                                            model.settlementListFie[i].type!);
                                      },
                                      text: AppLocalizations.of(context)!
                                          .webActionButtons_title,
                                      color: AppColors.contextMenuTwo,
                                      items: [
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
                      if (model.settlementListFie.isEmpty)
                        Utils.noDataWidget(context, height: 60.0),
                      20.0.giveHeight,
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
        : Center(
            child: model.busy(model.settlementList)
                ? SizedBox(
                    // width: 100.0.wp,
                    // height: 20.0.hp,
                    child: Center(
                      child: Utils.bigLoader(),
                    ),
                  )
                : Column(
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border:
                            TableBorder.all(color: AppColors.tableHeaderBody),
                        columnWidths: const {
                          0: FixedColumnWidth(100.0), // fixed to 100 width
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          4: FlexColumnWidth(),
                          3: FixedColumnWidth(120.0), //
                          5: FixedColumnWidth(130.0), //f
                          6: FixedColumnWidth(200.0), //f
                          //fixed to 100 width
                        },
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color: AppColors.tableHeaderColor,
                              ),
                              children: [
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_settNo),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_postingDate),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_LotId),
                                dataCellHd(AppLocalizations.of(context)!
                                    .table_currency),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_amount),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_status),
                                dataCellHd(
                                    AppLocalizations.of(context)!.table_action),
                              ]),
                          for (int i = 0; i < model.settlementList.length; i++)
                            TableRow(
                              decoration: BoxDecoration(
                                border: Utils.tableBorder,
                                color: AppColors.whiteColor,
                              ),
                              children: [
                                dataCell("${1 + i}"),
                                dataCell(model.settlementList[i].postingDate!),
                                dataCell(
                                    model.settlementList[i].lotId!
                                        .lastChars(10),
                                    isCenter: false),
                                dataCell(model.settlementList[i].currency!),
                                dataCellAmount(Utils.stringTo2Decimal(
                                    model.settlementList[i].amount)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: statusBtn(
                                      status: model.settlementList[i].status!,
                                      statusDescription: model.settlementList[i]
                                          .statusDescription!),
                                ),
                                Center(
                                  child: PopupMenuWithValue(
                                      onTap: (v) {
                                        model.gotoDetails(
                                            context,
                                            model.settlementList[i].lotId!,
                                            model.settlementList[i].lotType!);
                                      },
                                      text: AppLocalizations.of(context)!
                                          .webActionButtons_title,
                                      color: AppColors.contextMenuTwo,
                                      items: [
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
                      if (model.settlementList.isEmpty)
                        Utils.noDataWidget(context),
                      20.0.giveHeight,
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
          );
  }

  accountingCardFie(
      String page, BuildContext context, SettlementScreenViewModel model) {
    return model.fieAccountList.isEmpty
        ? Center(
            child: model.busy(model.fieAccountList)
                ? SizedBox(
                    width: 100.0.wp,
                    height: 20.0.hp,
                    child: Center(
                      child: Utils.loaderBusy(),
                    ),
                  )
                : Text(AppLocalizations.of(context)!.noDataInTable("")),
          )
        : Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: AppColors.tableHeaderBody),
            columnWidths: const {
              0: FixedColumnWidth(100.0), // fixed to 100 width
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FixedColumnWidth(120.0),
              5: FixedColumnWidth(130.0),
              6: FixedColumnWidth(200.0),
              7: FixedColumnWidth(200.0),
            },
            children: [
              TableRow(
                  decoration: const BoxDecoration(
                    color: AppColors.tableHeaderColor,
                  ),
                  children: [
                    dataCellHd(AppLocalizations.of(context)!.table_sequence),
                    dataCellHd(
                        AppLocalizations.of(context)!.table_effectiveDate),
                    dataCellHd(AppLocalizations.of(context)!.table_accountType),
                    dataCellHd(
                        AppLocalizations.of(context)!.table_accountNumber),
                    dataCellHd(AppLocalizations.of(context)!.table_costCenter),
                    dataCellHd(AppLocalizations.of(context)!.table_debitCredit),
                    dataCellHd(AppLocalizations.of(context)!.table_status),
                    dataCellHd(AppLocalizations.of(context)!.table_amount),
                  ]),
              for (int i = 0; i < model.fieAccountList.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    border: Utils.tableBorder,
                    color: AppColors.whiteColor,
                  ),
                  children: [
                    dataCell("${1 + i}"),
                    dataCell(model.fieAccountList[i].effectiveDate!),
                    dataCell(model.fieAccountList[i].accountType!),
                    dataCell(model.fieAccountList[i].accountNumber!.toString()),
                    dataCell("-"),
                    dataCell(model.fieAccountList[i].debitCredit!),
                    dataCell(model.fieAccountList[i].currency!.toString()),
                    dataCell(model.fieAccountList[i].amount!.toString()),
                  ],
                ),
            ],
          );
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
