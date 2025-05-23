import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../data_models/models/retailer_sale_financial_statements /retailer_sale_financial_statements.dart';
import '../../../../repository/repository_website_sale.dart';

class SaleTransactionViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWebsiteSales _repositorySales =
      locator<RepositoryWebsiteSales>();

  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  RetailerSaleFinancialStatements? data;
  List<RetailerSaleFinancialStatementsData> statements = [];
  String saleId = "";
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;
  bool haveStatements = false;
  prefill(String? id, int page) async {
    setBusy(true);
    notifyListeners();
    saleId = id!;
    data = await _repositorySales.getSaleStatementsWeb(id, page);
    if (data!.success!) {
      haveStatements = true;
      statements = data!.data!.financialStatements!.data!;
      pageNumber = page;
      totalPage = data!.data!.financialStatements!.lastPage!;
      pageTo = data!.data!.financialStatements!.to!;
      pageFrom = data!.data!.financialStatements!.from!;
      dataTotal = data!.data!.financialStatements!.total!;
    } else {
      haveStatements = false;
    }
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    prefill(saleId, page);
    notifyListeners();
  }

  int selectedTabForSaleDetails = 0;

  void changeTabForSaleDetails(int v, BuildContext context) {
    if (v == 1) {
      context.goNamed(Routes.saleTransaction,
          pathParameters: {'id': saleId, 'type': 'view'},
          queryParameters: {'transaction': 'true'});
    } else {
      context.goNamed(Routes.saleDetails,
          pathParameters: {'id': saleId, 'type': 'view'});
    }
    // selectedTabForSaleDetails = v;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.saleScreen, pathParameters: {'page': '1'});
  }
}
