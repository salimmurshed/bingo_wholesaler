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
import '../../../../../widgets/web_widgets/body/table.dart';
import '../../../../../widgets/web_widgets/cards/add_new_with_header.dart';
import '../../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../../widgets/web_widgets/website_base_body.dart';
import 'grace_periods_groups_view_model.dart';

class GracePeriodsGroupsView extends StatelessWidget {
  const GracePeriodsGroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GracePeriodsGroupsViewModel>.reactive(
        viewModelBuilder: () => GracePeriodsGroupsViewModel(),
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
                          h1: 'View Grace Period Group',
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
                        )
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
                                  h1: 'View Grace Period Group',
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
                                )
                              ],
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AddNewWithHeader(
                                        onTap: null,
                                        onTapTitle:
                                            AppLocalizations.of(context)!
                                                .addNew,
                                        label: 'View Grace Period Group',
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
                                                        200.0)
                                                    : const FlexColumnWidth(),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        200.0)
                                                    : const FlexColumnWidth(),
                                                3: const FixedColumnWidth(
                                                    150.0),
                                                4: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
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
                                                        "Type Id",
                                                      ),
                                                      dataCellHd(
                                                        "Grace Period Name",
                                                      ),
                                                      dataCellHd(
                                                        "Grace Period Days",
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_date),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model.gracePeriodGroup!
                                                            .data!.length;
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
                                                              .gracePeriodGroup!
                                                              .data![i]
                                                              .gracePeriodGroup!,
                                                          isCenter: false),
                                                      dataCell(
                                                        model
                                                            .gracePeriodGroup!
                                                            .data![i]
                                                            .gracePeriodName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCellAmount(
                                                        model
                                                            .gracePeriodGroup!
                                                            .data![i]
                                                            .gracePeriodDays!
                                                            .toString(),
                                                      ),
                                                      dataCell(
                                                        model.gracePeriodGroup!
                                                            .data![i].date!,
                                                      ),
                                                      Center(
                                                        // width: 80,
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
