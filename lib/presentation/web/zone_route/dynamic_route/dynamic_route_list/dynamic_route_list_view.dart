import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/enums/zone_route.dart';
import '../../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import 'dynamic_route_list_view_model.dart';

class DynamicRoutesListView extends StatelessWidget {
  const DynamicRoutesListView(
      {super.key, this.type, this.page, this.from, this.to});
  final String? type;
  final String? page;
  final String? from;
  final String? to;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DynamicRoutesListViewModel>.reactive(
        viewModelBuilder: () => DynamicRoutesListViewModel(),
        onViewModelReady: (DynamicRoutesListViewModel model) {
          model.prefill(type!, page, from, to);
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
                      h1: type == Routes.zoneRouteDynamic
                          ? 'View Dynamic Routes'
                          : type == Routes.zoneRouteStatic
                              ? 'View Statics Routes'
                              : type == Routes.zoneRouteZone
                                  ? 'View Sales Zone'
                                  : 'Upload Options',
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
                              h1: type == Routes.zoneRouteDynamic
                                  ? 'View Dynamic Routes'
                                  : type == Routes.zoneRouteStatic
                                      ? 'View Statics Routes'
                                      : type == Routes.zoneRouteZone
                                          ? 'View Sales Zone'
                                          : 'Upload Options',
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    model.isBusy
                                        ? Utils.bigLoader()
                                        : Column(
                                            children: [
                                              if (type ==
                                                  Routes.zoneRouteDynamic)
                                                Flex(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  direction:
                                                      device == ScreenSize.small
                                                          ? Axis.vertical
                                                          : Axis.horizontal,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 70,
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 200,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          model.selectDateFormedCompanyProfile(
                                                              model
                                                                  .fromDateController);
                                                        },
                                                        child: AbsorbPointer(
                                                          child: NameTextField(
                                                            enable: true,
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                            fieldName:
                                                                "From Date",
                                                            controller: model
                                                                .fromDateController,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (device ==
                                                        ScreenSize.wide)
                                                      10.0.giveWidth,
                                                    SizedBox(
                                                      height: 70,
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 200,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          model.selectDateFormedCompanyProfile(
                                                              model
                                                                  .toDateController);
                                                        },
                                                        child: AbsorbPointer(
                                                          child: NameTextField(
                                                            enable: true,
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                            fieldName:
                                                                "To Date",
                                                            controller: model
                                                                .toDateController,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    if (device !=
                                                        ScreenSize.small)
                                                      10.0.giveWidth,
                                                    if (device ==
                                                        ScreenSize.small)
                                                      10.0.giveHeight,
                                                    //filder submit button
                                                    SizedBox(
                                                      height: 55,
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 120.0,
                                                      child: SubmitButton(
                                                        isRadius: false,
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .submitButton,
                                                        onPressed: () {
                                                          model.callDynamic(
                                                              context, type!);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              20.0.giveHeight,
                                              type == Routes.zoneRouteOption
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Route Upload Structure",
                                                          style: AppTextStyles
                                                              .drawerText,
                                                        ),
                                                        10.0.giveHeight,
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionOne(
                                                                      0);
                                                            },
                                                            isSelected: model
                                                                    .optionOne ==
                                                                0,
                                                            text:
                                                                'Retailer Store Id Have A Unique Identifier  '),
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionOne(
                                                                      1);
                                                            },
                                                            isSelected: model
                                                                    .optionOne ==
                                                                1,
                                                            text:
                                                                'Retailer Store Id Is Not Unique And Could Be Repeated'),
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionOne(
                                                                      2);
                                                            },
                                                            isSelected: model
                                                                    .optionOne ==
                                                                2,
                                                            text:
                                                                'Use Bingo Store Id'),
                                                        const Divider(
                                                          color: AppColors
                                                              .dividerColor,
                                                        ),
                                                        20.0.giveHeight,
                                                        const Text(
                                                          "Dynamic Route Upload Structure",
                                                          style: AppTextStyles
                                                              .drawerText,
                                                        ),
                                                        10.0.giveHeight,
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionTwo(
                                                                      0);
                                                            },
                                                            isSelected: model
                                                                    .optionTwo ==
                                                                0,
                                                            text:
                                                                'Invoice Number Have A Unique Identifier  '),
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionTwo(
                                                                      1);
                                                            },
                                                            isSelected: model
                                                                    .optionTwo ==
                                                                1,
                                                            text:
                                                                'Invoice Number Is Not Unique And Could Be Repeated'),
                                                        optionTaps(
                                                            func: () {
                                                              model
                                                                  .changeOptionTwo(
                                                                      2);
                                                            },
                                                            isSelected: model
                                                                    .optionTwo ==
                                                                2,
                                                            text:
                                                                'Use Bingo Sale Id'),
                                                        const Divider(
                                                          color: AppColors
                                                              .dividerColor,
                                                        ),
                                                        20.0.giveHeight,
                                                        const SubmitButton(
                                                          height: 45.0,
                                                          isRadius: false,
                                                          text:
                                                              "Route Upload Structure",
                                                        )
                                                      ],
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
                                                          width: device !=
                                                                  ScreenSize
                                                                      .wide
                                                              ? null
                                                              : 100.0.wp -
                                                                  64 -
                                                                  64,
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
                                                                  150.0),
                                                              2: device !=
                                                                      ScreenSize
                                                                          .wide
                                                                  ? const FixedColumnWidth(
                                                                      200.0)
                                                                  : const FlexColumnWidth(),
                                                              3: const FixedColumnWidth(
                                                                  150.0),
                                                              4: device !=
                                                                      ScreenSize
                                                                          .wide
                                                                  ? const FixedColumnWidth(
                                                                      200.0)
                                                                  : const FlexColumnWidth(),
                                                              5: const FixedColumnWidth(
                                                                  150.0),
                                                              6: const FixedColumnWidth(
                                                                  150.0),
                                                              7: const FixedColumnWidth(
                                                                  150.0),
                                                              8: const FixedColumnWidth(
                                                                  150.0),
                                                              9: const FixedColumnWidth(
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
                                                                        AppLocalizations.of(context)!
                                                                            .sNo),
                                                                    dataCellHd(model.screenType ==
                                                                            Routes.zoneRouteZone
                                                                        ? "Sale ID"
                                                                        : "Route ID"),
                                                                    dataCellHd(model.screenType ==
                                                                            Routes
                                                                                .zoneRouteZone
                                                                        ? "Sales Zone Name"
                                                                        : AppLocalizations.of(context)!
                                                                            .table_description),
                                                                    dataCellHd(model.screenType ==
                                                                            Routes.zoneRouteDynamic
                                                                        ? "Date"
                                                                        : "Sales Steps"), //
                                                                    dataCellHd(
                                                                        "Uploaded Date"),
                                                                    dataCellHd(
                                                                        "Retailer (Count)"),
                                                                    dataCellHd(
                                                                        "Stores (Count)"),
                                                                    dataCellHd(
                                                                        "Assigned to"),
                                                                    dataCellHd(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .table_status,
                                                                    ),
                                                                    dataCellHd(AppLocalizations.of(
                                                                            context)!
                                                                        .table_action),
                                                                  ]),
                                                              for (int i = 0;
                                                                  i <
                                                                      model
                                                                          .routes!
                                                                          .data!
                                                                          .data!
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
                                                                      "${model.pageFrom + i}",
                                                                    ),
                                                                    dataCell(
                                                                      model.screenType ==
                                                                              Routes
                                                                                  .zoneRouteZone
                                                                          ? model
                                                                              .routes!
                                                                              .data!
                                                                              .data![
                                                                                  i]
                                                                              .salesId!
                                                                          : model
                                                                              .routes!
                                                                              .data!
                                                                              .data![i]
                                                                              .routeId!,
                                                                    ),
                                                                    dataCell(
                                                                      model.screenType ==
                                                                              Routes
                                                                                  .zoneRouteZone
                                                                          ? model
                                                                              .routes!
                                                                              .data!
                                                                              .data![
                                                                                  i]
                                                                              .salesZoneName!
                                                                          : model
                                                                              .routes!
                                                                              .data!
                                                                              .data![i]
                                                                              .description!,
                                                                    ),
                                                                    dataCell(
                                                                      model.screenType ==
                                                                              Routes
                                                                                  .zoneRouteDynamic
                                                                          ? model
                                                                              .routes!
                                                                              .data!
                                                                              .data![
                                                                                  i]
                                                                              .createdAt!
                                                                          : model.getSaleSteps(model
                                                                              .routes!
                                                                              .data!
                                                                              .data![i]
                                                                              .saleStep!),
                                                                    ),
                                                                    dataCell(
                                                                      model
                                                                          .routes!
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .updatedDate!,
                                                                    ),
                                                                    dataCell(
                                                                      model
                                                                          .routes!
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .retailersCount!
                                                                          .toString(),
                                                                    ),
                                                                    dataCell(
                                                                      model
                                                                          .routes!
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .storesCount!
                                                                          .toString(),
                                                                    ),
                                                                    dataCell(
                                                                      model
                                                                          .routes!
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .assignTo!
                                                                          .replaceAll(
                                                                              ",",
                                                                              ", "),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        model
                                                                            .routes!
                                                                            .data!
                                                                            .data![i]
                                                                            .statusDescription!,
                                                                        style: TextStyle(
                                                                            color: model.routes!.data!.data![i].statusDescription!.toLowerCase() == "active"
                                                                                ? AppColors.statusVerified
                                                                                : AppColors.statusLiteRedColor),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      // width: 80,
                                                                      child:
                                                                          PopupMenuWithValue(
                                                                        onTap: (int
                                                                            v) {
                                                                          model.changeStatus(
                                                                              model.routes!.data!.data![i].uniqueId!,
                                                                              model.routes!.data!.data![i].statusDescription!.toLowerCase(),
                                                                              v,
                                                                              page,
                                                                              type,
                                                                              from,
                                                                              to);
                                                                        },
                                                                        text: AppLocalizations.of(context)!
                                                                            .table_action,
                                                                        color: AppColors
                                                                            .contextMenuTwo,
                                                                        items: [
                                                                          {
                                                                            't':
                                                                                AppLocalizations.of(context)!.webActionButtons_edit,
                                                                            'v':
                                                                                0
                                                                          },
                                                                          {
                                                                            't':
                                                                                AppLocalizations.of(context)!.webActionButtons_view,
                                                                            'v':
                                                                                1
                                                                          },
                                                                          model.routes!.data!.data![i].statusDescription!.toLowerCase() == "active"
                                                                              ? {
                                                                                  't': AppLocalizations.of(context)!.webActionButtons_inactive,
                                                                                  'v': 2
                                                                                }
                                                                              : {
                                                                                  't': AppLocalizations.of(context)!.webActionButtons_active,
                                                                                  'v': 2
                                                                                }
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
                                              if (type !=
                                                  Routes.zoneRouteOption)
                                                if (model.routes!.data!.data!
                                                    .isEmpty)
                                                  Utils.noDataWidget(context,
                                                      height: 100.0),
                                            ],
                                          ),
                                  ],
                                ),
                                20.0.giveHeight,
                                if (type != Routes.zoneRouteOption)
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
                                              model.changePage(
                                                  context, v, from!, to!);
                                            })
                              ],
                            ),
                            child: Flex(
                              direction: device == ScreenSize.small
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                headerNavs(context, model.screenType, model),
                                if (!model.isBusy)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Flex(
                                      direction: device == ScreenSize.small
                                          ? Axis.vertical
                                          : Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (type == Routes.zoneRouteDynamic ||
                                            type == Routes.zoneRouteStatic)
                                          SubmitButton(
                                            height: 45.0,
                                            width: device != ScreenSize.wide
                                                ? 80.0.wp
                                                : 100.0,
                                            isRadius: false,
                                            text: "Import CSV/XML File",
                                            onPressed: () {},
                                          ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!
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

  optionTaps(
      {required bool isSelected,
      required String text,
      required Function() func}) {
    return InkWell(
      onTap: func,
      child: Row(
        children: [
          isSelected
              ? const Icon(
                  Icons.radio_button_checked,
                  color: AppColors.liteBlueColor,
                )
              : const Icon(Icons.radio_button_off_outlined),
          10.0.giveWidth,
          Text(text)
        ],
      ),
    );
  }

  headerNavs(BuildContext context, String screenType,
      DynamicRoutesListViewModel model) {
    Utils.fPrint(screenType);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          NavButton(
            isBottom: screenType == ZoneRoutes.dynamic.name,
            text: "Dynamic Routes",
            onTap: () {
              model.screenChange(context, ZoneRoutes.dynamic);
            },
          ),
          NavButton(
            isBottom: screenType == ZoneRoutes.static.name,
            text: "Statics Routes",
            onTap: () {
              model.screenChange(context, ZoneRoutes.static);
            },
          ),
          NavButton(
            isBottom: screenType == ZoneRoutes.zone.name,
            text: "Manage Sales Zone",
            onTap: () {
              model.screenChange(context, ZoneRoutes.zone);
            },
          ),
          NavButton(
            isBottom: screenType == ZoneRoutes.option.name,
            text: "Upload Options",
            onTap: () {
              model.screenChange(context, ZoneRoutes.option);
            },
          ),
        ],
      ),
    );
  }
}
