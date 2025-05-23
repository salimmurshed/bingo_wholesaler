import '../../widgets/utils_folder/validation_text.dart';
import '/const/app_extensions/sizes.dart';
import '/const/utils.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_text_styles.dart';
import '../../../data_models/construction_model/sale_edit_data/sale_edit_data.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'sales_edit_screen_view_model.dart';

class EditSalesScreenView extends StatelessWidget {
  const EditSalesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditSalesScreenViewModel>.reactive(
        viewModelBuilder: () => EditSalesScreenViewModel(),
        onViewModelReady: (EditSalesScreenViewModel model) {
          model.setDetails(
              ModalRoute.of(context)!.settings.arguments as SaleEditData);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(AppLocalizations.of(context)!.updateSales),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.bodyVertical,
                child: ShadowCard(
                  child: Column(
                    children: [
                      disableCard(AppLocalizations.of(context)!.retailer,
                          model.retailer),
                      disableCard(AppLocalizations.of(context)!.wholesalerId,
                          model.wholesalerStoreId),
                      disableCard(
                          AppLocalizations.of(context)!.fiaName, model.fieName),
                      disableCard(AppLocalizations.of(context)!.invoiceDate,
                          model.dateOfInvoice),
                      disableCard(AppLocalizations.of(context)!.duePaymentDate,
                          model.dueDate),
                      disableCard(AppLocalizations.of(context)!.currency,
                          model.currency),
                      disableCard(AppLocalizations.of(context)!.amountReserved,
                          model.amount),

                      model.allSalesData.saleType!.toLowerCase() == "2s" &&
                              (model.allSalesData.status != 4 ||
                                  model.allSalesData.status != 7 ||
                                  model.allSalesData.status != 1)
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: NameTextField(
                                isNumber: true,
                                onChanged: (_) {
                                  model.checkAmount();
                                },
                                controller: model.ammountController,
                                fieldName: AppLocalizations.of(context)!.amount,
                              ),
                            )
                          : disableCard(
                              AppLocalizations.of(context)!.currentAmount,
                              model.currentAmount),
                      disableCard(AppLocalizations.of(context)!.salesStep,
                          model.saleType),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NameTextField(
                            onChanged: (_) {
                              model.checkInvoice();
                            },
                            controller: model.invoiceController,
                            fieldName:
                                AppLocalizations.of(context)!.invoiceNumber,
                          ),
                          if (model.invoiceValidation.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ValidationText(model.invoiceValidation),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameTextField(
                              onChanged: (_) {
                                model.checkOrder();
                              },
                              controller: model.orderController,
                              fieldName:
                                  AppLocalizations.of(context)!.orderNumber,
                            ),
                            if (model.orderValidation.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ValidationText(model.orderValidation),
                              ),
                          ],
                        ),
                      ),
                      10.0.giveHeight,
                      // if (model.invChange || model.ordChange)
                      model.isButtonBusy
                          ? SizedBox(
                              height: 45.0,
                              child: Utils.loaderBusy(),
                            )
                          : SubmitButton(
                              active: model.invChange ||
                                  model.ordChange ||
                                  model.amountChange,
                              onPressed: () {
                                if (model.invChange ||
                                    model.ordChange ||
                                    model.amountChange) {
                                  model.update(context);
                                }
                              },
                              height: 45.0,
                              text: AppLocalizations.of(context)!
                                  .update
                                  .toUpperCase(),
                            ),
                      if (!model.isButtonBusy) 10.0.giveHeight,
                      if (!model.isButtonBusy)
                        SubmitButton(
                          color: AppColors.redColor,
                          onPressed: model.backScreen,
                          height: 45.0,
                          text: AppLocalizations.of(context)!
                              .cancelButton
                              .toUpperCase(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget disableCard(String fieldName, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: AppTextStyles.successStyle
                .copyWith(color: AppColors.blackColor),
          ),
          10.0.giveHeight,
          Container(
            width: 100.0.wp,
            decoration: BoxDecoration(
              color: AppColors.borderColors,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 12.0),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
