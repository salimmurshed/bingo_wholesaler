import 'dart:convert';

import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../const/app_localization.dart';
import '../const/connectivity.dart';
import '../const/utils.dart';
import '../data_models/enums/user_type_for_web.dart';
import '../data_models/models/component_models/response_model.dart';
import '../data_models/models/retailer_fiancial_statement_model/retailer_fiancial_statement_model.dart';
import '../data_models/models/retailer_sale_financial_statements /retailer_sale_financial_statements.dart';
import '../data_models/models/retailer_sale_financial_statements /v2.dart';
import '../data_models/models/statement_list_doc_model/statement_list_doc_model.dart';
import '../data_models/models/statement_web_model/statement_web_model.dart';
import '../main.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';
import '../services/storage/db.dart';

@lazySingleton
class RepositoryWebsiteStatement with ListenableServiceMixin {
  final WebService _webService = locator<WebService>();

  RepositoryRetailer() {
    listenToReactiveValues([startPaymentList, rFinStatdata]);
  }

  // bool get isRetailer => _auth.isRetailer.value;

  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  final UserTypeForWeb clientType =
      (prefs.getString(DataBase.userType))!.toLowerCase() == "retailer"
          ? UserTypeForWeb.retailer
          : (prefs.getString(DataBase.userType))!.toLowerCase() == "wholesaler"
              ? UserTypeForWeb.wholesaler
              : UserTypeForWeb.fie;

  int intNumber = 0;
  int rFinStatPage = 0;
  int rFinStatTo = 0;
  int rFinStatFrom = 0;
  int currentPage = 0;
  ReactiveValue<List<Subgroups>> rFinStatdata =
      ReactiveValue<List<Subgroups>>([]);
  StatementWebModel financialStatementsData = StatementWebModel();

  Future getRetailerWholesalerFinancialStatements(
      int page, List<String> date, String dayDifference) async {
    var d = dayDifference == "0:00:00.000000"
        ? {"grouping_strategy": !isDay ? "WEEKDAYS" : "DAY_RANGE"}
        : {
            "from_date": date[0],
            "to_date": date[1],
            "grouping_strategy": !isDay ? "WEEKDAYS" : "DAY_RANGE"
          };
    try {
      String url = enrollment == UserTypeForWeb.retailer
          ? NetworkUrls.retailerFinancialStatementsListV2
          : NetworkUrls.wholesalerFinancialStatementsListV2;

      Response response = await _webService.postRequest("$url?page=$page", d);
      print('elementselements111');
      print(jsonDecode(response.body)['data']['info']
          ['selected_strategy_subgroups']);
      StatementWebModel responseData =
          StatementWebModel.fromJson(jsonDecode(response.body));
      if (kIsWeb) {
        financialStatementsData = responseData;
        rFinStatdata.value.clear();
        rFinStatdata.value = responseData.data!.financialStatements!.subgroups!;
        rFinStatFrom = responseData.data!.from!;
        rFinStatTo = responseData.data!.to!;
        rFinStatPage = responseData.data!.lastPage!;
      } else {
        financialStatementsData = responseData;
      }

      notifyListeners();
    } catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  Future getFieFinancialStatements(int page, List<String> date,
      String dayDifference, String? userType) async {
    var d = dayDifference == "0:00:00.000000"
        ? {"grouping_strategy": !isDay ? "WEEKDAYS" : "DAY_RANGE"}
        : {
            "from_date": date[0],
            "to_date": date[1],
            "grouping_strategy": !isDay ? "WEEKDAYS" : "DAY_RANGE"
          };
    try {
      String url = userType == "retailer"
          ? NetworkUrls.fieRetailerStatementList
          : userType == "wholesaler"
              ? NetworkUrls.fieWholesalerStatementList
              : userType == "fie"
                  ? NetworkUrls.fieFieStatementList
                  : NetworkUrls.fieBingoStatementList;
      Utils.fPrint('NetworkUrlsNetworkUrls');
      Utils.fPrint(d.toString());
      Response response = await _webService.postRequest("$url?page=$page", d);

      StatementWebModel responseData =
          StatementWebModel.fromJson(jsonDecode(response.body));
      print(responseData.toJson());
      if (kIsWeb) {
        // financialStatementsData = responseData;
        // rFinStatdata.value =
        //     financialStatementsData.data!.financialStatements!.data!;
        // rFinStatFrom = responseData.data!.financialStatements!.from!;
        // rFinStatTo = responseData.data!.financialStatements!.to!;
        // rFinStatPage = responseData.data!.financialStatements!.lastPage!;
      }

      notifyListeners();
    } catch (p) {
      Utils.fPrint(p.toString());
    }
  }

  int rSaleFinStatPage = 0;
  int rSaleFinStatTo = 0;
  int rSaleFinStatFrom = 0;
  int rSaleFinStatTotal = 0;
  List<FinancialStatementsDetails> retailerSaleFinancialStatementsList = [];
  FinancialStatementsDetailsGroupMetadata?
      financialStatementsDetailsGroupMetadata;
  bool retailerWholesalerFinancialDocumentsHasNextPage = false;
  Future getRetailerWholesalerFinancialDocuments(
    int page,
    String? saleUniqueId,
  ) async {
    String url = clientType == UserTypeForWeb.retailer
        ? NetworkUrls.retailerSaleFinancialStatementsListV2
        : NetworkUrls.wholesalerSaleFinancialStatementsListV2;
    try {
      Response response = await _webService
          .postRequest("$url?page=$page", {"sale_unique_id": saleUniqueId});
      print('response.body');
      print(response.body);
      StatementListDocModel responseData =
          StatementListDocModel.fromJson(jsonDecode(response.body));
      if (kIsWeb) {
        retailerSaleFinancialStatementsList =
            responseData.data!.financialStatements ?? [];
        financialStatementsDetailsGroupMetadata =
            responseData.data!.groupMetadata!;
        rSaleFinStatFrom = responseData.data!.from!;
        rSaleFinStatTo = responseData.data!.to!;
        rSaleFinStatPage = responseData.data!.lastPage!;
        rSaleFinStatTotal = responseData.data!.total!;
      } else {
        retailerSaleFinancialStatementsList =
            responseData.data!.financialStatements ?? [];
        if (responseData.data!.nextPageUrl!.isNotEmpty) {
          retailerWholesalerFinancialDocumentsHasNextPage = true;
        } else {
          retailerWholesalerFinancialDocumentsHasNextPage = false;
        }
      }

      notifyListeners();
    } catch (p) {
      print(p);
    }
  }

  Future getFieFinancialDocuments(int page, String? saleUniqueId,
      List<String> date, Duration dayDifference, String userType) async {
    print('userTypeuserType');
    print(userType);
    String url = userType == "retailer"
        ? NetworkUrls.fieRetailerSaleStatementList
        : userType == "wholesaler"
            ? NetworkUrls.fieWholesalerSaleStatementList
            : userType == "fie"
                ? NetworkUrls.fieFieSaleStatementList
                : NetworkUrls.fieBingoSaleStatementList;
    try {
      Response response = await _webService
          .postRequest("$url?page=$page", {"sale_unique_id": saleUniqueId});
      StatementListDocModel responseData =
          StatementListDocModel.fromJson(jsonDecode(response.body));
      if (kIsWeb) {
        retailerSaleFinancialStatementsList =
            responseData.data!.financialStatements ?? [];
        financialStatementsDetailsGroupMetadata =
            responseData.data!.groupMetadata!;
        rSaleFinStatFrom = responseData.data!.from!;
        rSaleFinStatTo = responseData.data!.to!;
        rSaleFinStatPage = responseData.data!.lastPage!;
        rSaleFinStatTotal = responseData.data!.total!;
      }

      notifyListeners();
    } catch (p) {
      print(p);
    }
  }

  bool isDay = false;
  void changeWeekOrDay(bool v) {
    isDay = v;
    notifyListeners();
  }

  ReactiveValue<List<SubgroupData>> startPaymentList =
      ReactiveValue<List<SubgroupData>>([]);
  void addForStartPayment(SubgroupData data) {
    var existingItem = startPaymentList.value
        .any((itemToCheck) => itemToCheck.documentId == data.documentId);
    if (existingItem) {
      startPaymentList.value.remove(data);
    } else {
      startPaymentList.value.add(data);
    }
    notifyListeners();
  }

  Future<ResponseMessages?> createPaymentOnWebsite(String id) async {
    bool connection = await checkConnectivity();
    if (connection) {
      var body = {"sale_unique_ids": id};
      print('bodybodybody');
      print(body);
      Response response = await _webService.postRequest(
          NetworkUrls.createPaymentOnWebsite, body);
      ResponseMessages responseBody =
          ResponseMessages.fromJson(jsonDecode(response.body));

      return responseBody;
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.needInternetMessage);
      }
      return null;
    }
  }

  void clear() {
    startPaymentList.value.clear();
  }
}
