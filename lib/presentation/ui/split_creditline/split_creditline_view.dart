import '../../widgets/checked_box.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/const/utils.dart';
import '/presentation/ui/split_creditline/split_creditline_view_model.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/app_bar_text.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import '/presentation/widgets/dropdowns/selected_dropdown.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_colors.dart';
import '../../../data_models/active_creditline_model/active_creditline_model.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../widgets/cards/loader/loader.dart';

class SplitCreditlineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplitCreditlineViewModel>.reactive(
        viewModelBuilder: () => SplitCreditlineViewModel(),
        onViewModelReady: (SplitCreditlineViewModel model) => model.setData(
            ModalRoute.of(context)!.settings.arguments
                as ActiveCreditlineModel),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: model.goBack,
              ),
              backgroundColor: AppColors.appBarColorRetailer,
              title: AppBarText((model.isEmptyStore
                  ? AppLocalizations.of(context)!.activeCreditLine
                  : AppLocalizations.of(context)!.editCreditLine)),
            ),
            body: model.isBusy || model.busy(model.selectedBankName)
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      model.unFocusAll(context);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShadowCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectedDropdown(
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                  isDisable: !model.isEmptyStore,
                                  items: [
                                    for (RetailerBankListData item
                                        in model.bankList)
                                      DropdownMenuItem<RetailerBankListData>(
                                        value: item,
                                        child: Text(
                                            "${item.fieName!} (${item.bankAccountNumber!.lastChars(4)})"),
                                      )
                                  ],
                                  onChange: (RetailerBankListData value) {
                                    model.changeRetailerBankList(value);
                                  },
                                  dropdownValue: model.selectedBankName,
                                  fieldName: model.isEmptyStore
                                      ? AppLocalizations.of(context)!
                                          .selectBankAccount
                                      : AppLocalizations.of(context)!
                                          .bankAccount,
                                  hintText: model.isEmptyStore
                                      ? AppLocalizations.of(context)!
                                          .selectBankAccount
                                      : AppLocalizations.of(context)!
                                          .bankAccount,
                                ),
                                if (model.bankSelectionErrorMessage.isNotEmpty)
                                  Text(
                                    model.bankSelectionErrorMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                10.0.giveHeight,
                                NameTextField(
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                  enable: false,
                                  controller:
                                      model.minimumCommittedDateController,
                                  fieldName: AppLocalizations.of(context)!
                                      .minimumCommitmentDateActiveCreditLine,
                                ),
                                10.0.giveHeight,
                                NameTextField(
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                  enable: false,
                                  controller: model.approveAmountController,
                                  fieldName: AppLocalizations.of(context)!
                                      .amountApproved,
                                ),
                                10.0.giveHeight,
                                NameTextField(
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                  enable: false,
                                  controller: model.remainAmountController,
                                  fieldName: AppLocalizations.of(context)!
                                      .remainAmount,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 10.0),
                            child: Text(AppLocalizations.of(context)!
                                .viewRetailerStores),
                          ),
                          if (model.isEmptyStore)
                            for (int i = 0; i < model.stores.length; i++)
                              ShadowCard(
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: AppColors.lightAshColor,
                                        width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.sNo} ${i + 1}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.storeName}: 	${model.stores[i].name}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.location.toUpperCamelCaseSpaced()}: 	${model.stores[i].address}"),
                                      10.0.giveHeight,
                                      NameTextField(
                                        textInputAction: TextInputAction.done,
                                        isNumber: true,
                                        onTap: model.clearValue(i),
                                        focus: model.focusNodes[i],
                                        controller: model.controller[i],
                                        fieldName: AppLocalizations.of(context)!
                                            .amount
                                            .isRequired,
                                      ),
                                      if (model.amountErrorMessage.isNotEmpty)
                                        Text(
                                          model.amountErrorMessage,
                                          style: AppTextStyles.errorTextStyle,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          if (!model.isEmptyStore)
                            for (int j = 0; j < model.data!.stores!.length; j++)
                              ShadowCard(
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: AppColors.lightAshColor,
                                        width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.sNo} ${j + 1}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.storeName}: 	${model.stores[j].name}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.location.toUpperCamelCaseSpaced()}: 	${model.stores[j].address}"),
                                      10.0.giveHeight,
                                      NameTextField(
                                        textInputAction: TextInputAction.done,
                                        isNumber: false,
                                        onTap: model.clearValue(j),
                                        focus: model.focusNodes[j],
                                        controller: model.controller[j],
                                        fieldName: AppLocalizations.of(context)!
                                            .amount,
                                      ),
                                      if (model.amountErrorMessage.isNotEmpty)
                                        Text(
                                          model.amountErrorMessage,
                                          style: AppTextStyles.errorTextStyle,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: model.changeChecked,
                                      child: CheckedBox(
                                        check: model.isChecked,
                                      ),
                                    ),
                                    10.0.giveWidth,
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              model.changeChecked();
                                            },
                                          text:
                                              '${AppLocalizations.of(context)!.termSplitCreditline1} ',
                                          style:
                                              AppTextStyles.formTitleTextStyle,
                                          children: <TextSpan>[
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        model.openTerm(
                                                            "Creditline approval T&T",
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .termAndConditions);
                                                      },
                                                text:
                                                    '${AppLocalizations.of(context)!.termAndConditions},',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blueColor,
                                                    decoration: TextDecoration
                                                        .underline)),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        model.changeChecked();
                                                      },
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .termSplitCreditline3),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        model.openTerm(
                                                            "Credit Line",
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .creditlineTerms);
                                                      },
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .creditlineTerms,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blueColor,
                                                    decoration: TextDecoration
                                                        .underline)),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        model.changeChecked();
                                                      },
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .termSplitCreditline5),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (model.termErrorMessage.isNotEmpty)
                                  Text(
                                    model.termErrorMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                              ],
                            ),
                          ),
                          10.0.giveHeight,
                          Center(
                            child: model.isButtonBusy
                                ? Utils.loaderBusy()
                                : SubmitButton(
                                    onPressed: model.activateCreditLineAdd,
                                    width: 80.0.wp,
                                    height: 45.0,
                                    text: model.isEmptyStore
                                        ? AppLocalizations.of(context)!
                                            .activeCreditLine
                                        : AppLocalizations.of(context)!
                                            .editCreditLine),
                          ),
                          30.0.giveHeight,
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
