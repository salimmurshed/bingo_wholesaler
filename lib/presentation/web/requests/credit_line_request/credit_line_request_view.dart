import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_sizes/app_sizes.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
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
import '../../../widgets/web_widgets/with_tab_website_base_body.dart';
import 'credit_line_request_view_model.dart';

class CreditLineRequestWebView extends StatelessWidget {
  const CreditLineRequestWebView({super.key, this.page});

  final String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditLineRequestWebViewModel>.reactive(
        viewModelBuilder: () => CreditLineRequestWebViewModel(),
        onViewModelReady: (CreditLineRequestWebViewModel model) {
          model.getCreditLinesListWeb(page!);
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
                            h1: 'View All CreditLine Request',
                          ),
                        ),
                        if (model.enrollment == UserTypeForWeb.retailer)
                          SubmitButton(
                            color: AppColors.bingoGreen,
                            // color: AppColors.bingoGreen,
                            isRadius: false,
                            height: 45,
                            width: 80,
                            onPressed: () {
                              model.addNew(context);
                            },
                            text: AppLocalizations.of(context)!.addNew,
                          ),
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
                                  h1: 'View All CreditLine Request',
                                ),
                                if (model.enrollment == UserTypeForWeb.retailer)
                                  SubmitButton(
                                    color: AppColors.bingoGreen,
                                    // color: AppColors.bingoGreen,
                                    isRadius: false,
                                    height: 45,
                                    width: 80,
                                    onPressed: () {
                                      model.addNew(context);
                                    },
                                    text: AppLocalizations.of(context)!.addNew,
                                  ),
                              ],
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Scrollbar(
                                        controller: model.scrollController,
                                        thickness: 10,
                                        child: SingleChildScrollView(
                                          controller: model.scrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            width: device != ScreenSize.wide
                                                ? null
                                                : 100.0.wp - 64 - 64,
                                            child:
                                                model.enrollment ==
                                                        UserTypeForWeb
                                                            .wholesaler
                                                    ? Table(
                                                        defaultVerticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .middle,
                                                        border: TableBorder.all(
                                                            color: AppColors
                                                                .tableHeaderBody),
                                                        columnWidths: {
                                                          0: const FixedColumnWidth(
                                                              70.0),
                                                          1: device !=
                                                                  ScreenSize
                                                                      .wide
                                                              ? const FixedColumnWidth(
                                                                  120.0)
                                                              : const FlexColumnWidth(),
                                                          2: const FixedColumnWidth(
                                                              150.0),
                                                          3: const FixedColumnWidth(
                                                              150.0),
                                                          4: const FixedColumnWidth(
                                                              150.0),
                                                          5: const FixedColumnWidth(
                                                              150.0),
                                                          6: device !=
                                                                  ScreenSize
                                                                      .wide
                                                              ? const FixedColumnWidth(
                                                                  150.0)
                                                              : const FlexColumnWidth(),
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
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_no),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_retailerName),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_fIE),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_dateRequested),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_currency),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_amount),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_status),
                                                                dataCellHd(AppLocalizations.of(
                                                                        context)!
                                                                    .table_action),
                                                              ]),
                                                          for (int i = 0;
                                                              i <
                                                                  model
                                                                      .creditLineRequests
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
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      dataCell(
                                                                    "${1 + i}",
                                                                    isCenter:
                                                                        true,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: dataCell(
                                                                      model
                                                                          .creditLineRequests[
                                                                              i]
                                                                          .retailerName!,
                                                                      isCenter:
                                                                          false),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: dataCell(
                                                                      model
                                                                          .creditLineRequests[
                                                                              i]
                                                                          .fieName!,
                                                                      isCenter:
                                                                          false),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      dataCell(
                                                                    model
                                                                        .creditLineRequests[
                                                                            i]
                                                                        .dateRequested!,
                                                                    isCenter:
                                                                        false,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      dataCell(
                                                                    model
                                                                        .creditLineRequests[
                                                                            i]
                                                                        .currency!,
                                                                    isCenter:
                                                                        true,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      dataCellAmount(
                                                                    (double.parse(model
                                                                            .creditLineRequests[
                                                                                i]
                                                                            .requestedAmount!))
                                                                        .toStringAsFixed(
                                                                            2),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: model.creditLineRequests[i].status!.toStatusFromInt(
                                                                      textStyle: AppTextStyles
                                                                          .statusCardStatus
                                                                          .copyWith(
                                                                              fontSize: AppFontSize
                                                                                  .s14),
                                                                      value: StatusFile.statusForCreditline(
                                                                          "en",
                                                                          model
                                                                              .creditLineRequests[
                                                                                  i]
                                                                              .status!,
                                                                          model
                                                                              .creditLineRequests[i]
                                                                              .statusDescription!)),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          30),
                                                                  child:
                                                                      FittedBox(
                                                                    // width: 80,
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .white,
                                                                      child: PopupMenuButton<
                                                                              int>(
                                                                          color: Colors
                                                                              .white,
                                                                          splashRadius:
                                                                              20.0,
                                                                          offset: const Offset(0,
                                                                              40),
                                                                          onSelected: (int
                                                                              v) {
                                                                            model.action(
                                                                                context,
                                                                                v,
                                                                                model.creditLineRequests[i].uniqueId);
                                                                          },
                                                                          elevation:
                                                                              8.0,
                                                                          tooltip:
                                                                              "",
                                                                          itemBuilder: (BuildContext
                                                                              context) {
                                                                            return [
                                                                              PopupMenuItem<int>(
                                                                                  height: 30,
                                                                                  value: 0,
                                                                                  child: Text(AppLocalizations.of(context)!.review,
                                                                                      style: const TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: AppColors.ashColor,
                                                                                      ))),
                                                                            ];
                                                                          },
                                                                          child:
                                                                              Card(
                                                                            color:
                                                                                AppColors.contextMenuTwo,
                                                                            elevation:
                                                                                2,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(context)!.actions,
                                                                                    style: const TextStyle(color: AppColors.whiteColor),
                                                                                  ),
                                                                                  const Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.whiteColor)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      )
                                                    : model.enrollment ==
                                                            UserTypeForWeb
                                                                .retailer
                                                        ? Table(
                                                            defaultVerticalAlignment:
                                                                TableCellVerticalAlignment
                                                                    .middle,
                                                            border: TableBorder.all(
                                                                color: AppColors
                                                                    .tableHeaderBody),
                                                            columnWidths: {
                                                              0: const FixedColumnWidth(
                                                                  70.0),
                                                              1: device !=
                                                                      ScreenSize
                                                                          .wide
                                                                  ? const FixedColumnWidth(
                                                                      120.0)
                                                                  : const FlexColumnWidth(),
                                                              2: const FixedColumnWidth(
                                                                  150.0),
                                                              3: const FixedColumnWidth(
                                                                  150.0),
                                                              4: device !=
                                                                      ScreenSize
                                                                          .wide
                                                                  ? const FixedColumnWidth(
                                                                      150.0)
                                                                  : const FlexColumnWidth(),
                                                              5: device !=
                                                                      ScreenSize
                                                                          .wide
                                                                  ? const FixedColumnWidth(
                                                                      150.0)
                                                                  : const FlexColumnWidth(),
                                                              6: const FixedColumnWidth(
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
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_no),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_wholesalerName),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_fIE),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_type),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_dateRequested),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_status),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_action),
                                                                  ]),
                                                              for (int i = 0;
                                                                  i <
                                                                      model
                                                                          .creditLineRequestsRetailer
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
                                                                    dataCell(
                                                                      "${1 + i}",
                                                                      isCenter:
                                                                          true,
                                                                    ),
                                                                    dataCell(
                                                                        model
                                                                            .creditLineRequestsRetailer[
                                                                                i]
                                                                            .wholesalerName!,
                                                                        isCenter:
                                                                            false),
                                                                    dataCell(
                                                                        model
                                                                            .creditLineRequestsRetailer[
                                                                                i]
                                                                            .fieName!,
                                                                        isCenter:
                                                                            false),
                                                                    dataCell(
                                                                      model
                                                                          .creditLineRequestsRetailer[
                                                                              i]
                                                                          .type!,
                                                                      isCenter:
                                                                          true,
                                                                    ),
                                                                    dataCell(
                                                                      model
                                                                          .creditLineRequestsRetailer[
                                                                              i]
                                                                          .dateRequested!,
                                                                      isCenter:
                                                                          true,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: model
                                                                          .creditLineRequestsRetailer[
                                                                              i]
                                                                          .status!
                                                                          .toStatusFromInt(
                                                                              textStyle: AppTextStyles.statusCardStatus.copyWith(fontSize: AppFontSize.s14),
                                                                              value: StatusFile.statusForCreditline("en", model.creditLineRequestsRetailer[i].status!, model.creditLineRequestsRetailer[i].statusDescription!)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              30),
                                                                      child:
                                                                          FittedBox(
                                                                        // width: 80,
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.white,
                                                                          child: PopupMenuButton<int>(
                                                                              color: Colors.white,
                                                                              splashRadius: 20.0,
                                                                              offset: const Offset(0, 40),
                                                                              onSelected: (int v) {
                                                                                model.action(context, v, model.creditLineRequestsRetailer[i].creditlineUniqueId);
                                                                              },
                                                                              elevation: 8.0,
                                                                              tooltip: "",
                                                                              itemBuilder: (BuildContext context) {
                                                                                return [
                                                                                  PopupMenuItem<int>(
                                                                                      height: 30,
                                                                                      value: 0,
                                                                                      child: Text(AppLocalizations.of(context)!.review,
                                                                                          style: const TextStyle(
                                                                                            fontSize: 12,
                                                                                            color: AppColors.ashColor,
                                                                                          ))),
                                                                                ];
                                                                              },
                                                                              child: Card(
                                                                                color: AppColors.contextMenuTwo,
                                                                                elevation: 2,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(3),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        AppLocalizations.of(context)!.actions,
                                                                                        style: const TextStyle(color: AppColors.whiteColor),
                                                                                      ),
                                                                                      const Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.whiteColor)
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                          ),
                                        ),
                                      ),
                                if (!model.isBusy)
                                  if (model.enrollment ==
                                      UserTypeForWeb.wholesaler)
                                    if (model.creditLineRequests.isEmpty)
                                      Utils.noDataWidget(context, height: 100),
                                if (!model.isBusy)
                                  if (model.enrollment ==
                                      UserTypeForWeb.retailer)
                                    if (model
                                        .creditLineRequestsRetailer.isEmpty)
                                      Utils.noDataWidget(context, height: 100),
                                20.0.giveHeight,
                                // if (model.totalPage > 0)
                                if (!model.isBusy)
                                  if (model.creditLineRequests.isNotEmpty)
                                    PaginationWidget(
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
                            child: navBar(context, model),
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

  Widget navBar(BuildContext context, CreditLineRequestWebViewModel model) {
    return Flex(
      direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NavButton(
                isBottom: Routes.wholesalerRequest ==
                        Utils.narrateFunction(
                            ModalRoute.of(context)!.settings.name!) ||
                    Routes.retailerRequest ==
                        Utils.narrateFunction(
                            ModalRoute.of(context)!.settings.name!),
                text: model.enrollment == UserTypeForWeb.wholesaler
                    ? "Association Requests"
                    : AppLocalizations.of(context)!.associationScreen_tab1,
                onTap: () {
                  model.changeScreen(
                      context,
                      model.enrollment == UserTypeForWeb.wholesaler
                          ? Routes.retailerRequest
                          : Routes.wholesalerRequest);
                },
              ),
              if (model.enrollment == UserTypeForWeb.retailer)
                NavButton(
                  isBottom: false,
                  text: AppLocalizations.of(context)!.associationScreen_tab2,
                  onTap: () {
                    model.changeScreen(context, Routes.fieRequest);
                  },
                ),
              NavButton(
                isBottom: Routes.creditLineRequestWebView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
                text: AppLocalizations.of(context)!.associationScreen_tab3,
                onTap: () {
                  model.changeScreen(context, Routes.creditLineRequestWebView);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AppLocalizations.of(context)!.search),
              ),
              10.0.giveWidth,
              SizedBox(
                width: 100,
                height: 50,
                child: NameTextField(
                  onChanged: (String v) {
                    // model.searchList(v);
                  },
                  hintStyle: AppTextStyles.formTitleTextStyleNormal,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
