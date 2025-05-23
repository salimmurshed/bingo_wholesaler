import 'dart:convert';

import '/repository/repository_retailer.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data/data_source/bank_account_type.dart';
import '../../../data_models/enums/manage_account_from_pages.dart';
import '../../../data_models/models/component_models/bank_list.dart';
import '../../../data_models/models/failure.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';

class AddManageAccountViewModel extends BaseViewModel {
  AddManageAccountViewModel() {
    getRetailerBankList();
    print('retailerBankList');
    print(jsonEncode(retailerBankList));
  }

  //services
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();

//services variables
  List<BankListData> retailerBankList = [];

  //local variables
  List<String> currency = [];
  List<BankAccountTypeModel> bankAccountType = BankInfo.bankAccountType;
  bool canEdit = false;

  BankAccountTypeModel? selectedBankAccountType;
  BankListData? selectedBankName;
  String? selectedCurrency;

  TextEditingController bankAccountController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  String bankAccountTypeValidation = "";
  String bankNameValidation = "";
  String currencyValidation = "";
  String bankAccountValidation = "";
  String ibanValidation = "";
  RetailerBankListData? bankDetails;
  bool isEdit = false;
  String appBarTitle = AppLocalizations.of(activeContext)!.addManageAccount;
  String responseMessage = "";
  bool responseStatus = false;
  ManageAccountFromPages screenFrom = ManageAccountFromPages.home;

  void setScreen(ManageAccountFromPages v) {
    screenFrom = v;
    notifyListeners();
  }

  Future<void> getRetailerBankList() async {
    setBusy(true);
    notifyListeners();
    print('jbuhguguguhbuh');
    await _repositoryComponents.getRetailerBankList();
    setBusy(false);
    notifyListeners();
  }

  void setData(RetailerBankListData arguments) {
    if (arguments.status == 1 || arguments.status == 3) {
      canEdit = true;
    } else {
      canEdit = false;
    }
    bankDetails = arguments;
    bankAccountController.text = arguments.bankAccountNumber!;
    ibanController.text = arguments.iban!;
    selectedBankAccountType = bankAccountType
        .firstWhere((element) => element.id == arguments.bankAccountType!);
    retailerBankList = _repositoryComponents.retailerBankList.value;
    selectedBankName = retailerBankList.firstWhere((element) =>
        element.bpName!.toLowerCase() == arguments.fieName!.toLowerCase());
    print('retailerBankList[0].bpName');
    print(retailerBankList[0].bpName);
    print(retailerBankList[1].bpName);
    print(arguments.fieName!);
    if (selectedBankName != null) {
      selectedCurrency = null;
      currency = selectedBankName!.currency!;
      selectedCurrency = selectedBankName!.currency!
          .firstWhere((element) => element == arguments.currency);
    }
    appBarTitle = AppLocalizations.of(activeContext)!.editManageAccount;
    isEdit = true;
    notifyListeners();
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

  bool button = false;

  Future<void> addAccount(context) async {
    if (selectedBankAccountType == null) {
      bankAccountTypeValidation =
          AppLocalizations.of(activeContext)!.bankAccountTypeValidationText;
    } else {
      bankAccountTypeValidation = "";
    }
    if (selectedBankName == null) {
      bankNameValidation =
          AppLocalizations.of(activeContext)!.bankNameValidationText;
    } else {
      bankNameValidation = "";
    }
    if (selectedBankName != null) {
      if (selectedCurrency == null) {
        currencyValidation =
            AppLocalizations.of(activeContext)!.currencyValidationText;
      } else {
        currencyValidation = "";
      }
    }
    if (bankAccountController.text.isEmpty) {
      bankAccountValidation =
          AppLocalizations.of(activeContext)!.bankAccountValidationText;
    } else if (bankAccountController.text.length < 8) {
      bankAccountValidation =
          AppLocalizations.of(activeContext)!.bankAccountLengthValidationText;
    } else {
      bankAccountValidation = "";
    }

    notifyListeners();

    setBusyForObject(button, true);
    notifyListeners();
    if (selectedBankAccountType != null &&
        selectedBankName != null &&
        selectedCurrency != null &&
        bankAccountController.text.isNotEmpty &&
        bankAccountController.text.length >= 8) {
      var body = {
        "bank_account_type": selectedBankAccountType!.id.toString(),
        "bank_name": selectedBankName!.bpName,
        "bank_unique_id": selectedBankName!.bankUniqueId,
        "currency": selectedCurrency,
        "bank_account_number": bankAccountController.text,
        "iban": ibanController.text,
      };

      await _repositoryRetailer.addRetailerBankAccounts(body).then((value) {
        endResponseMessage(value, context);
        setBusyForObject(button, false);
        notifyListeners();
      });
    } else {
      setBusyForObject(button, false);
      notifyListeners();
    }
  }

  Future<void> editAccount(context) async {
    notifyListeners();
    if (selectedBankAccountType == null) {
      bankAccountTypeValidation =
          AppLocalizations.of(activeContext)!.bankAccountTypeValidationText;
    } else {
      bankAccountTypeValidation = "";
    }
    if (selectedBankName == null) {
      bankNameValidation =
          AppLocalizations.of(activeContext)!.bankNameValidationText;
    } else {
      bankNameValidation = "";
    }
    if (selectedBankName != null) {
      if (selectedCurrency == null) {
        currencyValidation =
            AppLocalizations.of(activeContext)!.currencyValidationText;
      } else {
        currencyValidation = "";
      }
    }

    if (bankAccountController.text.isEmpty) {
      bankAccountValidation =
          AppLocalizations.of(activeContext)!.bankAccountValidationText;
    } else if (bankAccountController.text.length < 8) {
      bankAccountValidation =
          AppLocalizations.of(activeContext)!.bankAccountLengthValidationText;
    } else {
      bankAccountValidation = "";
    }
    // if (ibanController.text.isEmpty) {
    //   ibanValidation = AppLocalizations.of(activeContext)!.ibanValidationText;
    // } else if (ibanController.text.length < 8) {
    //   ibanValidation =
    //       AppLocalizations.of(activeContext)!.ibanLengthValidationText;
    // } else {
    //   ibanValidation = "";
    // }
    notifyListeners();
    if (selectedBankAccountType != null &&
        selectedBankName != null &&
        selectedCurrency != null &&
        bankAccountController.text.isNotEmpty &&
        // ibanController.text.isNotEmpty &&
        // ibanController.text.length >= 8 &&
        bankAccountController.text.length >= 8) {
      setBusyForObject(button, true);
      var body = {
        "unique_id": bankDetails!.uniqueId!,
        "bank_account_type": selectedBankAccountType!.id.toString(),
        "bank_name": selectedBankName!.bpName,
        "bank_unique_id": selectedBankName!.bankUniqueId,
        "currency": selectedCurrency,
        "bank_account_number": bankAccountController.text,
        "iban": ibanController.text,
      };
      await _repositoryRetailer.addRetailerBankAccounts(body).then((value) {
        endResponseMessage(value, context);
        setBusyForObject(button, false);
        notifyListeners();
      });
    } else {
      setBusyForObject(button, false);
      notifyListeners();
    }
  }

  void endResponseMessage(Failure failure, context) async {
    responseMessage = failure.message;
    responseStatus = failure.status;
    notifyListeners();
    if (failure.status) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // _navigationService.pop();
        _repositoryComponents.onChangedTabToManageAccount(context);
        if (screenFrom == ManageAccountFromPages.home) {
          _navigationService.pop();
        } else if (screenFrom == ManageAccountFromPages.creditline) {
          _navigationService
            ..pop()
            ..pop()
            ..pop();
        }
      });
    }
    await Future.delayed(const Duration(seconds: 3));
    responseMessage = "";
    notifyListeners();
  }

  void sendForAccountValidation() async {
    var body = {
      "unique_id": bankDetails!.uniqueId!,
      "status": "3",
    };

    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.accountValidation(body);
    setBusy(false);
    notifyListeners();
    _navigationService.pop();
  }

  void createAddData() {
    retailerBankList = _repositoryComponents.retailerBankList.value;
    notifyListeners();
  }
}
