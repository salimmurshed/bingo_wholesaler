import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:flutter/cupertino.dart';

import '../../../../const/app_localization.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/models/statement_list_doc_model/statement_list_doc_model.dart';
import '../../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../widgets/alert/neon_widgets.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '/const/all_const.dart';
import '/const/web_devices.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'financial_statements_view_model.dart';

import 'package:bingo/const/app_extensions/status.dart';
import 'package:intl/intl.dart';
import '../../../../const/special_key.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/checked_box.dart';

part 'parts.dart';

class RetailerFinancialStatementViewWeb extends StatelessWidget {
  RetailerFinancialStatementViewWeb({
    super.key,
    this.page,
    this.from,
    this.to,
    this.filter,
  });

  String? page;
  String? from;
  String? to;
  String? filter;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerFinancialStatementViewModel>.reactive(
        viewModelBuilder: () => RetailerFinancialStatementViewModel(),
        onViewModelReady: (RetailerFinancialStatementViewModel model) {
          model.callApi(int.parse(page!), from, to);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: body(model, context, page, from, to),
                ),
                if (!model.isBusy)
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    excludeHeaderSemantics: false,
                    pinned: true,
                    snap: true,
                    floating: true,
                    stretch: true,
                    backgroundColor: AppColors.backgroundSecondary,
                    expandedHeight: 1.0,
                    bottom: PreferredSize(
                      preferredSize: Size(0, 85),
                      child: SizedBox(
                        // titlePadding: EdgeInsets.zero,
                        // centerTitle: true,
                        // collapseMode: CollapseMode.parallax,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            border: TableBorder.all(
                                color: AppColors.tableHeaderBody),
                            columnWidths:
                                model.enrollment == UserTypeForWeb.retailer
                                    ? tableWidthsForMain
                                    : widthsWholesalerMain,
                            children: [
                              mainHeader(context, model.enrollment,
                                  isDetailsScreen: false),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!model.isBusy)
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < model.rFinStat.length; i++)
                              Table(
                                // columnWidths: widthsForHeader,
                                children: [
                                  TableRow(
                                    children: [
                                      Table(
                                        children: [
                                          subgroupMetadata(
                                              model.rFinStat[i], model,
                                              isRetailer: model.enrollment ==
                                                  UserTypeForWeb.retailer),
                                        ],
                                      )
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Table(
                                        border: TableBorder.all(
                                            color: AppColors.tableHeaderBody),
                                        columnWidths: model.enrollment ==
                                                UserTypeForWeb.retailer
                                            ? tableWidthsForMain
                                            : widthsWholesalerMain,
                                        children: [
                                          for (int j = 0;
                                              j <
                                                  model.rFinStat[i]
                                                      .subgroupData!.length;
                                              j++)
                                            bodyRows(
                                                model.rFinStat[i]
                                                    .subgroupData![j],
                                                model.itemNUmber++,
                                                addForStartPayment: () {
                                                  model.addForStartPayment(model
                                                      .rFinStat[i]
                                                      .subgroupData![j]);
                                                },
                                                model.startPaymentList,
                                                model.enrollment,
                                                isDetailsScreen: false,
                                                group: model.myGroup,
                                                onPressed: () {
                                                  model.gotoDetails(
                                                      context,
                                                      model
                                                          .rFinStat[i]
                                                          .subgroupData![j]
                                                          .saleUniqueId!,
                                                      page,
                                                      from,
                                                      to);
                                                })
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            if (model.enrollment == UserTypeForWeb.retailer)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.0.giveHeight,
                                  Row(
                                    children: [
                                      SubmitButton(
                                        onPressed: () {
                                          model.goForStartPayment(
                                              from, to, page);
                                        },
                                        height: 45,
                                        width: 100,
                                        isRadius: false,
                                        text: "Start Payment",
                                      ),
                                      Text(
                                        "with the selected document only",
                                        style: AppTextStyles.buttonText
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  if (model.startPaymentValidation.isNotEmpty)
                                    Utils.validationText(
                                        model.startPaymentValidation),
                                ],
                              ),
                            20.0.giveHeight,
                            footer(model, context, page, from, to),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
