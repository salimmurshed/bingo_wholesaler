import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../widgets/buttons/submit_button.dart';
import '../../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../../widgets/web_widgets/body/table.dart';
import '../../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../../widgets/web_widgets/website_base_body.dart';
import 'sales_zones_list_view_model.dart';

class SalesZoneListView extends StatelessWidget {
  const SalesZoneListView({super.key, this.page});
  final String? page;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesZoneListViewModel>.reactive(
        viewModelBuilder: () => SalesZoneListViewModel(),
        onViewModelReady: (SalesZoneListViewModel model) {
          model.getData(page);
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
                    title: Row(
                      children: [
                        SecondaryNameAppBar(
                          h1: 'View Sales Zone',
                        ),
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
                                  h1: 'View Sales Zone',
                                ),
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
                                            'View Sales Zone',
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
                                                    200.0),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        200.0)
                                                    : const FlexColumnWidth(),
                                                3: const FixedColumnWidth(
                                                    200.0),
                                                4: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        200.0)
                                                    : const FlexColumnWidth(),
                                                5: const FixedColumnWidth(
                                                    200.0),
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
                                                            .sNo,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_saleId,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_salesName,
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_status),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_date,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i < model.salesZones.length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        "${model.pageFrom + i}",
                                                      ),
                                                      dataCell(
                                                        model.salesZones[i]
                                                            .salesId!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model.salesZones[i]
                                                            .salesZoneName!,
                                                        isCenter: false,
                                                      ),
                                                      statusCard(
                                                        model.salesZones[i]
                                                            .statusDescription!,
                                                        (model.salesZones[i]
                                                                        .status ??
                                                                    1) ==
                                                                1
                                                            ? AppColors
                                                                .greenColor
                                                            : AppColors
                                                                .redColor,
                                                      ),
                                                      dataCell(
                                                        model.salesZones[i]
                                                            .createdAt!,
                                                      ),
                                                      Center(
                                                        child:
                                                            PopupMenuWithValue(
                                                                onTap: (int v) {
                                                                  model.action(
                                                                      context,
                                                                      i);
                                                                },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .table_action,
                                                                color: AppColors
                                                                    .contextMenuTwo,
                                                                items: [
                                                              {
                                                                't': AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_edit,
                                                                'v': 0
                                                              },
                                                              {
                                                                't': AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_delete,
                                                                'v': 1
                                                              },
                                                              (model.salesZones[i].status ??
                                                                          0) ==
                                                                      0
                                                                  ? {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_active,
                                                                      'v': 2
                                                                    }
                                                                  : {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_inactive,
                                                                      'v': 2
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

  statusCard(String title, Color color) {
    return Center(
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.all(3),
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.statusCardStatus
                  .copyWith(color: AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
