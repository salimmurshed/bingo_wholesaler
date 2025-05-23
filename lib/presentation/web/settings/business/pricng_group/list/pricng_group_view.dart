import 'package:bingo/const/all_const.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../widgets/buttons/submit_button.dart';
import '../../../../../widgets/web_widgets/body/table.dart';
import '../../../../../widgets/web_widgets/cards/add_new_with_header.dart';
import '../../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../../widgets/web_widgets/website_base_body.dart';
import 'pricng_group_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class PricingGroupView extends StatelessWidget {
  const PricingGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PricingGroupViewModel>.reactive(
        viewModelBuilder: () => PricingGroupViewModel(),
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
                          h1: 'View Pricing Group',
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
                                  h1: 'View Pricing Group',
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
                            body: model.isBusy && model.pricingGroup == null
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
                                        label: 'View Pricing Group',
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
                                                3: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        200.0)
                                                    : const FlexColumnWidth(),
                                                4: const FixedColumnWidth(
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
                                                        "Pricing Groups Name",
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
                                                        model.pricingGroup!
                                                            .data!.length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          "${1 + i}",
                                                        ),
                                                      ),
                                                      dataCell(
                                                          model
                                                              .pricingGroup!
                                                              .data![i]
                                                              .pricingGroups!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model
                                                              .pricingGroup!
                                                              .data![i]
                                                              .pricingGroupName!,
                                                          isCenter: false),
                                                      dataCell(
                                                        model.pricingGroup!
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
