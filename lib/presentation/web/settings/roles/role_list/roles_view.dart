import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../const/special_key.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/add_new_with_header.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';
import 'roles_view_model.dart';

class RolesView extends StatelessWidget {
  const RolesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RolesViewModel>.reactive(
        viewModelBuilder: () => RolesViewModel(),
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
                      h1: 'View Roles',
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
                              h1: 'View Roles',
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AddNewWithHeader(
                                        label: 'View Roles',
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
                                                    200.0),
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
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_roleName,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_date,
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_status),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model.retailerRolesList
                                                            .length;
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
                                                              .retailerRolesList[
                                                                  i]
                                                              .roleName!,
                                                          isCenter: false),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          DateFormat(SpecialKeys
                                                                  .dateFormatWithHour)
                                                              .format(DateTime
                                                                  .parse(model
                                                                      .retailerRolesList[
                                                                          i]
                                                                      .createdAt!)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          model
                                                              .retailerRolesList[
                                                                  i]
                                                              .statusDescription!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppTextStyles.webTableBody.copyWith(
                                                              color: model
                                                                          .retailerRolesList[
                                                                              i]
                                                                          .statusDescription!
                                                                          .toLowerCase() ==
                                                                      "active"
                                                                  ? AppColors
                                                                      .statusVerified
                                                                  : AppColors
                                                                      .statusReject),
                                                        ),
                                                      ),
                                                      Center(
                                                        child:
                                                            PopupMenuWithValue(
                                                                onTap: (int v) {
                                                                  model.action(
                                                                      context,
                                                                      model
                                                                          .retailerRolesList[
                                                                              i]
                                                                          .roleDescription!,
                                                                      model
                                                                          .retailerRolesList[
                                                                              i]
                                                                          .roleName!);
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
                                                                    .view,
                                                                'v': 0
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
