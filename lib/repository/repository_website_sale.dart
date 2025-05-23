import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../data_models/enums/user_type_for_web.dart';
import '../data_models/models/retailer_sale_financial_statements /retailer_sale_financial_statements.dart';
import '../data_models/models/sale_details_transection_model/sale_details_transection_model.dart';
import '../services/auth_service/auth_service.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';
import 'package:universal_html/html.dart' as html;

@lazySingleton
class RepositoryWebsiteSales with ListenableServiceMixin {
  final WebService _webService = locator<WebService>();
  final AuthService _authService = locator<AuthService>();

  // bool get isRetailer => _authService.isRetailer.value;

  UserTypeForWeb get enrollment => _authService.enrollment.value;

  Future<SaleDetailsTransection> getSaleDetailsForWeb(String id) async {
    String cookies = html.document.cookie!;
    String url = enrollment == UserTypeForWeb.retailer
        ? NetworkUrls.retailerSalesTransactionDetails
        : NetworkUrls.getSaleDetails;
    Response response = await _webService.postRequest(url, {"unique_id": id});
    return SaleDetailsTransection.fromJson(jsonDecode(response.body));
  }

  Future<RetailerSaleFinancialStatements> getSaleStatementsWeb(
      String id, int page) async {
    String url = NetworkUrls.retailerSaleFinancialStatementsList;
    Response response = await _webService
        .postRequest('$url?page=$page', {"sale_unique_id": id});
    return RetailerSaleFinancialStatements.fromJson(jsonDecode(response.body));
  }

  Future<List<SaleTranctionDetails>> getSaleDetailsTransactionForWeb(
      String id) async {
    String url = NetworkUrls.wholesalerSalesTransactionDetails;
    Response response = await _webService.postRequest(url, {"unique_id": id});
    WholesalerSaleTranctionDetails data =
        WholesalerSaleTranctionDetails.fromJson(jsonDecode(response.body));

    return data.data!;
  }

  Future<Map<String, dynamic>?> updateSales(Map<String, dynamic> body) async {
    try {
      Response response =
          await _webService.postRequest(NetworkUrls.updateSales, body);
      if (jsonDecode(response.body)['success']) {
        var responseReply = {
          "success": jsonDecode(response.body)['success'],
          "message": jsonDecode(response.body)['message'],
        };
        return responseReply;
      } else {
        null;
      }
    } on Exception catch (_) {
      return null;
    }
    return null;
  }
}
