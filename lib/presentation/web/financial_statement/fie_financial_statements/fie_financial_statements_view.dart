import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';
import '/const/web_devices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../../const/special_key.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import 'fie_financial_statements_view_model.dart';

class FieFinancialStatementViewWeb extends StatelessWidget {
  FieFinancialStatementViewWeb({
    super.key,
    this.clientType,
    this.from,
    this.to,
    this.page,
  });

  String? clientType;
  String? from;
  String? to;
  String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FieFinancialStatementViewModel>.reactive(
        viewModelBuilder: () => FieFinancialStatementViewModel(),
        onViewModelReady: (FieFinancialStatementViewModel model) {
          model.callApi(clientType!, int.parse(page!), from, to);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          SecondaryNameAppBar(
                            h1: AppLocalizations.of(context)!.finScreen_header,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    NavButton(
                                      isBottom: clientType!.toLowerCase() ==
                                          "wholesaler",
                                      text: AppLocalizations.of(context)!
                                          .finScreen_tab1,
                                      onTap: () {
                                        model.changeFieClientsStatementScreen(
                                            context, "Wholesaler");
                                      },
                                    ),
                                    NavButton(
                                      isBottom: clientType!.toLowerCase() ==
                                          "retailer",
                                      text: AppLocalizations.of(context)!
                                          .finScreen_tab2,
                                      onTap: () {
                                        model.changeFieClientsStatementScreen(
                                            context, "Retailer");
                                      },
                                    ),
                                    NavButton(
                                      isBottom:
                                          clientType!.toLowerCase() == "fie",
                                      text: AppLocalizations.of(context)!
                                          .finScreen_tab3,
                                      onTap: () {
                                        print(
                                            clientType!.toUpperCase() == "fie");
                                        model.changeFieClientsStatementScreen(
                                            context, "FIE");
                                      },
                                    ),
                                    NavButton(
                                      isBottom:
                                          clientType!.toLowerCase() == "bingo",
                                      text: AppLocalizations.of(context)!
                                          .finScreen_tab4,
                                      onTap: () {
                                        model.changeFieClientsStatementScreen(
                                            context, "Bingo");
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.dividerColor,
                                ),
                                sortedGrandTotalBox(context, model),
                                const Divider(
                                  color: AppColors.dividerColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .search),
                                        ),
                                        10.0.giveWidth,
                                        SizedBox(
                                            width: 100,
                                            height: 70,
                                            child: NameTextField(
                                              hintStyle: AppTextStyles
                                                  .formTitleTextStyle
                                                  .copyWith(
                                                      color: AppColors.ashColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                if (model.busy(model.rFinStatdata))
                                  Utils.bigLoader(),
                                if (!model.busy(model.rFinStatdata))
                                  SingleChildScrollView(
                                    scrollDirection: device == ScreenSize.wide
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                    child: SizedBox(
                                      width: device == ScreenSize.wide
                                          ? 100.0.wp
                                          : 1200,
                                      child: Table(
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        border: TableBorder.all(
                                            color: AppColors.tableHeaderBody),
                                        columnWidths: const {
                                          0: FixedColumnWidth(
                                              100.0), // fixed to 100 width
                                          1: FlexColumnWidth(),
                                          2: FixedColumnWidth(100.0),
                                          3: FixedColumnWidth(200.0),
                                          4: FixedColumnWidth(200.0), //
                                          5: FixedColumnWidth(200.0), //f
                                          6: FixedColumnWidth(
                                              200.0), //fixed to 100 width
                                        },
                                        children: [
                                          TableRow(
                                              decoration: const BoxDecoration(
                                                color:
                                                    AppColors.tableHeaderColor,
                                              ),
                                              children: [
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .table_srNO),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .table_contractAccount),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .currency),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .table_amount),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .table_openBalance),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .status),
                                                dataCellHd(AppLocalizations.of(
                                                        context)!
                                                    .table_action),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                20.0.giveHeight,
                                if (model.rFinStatdata.isEmpty)
                                  model.busy(model.rFinStatdata)
                                      ? const SizedBox()
                                      : SizedBox(
                                          width: 100.0.wp,
                                          height: 200,
                                          child: const Center(
                                            child: Text("No Data"),
                                          ),
                                        ),
                                model.busy(model.rFinStatdata)
                                    ? const SizedBox()
                                    : PaginationWidget(
                                        totalPage: model.rFinStatTotalData,
                                        perPage: model.rFinStatParPage,
                                        startTo: model.rFinStatTo,
                                        startFrom: model.rFinStatFrom,
                                        pageNumber: model.finStatPageNumber,
                                        total: model.rFinTotalData,
                                        onPageChange: (int v) {
                                          model.changePage(v, clientType);
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

  Widget statusBtn({String statusDescription = "", int status = 0}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: status.toStatusFinStatWeb(),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          statusDescription,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 12.0),
        ),
      ),
    );
  }

  SizedBox sortedGrandTotalBox(
      BuildContext context, FieFinancialStatementViewModel model) {
    return SizedBox(
      width: 100.0.wp,
      child: Flex(
        direction: MediaQuery.of(context).size.width > 850
            ? Axis.horizontal
            : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flex(
            direction:
                device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 300,
                child: Text(
                  'View Fie Financial Statements List',
                  style: AppTextStyles.headerText,
                ),
              ),
              10.0.giveWidth,
              Text(
                '${AppLocalizations.of(context)!.grandTotal} = ${model.grandTotalFinancialStatements}',
                style: AppTextStyles.headerText,
              ),
            ],
          ),
          SizedBox(
            height: device == ScreenSize.small ? null : 70,
            child: Flex(
              direction:
                  device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: device == ScreenSize.medium
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                if (device == ScreenSize.small) 10.0.giveHeight,
                SizedBox(
                    height: 55,
                    width: device == ScreenSize.small ? 80.0.wp : null,
                    child: SubmitButton(
                      height: 45,
                      width: device == ScreenSize.small ? 80.0.wp : 120.0,
                      color: AppColors.redColor,
                      onPressed: model.clear,
                      isRadius: false,
                      text: "Clear",
                    )),
                if (device != ScreenSize.small) 10.0.giveWidth,
                if (device == ScreenSize.small) 10.0.giveHeight,
                SizedBox(
                  height: 70,
                  width: device == ScreenSize.small ? 80.0.wp : 200,
                  child: GestureDetector(
                    onTap: () {
                      model.openDateTime(context, model.dateOneController);
                    },
                    child: NameTextField(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      controller: model.dateOneController,
                      enable: false,
                      hintText: DateFormat(SpecialKeys.dateFormatYDM)
                          .format(DateTime.now())
                          .toString(),
                      fieldName: "From Date",
                    ),
                  ),
                ),
                if (device != ScreenSize.small) 10.0.giveWidth,
                if (device == ScreenSize.small) 10.0.giveHeight,
                SizedBox(
                  height: 70,
                  width: device == ScreenSize.small ? 80.0.wp : 200,
                  child: GestureDetector(
                    onTap: () {
                      model.openDateTime(context, model.dateTwoController);
                    },
                    child: NameTextField(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      controller: model.dateTwoController,
                      enable: false,
                      hintText: DateFormat(SpecialKeys.dateFormatYDM)
                          .format(DateTime.now())
                          .toString(),
                      fieldName: "To Date",
                    ),
                  ),
                ),
                if (device != ScreenSize.small) 10.0.giveWidth,
                if (device == ScreenSize.small) 10.0.giveHeight,
                SizedBox(
                  height: 55,
                  width: device == ScreenSize.small ? 80.0.wp : 120.0,
                  child: SubmitButton(
                    color: AppColors.bingoGreen,
                    onPressed: () {
                      model.filterSearch(clientType, context, 1, from, to);
                    },
                    isRadius: false,
                    text: AppLocalizations.of(context)!
                        .submitButton
                        .toUpperCamelCase(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
