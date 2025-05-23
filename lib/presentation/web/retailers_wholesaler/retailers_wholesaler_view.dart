import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/cupertino.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/web_widgets/body/pagination.dart';
import '../../widgets/web_widgets/body/table.dart';
import '../../widgets/web_widgets/website_base_body.dart';
import 'retailers_wholesaler_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class RetailerWholeSalerView extends StatelessWidget {
  const RetailerWholeSalerView({super.key, this.page});

  final String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerWholeSalerViewModel>.reactive(
        viewModelBuilder: () => RetailerWholeSalerViewModel(),
        onViewModelReady: (RetailerWholeSalerViewModel model) {
          model.getRetailersWholesalers(page!);
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
                            h1: model.enrollment == UserTypeForWeb.wholesaler
                                ? 'View Retailers'
                                : 'View Wholesalers',
                          ),
                        ),
                        const SizedBox()
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
                            SecondaryNameAppBar(
                              h1: model.enrollment == UserTypeForWeb.wholesaler
                                  ? 'View Retailers'
                                  : 'View Wholesalers',
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flex(
                                        direction: device == ScreenSize.wide
                                            ? Axis.horizontal
                                            : Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.enrollment ==
                                                    UserTypeForWeb.wholesaler
                                                ? 'View Retailers'
                                                : 'View Wholesalers',
                                            style: AppTextStyles.headerText,
                                          ),
                                          if (device == ScreenSize.small)
                                            10.0.giveHeight,
                                          Flex(
                                            direction: device == ScreenSize.wide
                                                ? Axis.horizontal
                                                : Axis.vertical,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (model.enrollment ==
                                                  UserTypeForWeb.wholesaler)
                                                SubmitButton(
                                                  height: 45.0,
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 100.0.wp
                                                          : 100.0,
                                                  isRadius: false,
                                                  text:
                                                      "Upload (Update) Retailer Information",
                                                  color: AppColors.bingoGreen,
                                                ),
                                              if (device == ScreenSize.small)
                                                10.0.giveHeight,
                                              if (model.enrollment ==
                                                  UserTypeForWeb.wholesaler)
                                                SubmitButton(
                                                  height: 45.0,
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 100.0.wp
                                                          : 100.0,
                                                  isRadius: false,
                                                  text:
                                                      "Download retailers Information",
                                                  color:
                                                      AppColors.webButtonColor,
                                                ),
                                              if (device == ScreenSize.small)
                                                10.0.giveHeight,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
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
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      10.0.giveHeight,
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
                                                        120.0)
                                                    : const FlexColumnWidth(),
                                                2: const FixedColumnWidth(
                                                    200.0),
                                                3: const FixedColumnWidth(
                                                    200.0),
                                                4: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                5: const FixedColumnWidth(
                                                    200.0),
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
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_no),
                                                      dataCellHd(model
                                                                  .enrollment ==
                                                              UserTypeForWeb
                                                                  .wholesaler
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .table_retailerName
                                                          : AppLocalizations.of(
                                                                  context)!
                                                              .table_wholesalerName),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_phoneNo),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_id),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_email),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_status),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_action),
                                                    ]),
                                                for (int i = 0;
                                                    i < model.customers.length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        model.enrollment ==
                                                                UserTypeForWeb
                                                                    .wholesaler
                                                            ? "${i + model.pageFrom}"
                                                            : "${i + 1}",
                                                      ),
                                                      dataCell(
                                                          model.enrollment ==
                                                                  UserTypeForWeb
                                                                      .wholesaler
                                                              ? model
                                                                  .customers[i]
                                                                  .retailerName!
                                                              : model
                                                                  .customers[i]
                                                                  .wholeSalerName!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.customers[i]
                                                              .phoneNumber!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.customers[i]
                                                              .taxId!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.customers[i]
                                                              .retailerEmail!,
                                                          isCenter: false),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        child: Center(
                                                          child: Text(
                                                            model.customers[i]
                                                                .status!,
                                                            style: AppTextStyles.webTableBody.copyWith(
                                                                color: model
                                                                            .customers[
                                                                                i]
                                                                            .status!
                                                                            .toLowerCase() ==
                                                                        "active"
                                                                    ? AppColors
                                                                        .statusVerified
                                                                    : AppColors
                                                                        .statusReject),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 30),
                                                        child: FittedBox(
                                                          // width: 80,
                                                          child: Material(
                                                            color: Colors.white,
                                                            child: PopupMenuButton<
                                                                    int>(
                                                                color: Colors
                                                                    .white,
                                                                splashRadius:
                                                                    20.0,
                                                                offset:
                                                                    const Offset(
                                                                        0, 40),
                                                                onSelected:
                                                                    (int v) {
                                                                  model.action(
                                                                    context,
                                                                    model
                                                                        .customers[
                                                                            i]
                                                                        .tempTxAddress!,
                                                                    model
                                                                        .customers[
                                                                            i]
                                                                        .uniqueId!,
                                                                  );
                                                                },
                                                                elevation: 8.0,
                                                                tooltip: "",
                                                                itemBuilder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return [
                                                                    PopupMenuItem<
                                                                        int>(
                                                                      height:
                                                                          30,
                                                                      value: 0,
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .webActionButtons_view,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              AppColors.ashColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ];
                                                                },
                                                                child: Card(
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  elevation: 2,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10.0,
                                                                        vertical:
                                                                            2.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .actions,
                                                                          style:
                                                                              const TextStyle(color: AppColors.whiteColor),
                                                                        ),
                                                                        const Icon(
                                                                            Icons
                                                                                .keyboard_arrow_down_sharp,
                                                                            color:
                                                                                AppColors.whiteColor)
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (model.customers.isEmpty)
                                        Utils.noDataWidget(context,
                                            height: 60.0),
                                      20.0.giveHeight,
                                      if (model.enrollment ==
                                          UserTypeForWeb.wholesaler)
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
