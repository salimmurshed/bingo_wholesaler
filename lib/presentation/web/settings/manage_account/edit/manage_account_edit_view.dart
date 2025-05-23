import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data/data_source/bank_account_type.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/bank_list.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/utils_folder/validation_text.dart';
import 'manage_account_edit_view_model.dart';

class ManageAccountEditView extends StatelessWidget {
  const ManageAccountEditView({super.key, this.id});
  final String? id;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageAccountEditViewModel>.reactive(
        viewModelBuilder: () => ManageAccountEditViewModel(),
        onViewModelReady: (ManageAccountEditViewModel model) {
          model.checkScreen(id);
        },
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
                      h1: model.isEdit
                          ? 'Update Manage Account Account'
                          : 'Add Manage Account',
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
                              h1: model.isEdit
                                  ? 'Update Manage Account Account'
                                  : 'Add Manage Account',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            model.isEdit
                                                ? 'Update Manage Account Account'
                                                : 'Bank Account',
                                            style: AppTextStyles.headerText,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SubmitButton(
                                              color: AppColors.webButtonColor,
                                              isRadius: false,
                                              height: 40,
                                              width: 80,
                                              onPressed: () {
                                                // Navigator.pop(context);
                                                model.goBack(context);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .viewAll,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 100.0.wp,
                                        child: Wrap(
                                          runSpacing: 20.0,
                                          alignment: WrapAlignment.spaceBetween,
                                          runAlignment:
                                              WrapAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectedDropdown<
                                                      BankAccountTypeModel>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bankAccounttype,
                                                    items: [
                                                      for (BankAccountTypeModel item
                                                          in model
                                                              .bankAccountType)
                                                        DropdownMenuItem<
                                                            BankAccountTypeModel>(
                                                          value: item,
                                                          child:
                                                              Text(item.title!),
                                                        )
                                                    ],
                                                    dropdownValue: model
                                                        .selectedBankAccountType,
                                                    onChange:
                                                        (BankAccountTypeModel?
                                                            value) {
                                                      model
                                                          .changeBankAccountType(
                                                              value!);
                                                    },
                                                  ),
                                                  ValidationText(model
                                                      .bankAccountTypeValidation),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectedDropdown<
                                                      BankListData>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bankName,
                                                    onChange:
                                                        (BankListData value) {
                                                      model
                                                          .changeRetailerBankList(
                                                              value);
                                                    },
                                                    dropdownValue:
                                                        model.selectedBankName,
                                                    items: [
                                                      for (BankListData item
                                                          in model
                                                              .retailerBankList)
                                                        DropdownMenuItem<
                                                            BankListData>(
                                                          value: item,
                                                          child: Text(
                                                              item.bpName!),
                                                        )
                                                    ],
                                                  ),
                                                  ValidationText(
                                                      model.bankNameValidation),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectedDropdown(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: AppLocalizations
                                                            .of(context)!
                                                        .financialInstitution
                                                        .toUpperCamelCase(),
                                                    dropdownValue: model
                                                        .selectedInstitution,
                                                    items: const [],
                                                    onChange: (Object? v) {},
                                                  ),
                                                  ValidationText(model
                                                      .institutionValidation),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 30.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectedDropdown<String>(
                                                    // isDisable: model.canEdit,
                                                    onChange: (String value) {
                                                      model.changeCurrency(
                                                          value);
                                                    },
                                                    dropdownValue:
                                                        model.selectedCurrency,
                                                    hintText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .currency,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .currency
                                                            .isRequired,
                                                    //isRequired is an extension if we want to show
                                                    // require field
                                                    items: [
                                                      for (String item
                                                          in model.currency)
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(item),
                                                        )
                                                    ],
                                                  ),
                                                  ValidationText(
                                                      model.currencyValidation),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    enable: true,
                                                    controller: model
                                                        .bankNumberController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bankAccountNumber,
                                                  ),
                                                ),
                                                ValidationText(model
                                                    .bankAccountValidation),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    enable: true,
                                                    controller:
                                                        model.ibanController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .iban,
                                                  ),
                                                ),
                                                ValidationText(
                                                    model.ibanValidation),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      20.0.giveHeight,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: model.busy(model.isButtonBusy)
                                            ? SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                height: 45,
                                                child: Center(
                                                  child: Utils.webLoader(),
                                                ),
                                              )
                                            : SubmitButton(
                                                isRadius: false,
                                                text: model.isEdit
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .editManageAccount
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .addManageAccount,
                                                color: AppColors.bingoGreen,
                                                onPressed: () {
                                                  model.addManageAccount(
                                                      context);
                                                },
                                                isPadZero: true,
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                height: 45,
                                              ),
                                      )
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
