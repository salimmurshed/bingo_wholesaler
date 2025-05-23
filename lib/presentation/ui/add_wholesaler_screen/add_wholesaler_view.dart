import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/data_models/construction_model/wholesaler_data.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';
import '../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../data_models/models/component_models/partner_with_currency_list.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'add_wholesaler_view_model.dart';

class AddWholesalerView extends StatelessWidget {
  const AddWholesalerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddWholesalerViewModel>.reactive(
      onViewModelReady: (AddWholesalerViewModel model) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          model.setDetails(
              ModalRoute.of(context)!.settings.arguments as WholesalersData);
        }
      },
      viewModelBuilder: () => AddWholesalerViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColorRetailer,
            title: AppBarText(
                AppLocalizations.of(context)!.addWholesaler.toUpperCase()),
          ),
          body: model.isBusy
              ? const LoaderWidget()
              : SingleChildScrollView(
                  child: Container(
                    margin: AppMargins.cardBody,
                    padding: AppPaddings.screenARDSWidgetInnerPadding,
                    decoration: AppBoxDecoration.shadowBox,
                    child: Form(
                      key: model.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          model.isNew
                              ? SelectedDropdown<WholesalerData>(
                                  items: [
                                    for (var i = 0;
                                        i < model.sortedWholsaler.length;
                                        i++)
                                      DropdownMenuItem<WholesalerData>(
                                        value: model.sortedWholsaler[i],
                                        child: Text(model.sortedWholsaler[i]
                                            .wholesalerName!),
                                      )
                                  ],
                                  dropdownValue: model.selectWholesaler,
                                  onChange: (WholesalerData? newValue) {
                                    model.changeSelectWholesaler(newValue!);
                                  },
                                  hintText: AppLocalizations.of(context)!
                                      .selectWholeSaler,
                                  fieldName: AppLocalizations.of(context)!
                                      .selectWholeSaler
                                      .isRequired,
                                )
                              : Center(
                                  child: Text(
                                    model.wholesaler!.wholesalerName!,
                                    style: AppTextStyles.dashboardHeadTitle,
                                  ),
                                ),
                          if (model.wholesalerValidationText.isNotEmpty)
                            ValidationText(model.wholesalerValidationText),
                          20.0.giveHeight,
                          SelectedDropdown<String>(
                            fieldName: AppLocalizations.of(context)!
                                .selectCurrency
                                .isRequired,
                            hintText:
                                AppLocalizations.of(context)!.selectCurrency,
                            items: [
                              for (var i = 0; i < model.allCurrency.length; i++)
                                DropdownMenuItem<String>(
                                  value: model.allCurrency[i],
                                  child: Text(model.allCurrency[i]),
                                )
                            ],
                            dropdownValue: model.selectCurrency,
                            onChange: (String value) {
                              model.changeSelectCurrency(value);
                            },
                          ),
                          if (model.currencyValidationText.isNotEmpty)
                            ValidationText(model.currencyValidationText),
                          20.0.giveHeight,
                          NameTextField(
                            isNumber: true,
                            fieldName: AppLocalizations.of(context)!
                                .monthlyPurchase
                                .isRequired,
                            controller: model.purchaseController,
                          ),
                          if (model.mPValidationText.isNotEmpty)
                            ValidationText(model.mPValidationText),
                          20.0.giveHeight,
                          NameTextField(
                            isNumber: true,
                            fieldName: AppLocalizations.of(context)!
                                .averagePurchaseTicket
                                .isRequired,
                            controller: model.averageTicketController,
                          ),
                          if (model.aPValidationText.isNotEmpty)
                            ValidationText(model.aPValidationText),
                          20.0.giveHeight,
                          SelectedDropdown<VisitFrequentListModel>(
                            style: AppTextStyles.formFieldTextStyle,
                            items: [
                              for (var i = 0;
                                  i < model.visitFrequentlyList.length;
                                  i++)
                                DropdownMenuItem<VisitFrequentListModel>(
                                  value: model.visitFrequentlyList[i],
                                  child: Text(StatusFile.visitFrequent(
                                      model.language,
                                      model.visitFrequentlyList[i].id!)),
                                )
                            ],
                            dropdownValue: model.visitFrequency,
                            onChange: (VisitFrequentListModel? newValue) {
                              model.changeVisitFrequency(newValue!);
                            },
                            hintText:
                                AppLocalizations.of(context)!.visitFrequency,
                            fieldName: AppLocalizations.of(context)!
                                .visitFrequency
                                .isRequired,
                          ),
                          if (model.vFValidationText.isNotEmpty)
                            ValidationText(model.vFValidationText),
                          20.0.giveHeight,
                          NameTextField(
                            isNumber: true,
                            fieldName: AppLocalizations.of(context)!
                                .requestedAmount
                                .isRequired,
                            controller: model.amountController,
                          ),
                          if (model.rAValidationText.isNotEmpty)
                            ValidationText(model.rAValidationText),
                          30.0.giveHeight,
                          SubmitButton(
                            onPressed: () {
                              model.isNew
                                  ? model.addWholesaler(context)
                                  : model.updateWholesaler(context);
                            },
                            width: 100.0.wp,
                            text: model.submitButton.toUpperCase(),
                            height: 45.0,
                          ),
                          if (!model.isNew) 20.0.giveHeight,
                          if (!model.isNew)
                            SubmitButton(
                              onPressed: () {
                                model.removeCreditLineInformation(context);
                              },
                              width: 100.0.wp,
                              color: AppColors.statusReject,
                              text: AppLocalizations.of(context)!
                                  .remove
                                  .toUpperCase(),
                              height: 45.0,
                            ),
                          40.0.giveHeight,
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
