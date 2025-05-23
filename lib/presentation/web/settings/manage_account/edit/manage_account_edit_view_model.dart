import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/app_secrets.dart';
import '../../../../../const/special_key.dart';
import '../../../../../const/utils.dart';
import '../../../../../data/data_source/bank_account_type.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/bank_list.dart';
import '../../../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../../../services/auth_service/auth_service.dart';

class ManageAccountEditViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  BankAccountTypeModel? selectedBankAccountType;
  BankListData? selectedBankName;
  String? selectedCurrency;
  String? selectedInstitution;
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  List<String> currency = [];
  ScrollController scrollController = ScrollController();
  List<BankAccountTypeModel> bankAccountType = BankInfo.bankAccountType;
  List<BankListData> get retailerBankList =>
      _repositoryComponents.retailerBankList.value;

  bool isButtonBusy = false;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeBankAccountType(BankAccountTypeModel value) {
    selectedBankAccountType = value;
    notifyListeners();
  }

  void changeRetailerBankList(BankListData value) {
    selectedBankName = value;
    selectedCurrency = null;
    currency = value.currency!;
    notifyListeners();
  }

  void changeCurrency(String value) {
    selectedCurrency = value;
    notifyListeners();
  }

  bool isEdit = false;
  String uid = "";
  String bankAccountTypeValidation = "";
  String bankNameValidation = "";
  String currencyValidation = "";
  String bankAccountValidation = "";
  String ibanValidation = "";
  String institutionValidation = "";
  Future<void> checkScreen(String? id) async {
    await _repositoryComponents.getRetailerBankList();

    isEdit = id == null ? false : true;
    if (id != null) {
      String b = id.replaceAll("()", "/").replaceAll(")(", "+");
      var bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
      RetailerBankListData bankInfo =
          RetailerBankListData.fromJson(jsonDecode(bb));
      Utils.fPrint('idididid');
      Utils.fPrint(id);
      Utils.fPrint(bb);
      uid = bankInfo.uniqueId!;
      Utils.fPrint('bankInfo.uniqueId');
      Utils.fPrint(bankInfo.uniqueId);
      ibanController.text = bankInfo.iban!;
      bankNumberController.text = bankInfo.bankAccountNumber!;
      selectedBankAccountType = bankAccountType
          .firstWhere((element) => element.id == bankInfo.bankAccountType);
      selectedBankName = retailerBankList
          .firstWhere((element) => element.bankUniqueId == bankInfo.fieId);
      currency = selectedBankName!.currency!;
      selectedCurrency = bankInfo.currency!;

      notifyListeners();
    }
  }

  // void addManageAccount(BuildContext context) {
  //   isEdit ? editAccount(context) : addAccount(context);
  // }

  Future<void> addManageAccount(BuildContext context) async {
    setBusyForObject(isButtonBusy, true);
    notifyListeners();
    if (selectedBankAccountType == null) {
      bankAccountTypeValidation =
          AppLocalizations.of(context)!.bankAccountTypeValidationText;
    } else {
      bankAccountTypeValidation = "";
    }
    if (selectedBankName == null) {
      bankNameValidation = AppLocalizations.of(context)!.bankNameValidationText;
    } else {
      bankNameValidation = "";
    }
    if (ibanController.text.isEmpty) {
      ibanValidation = AppLocalizations.of(context)!.ibanValidationText;
    } else {
      ibanValidation = "";
    }
    if (selectedInstitution == null) {
      institutionValidation = "Need to select institution name";
    } else {
      institutionValidation = "";
    }
    // if (selectedBankName != null) {
    if (selectedCurrency == null) {
      currencyValidation = AppLocalizations.of(context)!.currencyValidationText;
    } else {
      currencyValidation = "";
    }
    // }
    if (bankNumberController.text.isEmpty) {
      bankAccountValidation =
          AppLocalizations.of(context)!.bankAccountValidationText;
    } else if (bankNumberController.text.length < 8) {
      bankAccountValidation =
          AppLocalizations.of(context)!.bankAccountLengthValidationText;
    } else {
      bankAccountValidation = "";
    }

    notifyListeners();
    if (selectedBankAccountType != null &&
        selectedBankName != null &&
        selectedCurrency != null &&
        bankNumberController.text.isNotEmpty &&
        bankNumberController.text.length >= 8) {
      var body = {
        "bank_account_type": selectedBankAccountType!.id.toString(),
        "bank_name": selectedBankName!.bpName,
        "bank_unique_id": selectedBankName!.bankUniqueId,
        "currency": selectedCurrency,
        "bank_account_number": bankNumberController.text,
        "iban": ibanController.text,
      };
      if (isEdit) {
        body.addAll({"unique_id": uid});
      }

      await _repositoryRetailer.addRetailerBankAccountsWeb(body).then((value) {
        // endResponseMessage(value, context);
        setBusyForObject(isButtonBusy, false);

        notifyListeners();
      });
    } else {
      setBusyForObject(isButtonBusy, false);

      notifyListeners();
    }
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.manageAccountView, pathParameters: {
      'page': "1",
    });
  }
}
