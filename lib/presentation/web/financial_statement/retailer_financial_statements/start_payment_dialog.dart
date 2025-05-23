import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/data_models/models/statement_web_model/statement_web_model.dart';
import 'package:bingo/presentation/widgets/buttons/cancel_button.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../app/locator.dart';
import '../../../../const/app_colors.dart';
import '../../../../const/app_localization.dart';
import '../../../../repository/repository_website_statements.dart';
import 'financial_statements_view.dart';
import 'financial_statements_view_model.dart';

class StartPaymentDialog
    extends StackedView<RetailerFinancialStatementViewModel> {
  const StartPaymentDialog(this.from, this.to, this.page, this.enrollment,
      {super.key});
  final String? from;
  final String? to;
  final String? page;
  final UserTypeForWeb enrollment;
  @override
  Widget builder(BuildContext context,
      RetailerFinancialStatementViewModel viewModel, Widget? child) {
    List<SubgroupData> startPaymentList =
        locator<RepositoryWebsiteStatement>().startPaymentList.value;
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        "Are you sure to make payment for below documents?",
        style: AppTextStyles.dashboardHeadTitle.copyWith(
          fontWeight: AppFontWeighs.semiBold,
        ),
      ),
      content: SizedBox(
        width: 96.0.wp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Scrollbar(
              thumbVisibility: true,
              controller: viewModel.scrollController,
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    30.0.giveHeight,
                    SizedBox(
                      width: 100.0.wp,
                      child: Table(
                        border:
                            TableBorder.all(color: AppColors.tableHeaderBody),
                        columnWidths: enrollment == UserTypeForWeb.retailer
                            ? tableWidthsDialog
                            : widthsWholesaler,
                        children: [
                          mainHeader(context, enrollment, withDetails: false)
                        ],
                      ),
                    ),
                    if (startPaymentList.isEmpty)
                      SizedBox(
                        width: 100.0.wp,
                        height: 200,
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.noData),
                        ),
                      ),
                    if (startPaymentList.isNotEmpty)
                      SizedBox(
                        width: 100.0.wp,
                        // width: 1200,
                        height: 60.0.hp,
                        child: Table(
                          border:
                              TableBorder.all(color: AppColors.tableHeaderBody),
                          columnWidths: enrollment == UserTypeForWeb.retailer
                              ? tableWidthsDialog
                              : widthsWholesaler,
                          children: [
                            for (int j = 0; j < startPaymentList.length; j++)
                              bodyRows(
                                  startPaymentList[j],
                                  1 //model.itemNUmber++
                                  , addForStartPayment: () {
                                viewModel.addForStartPayment(
                                    startPaymentList[j],
                                    emptyToClose: true);
                              }, startPaymentList, enrollment,
                                  withDetails: false),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (viewModel.busy(viewModel.startPaymentList)) Utils.loaderBusy(),
            if (!viewModel.busy(viewModel.startPaymentList))
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (startPaymentList.isNotEmpty)
                    SubmitButton(
                      onPressed: () {
                        viewModel.createPayment(context, from, to, page);
                      },
                      text: AppLocalizations.of(context)!.startPayment,
                    ),
                  CancelButton(
                    onPressed: viewModel.goBack,
                    text: AppLocalizations.of(context)!.cancelButton,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  @override
  RetailerFinancialStatementViewModel viewModelBuilder(BuildContext context) =>
      RetailerFinancialStatementViewModel();
  @override
  void onViewModelReady(RetailerFinancialStatementViewModel viewModel) {}
}
