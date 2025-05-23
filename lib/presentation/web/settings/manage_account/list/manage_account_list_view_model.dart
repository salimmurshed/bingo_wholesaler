import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/app_secrets.dart';
import '../../../../../const/server_status_file/manage_account_status.dart';
import '../../../../../const/special_key.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../../../services/auth_service/auth_service.dart';

class ManageAccountViewModel extends BaseViewModel {
  ManageAccountViewModel() {
    callApi();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  RetailerBankList? retailerBankResponse;
  List<RetailerBankListData> retailsBankAccounts = [];
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  String statusForSetting(int j) {
    return statusForSettingCheck('en', retailsBankAccounts[j]);
  }

  callApi() async {
    setBusy(true);
    notifyListeners();
    retailerBankResponse =
        await _repositoryRetailer.getRetailerBankAccountsWeb();

    if (retailerBankResponse!.success!) {
      retailsBankAccounts = retailerBankResponse!.data!;
    } else {
      Utils.toast("App encounter some issues!");
    }
    setBusy(false);
    notifyListeners();
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.manageAccountAddEditView);
  }

  void action(
      BuildContext context, int v, RetailerBankListData retailsBankAccount) {
    if (v == 0) {
      var body = {
        "unique_id": retailsBankAccount.uniqueId,
        "bank_account_type": retailsBankAccount.bankAccountType,
        "currency": retailsBankAccount.currency,
        "bank_account_number": retailsBankAccount.bankAccountNumber,
        "iban": retailsBankAccount.iban,
        "fie_id": retailsBankAccount.fieId
      };
      String b =
          Utils.encrypter.encrypt(jsonEncode(body), iv: SpecialKeys.iv).base64;

      String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");

      context.goNamed(Routes.manageAccountAddEditView,
          queryParameters: {"id": bReplaced});
    }
  }
}
