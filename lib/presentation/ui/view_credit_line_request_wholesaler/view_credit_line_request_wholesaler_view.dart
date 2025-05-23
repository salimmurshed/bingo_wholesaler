import '/const/all_const.dart';
import '/presentation/ui/view_credit_line_request_wholesaler/view_credit_line_request_wholesaler_view_model.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/wholesaler_credit_line_model/wholesaler_credit_line_model.dart';
import '../../widgets/cards/app_bar_text.dart';

class ViewCreditLineRequestWholesalerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewCreditLineRequestWholesalerViewModel>.reactive(
        viewModelBuilder: () => ViewCreditLineRequestWholesalerViewModel(),
        onModelReady: (ViewCreditLineRequestWholesalerViewModel model) => model
            .setCreditLineDetails(ModalRoute.of(context)!.settings.arguments
                as WholesalerCreditLineData),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(
                  AppLocalizations.of(context)!.creditLineDetaileTitle),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: AppPaddings.bodyVertical,
                    // decoration: AppBoxDecoration.shadowBox,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Utils.commonText(
                            AppLocalizations.of(context)!.creditLineInformation,
                            style: AppTextStyles.headerText,
                            needPadding: true),
                        18.0.giveHeight,
                        ShadowCard(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100.0.wp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    NameTextField(
                                      enable: false,
                                      controller: model.customerSinceController,
                                      fieldName: AppLocalizations.of(context)!
                                          .customerSinceDate,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller: model.monthlySalesController,
                                      fieldName: AppLocalizations.of(context)!
                                          .monthlySales,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.averageSalesTicketController,
                                      fieldName: AppLocalizations.of(context)!
                                          .averageSalesTicket,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.visitFrequencyController,
                                      fieldName: AppLocalizations.of(context)!
                                          .visitFrequency,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.recommandedCreditLintController,
                                      fieldName: AppLocalizations.of(context)!
                                          .recommendedCreditLineAmount,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                  ],
                                ),
                              ),
                              12.0.giveHeight,
                            ],
                          ),
                        ),
                        20.0.giveHeight,
                        Utils.commonText(
                            AppLocalizations.of(context)!
                                .retailerCompletedInfomation,
                            style: AppTextStyles.headerText,
                            needPadding: true),
                        18.0.giveHeight,
                        ShadowCard(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100.0.wp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    NameTextField(
                                      enable: false,
                                      controller: model.currencyController,
                                      fieldName: AppLocalizations.of(context)!
                                          .currency,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.monthlyPurchaseController,
                                      fieldName: AppLocalizations.of(context)!
                                          .monthlyPurchase,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.averagePurchaseTicketController,
                                      fieldName: AppLocalizations.of(context)!
                                          .averagePurchaseTicket,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.requestedAmountController,
                                      fieldName: AppLocalizations.of(context)!
                                          .requestedAmount,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                    NameTextField(
                                      enable: false,
                                      controller:
                                          model.visitFrequencyController,
                                      fieldName: AppLocalizations.of(context)!
                                          .visitFrequency,
                                      readOnly: true,
                                    ),
                                    12.0.giveHeight,
                                  ],
                                ),
                              ),
                              12.0.giveHeight,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
