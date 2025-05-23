import 'dart:convert';

import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../const/app_localization.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/statement_list_doc_model/statement_list_doc_model.dart';
import '../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../repository/repository_website_statements.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../widgets/alert/confirmation_dialog.dart';
import 'package:universal_html/html.dart' as html;

class StatementSalesDetailsModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _nav = locator<NavigationService>();
  final RepositoryWebsiteStatement _repositoryStatement =
      locator<RepositoryWebsiteStatement>();
  String get language => _authService.selectedLanguageCode;
  String contractAccount(String v) {
    List<String> data = v.replaceAll(")", "").split("(");
    if (data.length == 3) {
      return "${data[0]} (${data[1]}) (${data[2].lastChars(10)})";
    } else if (data.length == 1) {
      return data[0];
    } else {
      return "${data[0]} (${data[1].lastChars(10)})";
    }
  }

  String saleId = "";
  String invoice = "";
  int page = 0;
  Future<void> setId(StatementListToDetailsArguments data) async {
    saleId = data.saleId;
    invoice = data.invoice;
    setBusy(true);
    notifyListeners();
    page = 0;
    await getSalesFinancialStatement();
    setBusy(false);
    notifyListeners();
  }

  List<FinancialStatementsDetails> allData = [];
  bool hasNextPage = false;
  bool isLoaderBusy = false;
  Future getSalesFinancialStatement() async {
    page++;
    if (page == 1) {
      setBusy(true);
    } else {
      isLoaderBusy = true;
    }
    notifyListeners();
    await _repositoryStatement.getRetailerWholesalerFinancialDocuments(
        page, saleId);

    if (page == 1) {
      allData = _repositoryStatement.retailerSaleFinancialStatementsList;
    } else {
      allData.addAll(_repositoryStatement.retailerSaleFinancialStatementsList);
    }
    hasNextPage =
        _repositoryStatement.retailerWholesalerFinancialDocumentsHasNextPage;
    if (page == 1) {
      setBusy(false);
    } else {
      isLoaderBusy = false;
    }
    notifyListeners();
  }

  Future<void> createPayment(BuildContext context, String? id) async {
    bool confirm = await _nav.animatedDialog(ConfirmationDialog(
      title: "Do you really want do create payment?",
      submitButtonText: AppLocalizations.of(context)!.confirmButton,
    ));
    if (confirm) {
      setBusyForObject(saleId, true);
      notifyListeners();
      ResponseMessages? responseBody =
          await _repositoryStatement.createPaymentOnWebsite(id!);
      if (responseBody!.success!) {
        if (context.mounted) {
          _repositoryStatement.clear();
          setBusyForObject(saleId, false);
          _nav.pop(true);
          Utils.toast(responseBody.message!);
        }
      }
      setBusyForObject(saleId, false);
      notifyListeners();
    }
  }
}

class StatementListToDetailsArguments {
  String saleId;
  String invoice;
  StatementListToDetailsArguments({this.saleId = "", this.invoice = ""});
}
