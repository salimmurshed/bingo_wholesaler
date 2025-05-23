import '../../widgets/cards/loader/loader.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../data/data_source/bank_account_type.dart';
import '../../../data_models/models/component_models/bank_list.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/cards/snack_bar.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'add_manage_account_view_model.dart';

class AddManageAccountView extends StatelessWidget {
  const AddManageAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddManageAccountViewModel>.reactive(
      viewModelBuilder: () => AddManageAccountViewModel(),
      onViewModelReady: (AddManageAccountViewModel model) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          ScreenBasedRetailerBankListData data = ModalRoute.of(context)!
              .settings
              .arguments as ScreenBasedRetailerBankListData;
          if (data.data != null) {
            model.setData(data.data!);
          }
          model.setScreen(data.page);
        } else {
          model.createAddData();
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColorRetailer,
            title: AppBarText(model.appBarTitle),
          ),
          body: model.isBusy
              ? const LoaderWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: AppPaddings.bodyVertical,
                    child: ShadowCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (model.responseMessage.isNotEmpty)
                            SnackBarRepo(
                              success: !model.responseStatus,
                              text: model.responseMessage,
                            ),
                          if (model.responseMessage.isNotEmpty) 20.0.giveHeight,
                          SelectedDropdown<BankAccountTypeModel>(
                              isDisable: model.canEdit,
                              hintStyle: !model.canEdit
                                  ? null
                                  : AppTextStyles.formTitleTextStyleNormal,
                              onChange: (BankAccountTypeModel value) {
                                model.changeBankAccountType(value);
                              },
                              dropdownValue: model.selectedBankAccountType,
                              hintText:
                                  AppLocalizations.of(context)!.bankAccounttype,
                              fieldName: AppLocalizations.of(context)!
                                  .bankAccounttype
                                  .isRequired,
                              //isRequired is an extension if we want to show
                              // require field
                              items: [
                                for (BankAccountTypeModel item
                                    in model.bankAccountType)
                                  DropdownMenuItem<BankAccountTypeModel>(
                                    value: item,
                                    child: Text(item.title!),
                                  )
                              ]),
                          model.bankAccountTypeValidation.validate(),
                          20.0.giveHeight,
                          SelectedDropdown<BankListData>(
                              hintStyle: !model.canEdit
                                  ? null
                                  : AppTextStyles.formTitleTextStyleNormal,
                              isDisable: model.canEdit,
                              onChange: (BankListData value) {
                                model.changeRetailerBankList(value);
                              },
                              dropdownValue: model.selectedBankName,
                              hintText: AppLocalizations.of(context)!.bankName,
                              fieldName: AppLocalizations.of(context)!
                                  .bankName
                                  .isRequired,
                              //isRequired is an extension if we want to show
                              // require field
                              items:
                                  model.retailerBankList.map((BankListData e) {
                                return DropdownMenuItem<BankListData>(
                                  value: e,
                                  child: Text(e.bpName ?? ""),
                                );
                              }).toList()),
                          model.bankNameValidation.validate(),
                          20.0.giveHeight,
                          if (model.selectedBankName != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectedDropdown<String>(
                                  hintStyle: !model.canEdit
                                      ? null
                                      : AppTextStyles.formTitleTextStyleNormal,
                                  isDisable: model.canEdit,
                                  onChange: (String value) {
                                    model.changeCurrency(value);
                                  },
                                  dropdownValue: model.selectedCurrency,
                                  hintText:
                                      AppLocalizations.of(context)!.currency,
                                  fieldName: AppLocalizations.of(context)!
                                      .currency
                                      .isRequired,
                                  //isRequired is an extension if we want to show
                                  // require field
                                  items: [
                                    for (String item in model.currency)
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      )
                                  ],
                                ),
                                model.currencyValidation.validate(),
                                20.0.giveHeight,
                              ],
                            ),
                          NameTextField(
                            hintStyle: !model.canEdit
                                ? null
                                : AppTextStyles.formTitleTextStyleNormal,
                            isNumber: true, enable: !model.canEdit,
                            controller: model.bankAccountController,
                            fieldName: AppLocalizations.of(context)!
                                .bankAccountNumber
                                .isRequired,
                            //isRequired is an extension if we want to show
                            // require field
                          ),
                          model.bankAccountValidation.validate(),
                          20.0.giveHeight,
                          NameTextField(
                            enable: !model.canEdit,
                            isNumber: true,
                            controller: model.ibanController,
                            fieldName: AppLocalizations.of(context)!.iban,
                            //isRequired is an extension if we want to show
                            // require field
                          ),
                          model.ibanValidation.validate(),
                          20.0.giveHeight,
                          model.busy(model.button)
                              ? SizedBox(
                                  height: 98.0,
                                  width: 100.0.wp,
                                  child: const Center(
                                    child: SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        color: AppColors.loader1,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    model.canEdit
                                        ? const SizedBox()
                                        : SubmitButton(
                                            onPressed: () async {
                                              model.isEdit
                                                  ? await model
                                                      .editAccount(context)
                                                  : await model
                                                      .addAccount(context);
                                            },
                                            active: true,
                                            text:
                                                model.appBarTitle.toUpperCase(),
                                            width: 100.0.wp,
                                            height: 45.0,
                                          ),
                                    if (model.isEdit)
                                      if (model.bankDetails!.status == 0)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SubmitButton(
                                            color: AppColors.statusConfirmed,
                                            onPressed:
                                                model.sendForAccountValidation,
                                            active: true,
                                            text: AppLocalizations.of(context)!
                                                .sendAccountValidationText
                                                .toUpperCase(),
                                            width: 100.0.wp,
                                            height: 45.0,
                                          ),
                                        ),
                                  ],
                                )
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
