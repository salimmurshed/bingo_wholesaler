import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data/data_source/bank_account_type.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';
import 'manage_account_list_view_model.dart';

class ManageAccountView extends StatelessWidget {
  const ManageAccountView({super.key, this.page});
  final String? page;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageAccountViewModel>.reactive(
        viewModelBuilder: () => ManageAccountViewModel(),
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
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: 'View Manage Account Retailer',
                          ),
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
                                  h1: 'View Manage Account Retailer',
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
                                            'View Manage Account Retailer',
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
                                                  ))
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
                                                1: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                3: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                4: const FixedColumnWidth(
                                                    130.0),
                                                5: const FixedColumnWidth(
                                                    130.0),
                                                6: const FixedColumnWidth(
                                                    130.0),
                                                7: const FixedColumnWidth(
                                                    130.0),
                                                8: const FixedColumnWidth(
                                                    130.0),
                                                9: const FixedColumnWidth(
                                                    130.0),
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
                                                            .table_accountType,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_bankName,
                                                      ),
                                                      dataCellHd(AppLocalizations
                                                              .of(context)!
                                                          .table_financialInstitution),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_currency,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_accountNumber,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_iban,
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_status,
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
                                                        model
                                                            .retailsBankAccounts
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
                                                          BankInfo.checkBankAccountType(model
                                                                  .retailsBankAccounts[
                                                                      i]
                                                                  .bankAccountType ??
                                                              1),
                                                          isCenter: false),
                                                      dataCell(
                                                        model
                                                            .retailsBankAccounts[
                                                                i]
                                                            .fieName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        "-",
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .retailsBankAccounts[
                                                                i]
                                                            .currency!,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .retailsBankAccounts[
                                                                i]
                                                            .bankAccountNumber!
                                                            .lastChars(10),
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .retailsBankAccounts[
                                                                i]
                                                            .iban!,
                                                        isCenter: false,
                                                      ),
                                                      model
                                                          .retailsBankAccounts[
                                                              i]
                                                          .status!
                                                          .toCardStatusFromInt(
                                                              value: model
                                                                  .statusForSetting(
                                                                      i),
                                                              textStyle: AppTextStyles
                                                                  .statusCardStatus
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14)),
                                                      dataCell(
                                                        model
                                                            .retailsBankAccounts[
                                                                i]
                                                            .updatedAtDate!,
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: FittedBox(
                                                            child:
                                                                PopupMenuWithValue(
                                                                    onTap: (int
                                                                        v) {
                                                                      model.action(
                                                                          context,
                                                                          v,
                                                                          model.retailsBankAccounts[
                                                                              i]);
                                                                    },
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .table_action,
                                                                    color: AppColors
                                                                        .contextMenuTwo,
                                                                    items: [
                                                                  if (model
                                                                          .retailsBankAccounts[
                                                                              i]
                                                                          .status ==
                                                                      0)
                                                                    {
                                                                      "t":
                                                                          "edit",
                                                                      "v": 0
                                                                    },
                                                                  if (model
                                                                          .retailsBankAccounts[
                                                                              i]
                                                                          .status ==
                                                                      0)
                                                                    {
                                                                      "t":
                                                                          "Send for validation",
                                                                      "v": 1
                                                                    },
                                                                  {
                                                                    "t":
                                                                        "Delete",
                                                                    "v": 2
                                                                  }
                                                                ]),
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
                                      if (model.retailsBankAccounts.isEmpty)
                                        Utils.noDataWidget(context),
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
