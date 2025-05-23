import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/web/settings/store/store_list/store_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../const/utils.dart';
import '../../../../../const/web_devices.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/text_fields/name_text_field.dart';
import '../../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/add_new_with_header.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';

class StoreListView extends StatelessWidget {
  const StoreListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoreListViewModel>.reactive(
        viewModelBuilder: () => StoreListViewModel(),
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
                            h1: AppLocalizations.of(context)!.storeList_header,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: SubmitButton(
                            color: AppColors.bingoGreen,
                            isRadius: false,
                            height: 40,
                            width: 80,
                            onPressed: () {
                              // Navigator.pop(context);
                              model.gotoAddStore(context);
                            },
                            text: AppLocalizations.of(context)!.addStore,
                          ),
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
              // controller: model.scrollController,
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
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
                                  h1: AppLocalizations.of(context)!
                                      .storeList_header,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SubmitButton(
                                    color: AppColors.bingoGreen,
                                    isRadius: false,
                                    height: 40,
                                    width: 80,
                                    onPressed: () {
                                      // Navigator.pop(context);
                                      model.gotoAddStore(context);
                                    },
                                    text:
                                        AppLocalizations.of(context)!.addStore,
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
                                      AddNewWithHeader(
                                        label: AppLocalizations.of(context)!
                                            .storeList_body,
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
                                                    150.0),
                                                2: const FixedColumnWidth(
                                                    150.0),
                                                3: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        250.0)
                                                    : const FlexColumnWidth(),
                                                4: const FixedColumnWidth(
                                                    200.0),
                                                5: const FixedColumnWidth(
                                                    100.0),
                                                6: const FixedColumnWidth(
                                                    200.0), //f
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
                                                              .sNo),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .name,
                                                          isCenter: false),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .city,
                                                          isCenter: false),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .address,
                                                          isCenter: false),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .remark,
                                                          isCenter: false),
                                                      dataCellHd(AppLocalizations
                                                              .of(context)!
                                                          .status
                                                          .toUpperCamelCase()),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_action),
                                                    ]),
                                                for (int i = 0;
                                                    i < model.storeList.length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell("${1 + i}"),
                                                      dataCell(
                                                          model.storeList[i]
                                                              .name!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.storeList[i]
                                                              .city!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.storeList[i]
                                                              .address!,
                                                          isCenter: false),
                                                      dataCell(
                                                          model.storeList[i]
                                                              .remarks!,
                                                          isCenter: false),
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
                                                                        .storeList[
                                                                            i]
                                                                        .status! ==
                                                                    "Active"
                                                                ? AppColors
                                                                    .statusVerified
                                                                : AppColors
                                                                    .statusReject),
                                                        child: Center(
                                                          child: Text(
                                                            model.storeList[i]
                                                                .status!,
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
                                                                          .storeList[
                                                                              i]
                                                                          .uniqueId!,
                                                                      model.storeList[
                                                                          i]);
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
                                                              model.storeList[i]
                                                                          .status ==
                                                                      "Active"
                                                                  ? {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_inactive,
                                                                      'v': 2
                                                                    }
                                                                  : {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_active,
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
