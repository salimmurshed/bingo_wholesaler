import 'dart:convert';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../const/utils.dart';
import '../data_models/models/all_sales_model/all_sales_model.dart';
import '../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../data_models/models/customer_creditline_list/customer_creditline_list.dart';
import '../data_models/models/customer_list/customer_list.dart';
import '../data_models/models/customer_settlement_list/customer_settlement_list.dart';
import '../data_models/models/customer_store_list/customer_store_list.dart';
import '../data_models/models/internal_configuration_list_model.dart';
import '../data_models/models/retailer_wholesaler_association_request_model/retailer_wholesaler_association_request_model.dart';
import '../data_models/models/retailer_wholesaler_creditline_summery_details_model.dart';
import '../data_models/models/settlement_web_model/settlement_web_model.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';

@lazySingleton
class CustomerRepository with ListenableServiceMixin {
  final LocalData _localData = locator<LocalData>();
  final WebService _webService = locator<WebService>();

  // final NavigationService _navigationService = locator<NavigationService>();
  // final AuthService _authService = locator<AuthService>();
  final dbHelper = DatabaseHelper.instance;

  CustomerRepository() {
    listenToReactiveValues([customers]);
  }

  // ReactiveValue<List<AllSalesData>> existedCustomeSales = ReactiveValue([]);
  //
  // ReactiveValue<List<CustomerSettlementData>> existedCustomeSettlements =
  //     ReactiveValue([]);

  ReactiveValue<List<CustomerData>> customers = ReactiveValue([]);

  // List<CustomerData> customers = [];
  List<CustomerCreditlineData> customerCreditline = [];
  List<AllSalesData> customerSales = [];
  List<CustomerSettlementData> customerSettlements = [];
  List<CustomerStoreData> customerStore = [];
  AssociationWholesalerRequestDetailsModel customerProfile =
      AssociationWholesalerRequestDetailsModel();

  //load buttons
  bool salesLoadMoreButton = false;
  bool customerLoadMoreButton = false;

  Future<void> clearCustomer() async {
    customers.value.clear();
    notifyListeners();
    await getCustomerOnline(1);
  }

  Future getCustomerOnline(int customerPage) async {
    bool connection = await checkConnectivity();
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            (("${NetworkUrls.wholesalerAssociatedRetailerList}$customerPage")),
            {});
        Utils.fPrint(response.body);
        final responseData = CustomerList.fromJson(jsonDecode(response.body));

        if (customerPage == 1) {
          customers.value = responseData.data!.data!;

          Utils.fPrint('customerPage.toString()');
        } else {
          customers.value.addAll(responseData.data!.data!);
        }
        notifyListeners();
        // existedCustomeSales.value.addAll(customerSales);
        if (responseData.data!.nextPageUrl != null) {
          if (responseData.data!.nextPageUrl!.isNotEmpty) {
            customerLoadMoreButton = true;
          } else {
            customerLoadMoreButton = false;
          }
        } else {
          customerLoadMoreButton = false;
        }
        notifyListeners();
        if (!kIsWeb) {
          if (customerPage == 1) {
            _localData.insert(
                TableNames.customerList, responseData.data!.data!);
          }
        }
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<CustomerList> getCustomerOnlineWebWholesaler(
      String customerPage) async {
    String url = "${NetworkUrls.wholesalerAssociatedRetailerList}$customerPage";
    Response response = await _webService.postRequest(url, {});
    final responseData = CustomerList.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future<RetailerAssociationRequestDetailsModel>
      getRetailerSideWholesalerDetails(String id) async {
    var jsonBody = {"unique_id": id};
    Response response = await _webService.postRequest(
      NetworkUrls.viewRetailerWholesalerAssociationRequest,
      jsonBody,
    );
    final responseData = RetailerAssociationRequestDetailsModel.fromJson(
        jsonDecode(response.body));
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    return responseData;
  }

  Future<List<CustomerData>> getCustomerOnlineWebRetailer() async {
    String url = NetworkUrls.retailerAssociatedWholesalerList;
    Response response = await _webService.postRequest(url, {});
    List<CustomerData> data = [];
    if (jsonDecode(response.body)['data'] != null) {
      jsonDecode(response.body)['data'].forEach((v) {
        data.add(CustomerData.fromJson(v));
      });
    }
    // List responseData =jsonDecode(response.body)['data'].map CustomerData.fromJson(jsonDecode(response.body));
    // Utils.fPrint('response.body');
    // Utils.fPrint(jsonDecode(response.body)['data']);
    return data;
  }

  checkNextPageCustomer(int customerPage) async {
    customerLoadMoreButton = true;
    notifyListeners();
    // bool connection = await checkConnectivity();
    // if (connection) {
    //   Response response = await _webService.postRequest(
    //       (Uri.parse(
    //           "${NetworkUrls.wholesalerAssociatedRetailerList}$customerPage")),
    //       {});
    //   final responseData =
    //       CustomerList.fromJson(convert.jsonDecode(response.data));
    //   if (responseData.data!.nextPageUrl != null) {
    //     if (responseData.data!.nextPageUrl!.isNotEmpty) {
    //       customerLoadMoreButton = true;
    //     } else {
    //       customerLoadMoreButton = false;
    //     }
    //   } else {
    //     customerLoadMoreButton = false;
    //   }
    // }
  }

  Future refreshCustomer() async {
    await getCustomerOnline(1);
  }

  Future getCustomerOffline(customerPage) async {
    dbHelper.queryAllRows(TableNames.customerList).then((value) {
      customers.value = value.map((d) => CustomerData.fromJson(d)).toList();
    });
    checkNextPageCustomer(customerPage);
  }

  void sortList(String e) {
    if (e == "Status") {
      customers.value.sort((a, b) {
        String aDate = a.status!;
        String bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      customers.value.sort((a, b) {
        int aDate =
            DateTime.parse(a.customerSinceDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.customerSinceDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  ////creditline
  Future getCustomerCreditlineOnline(String uniqueId, bool refresh) async {
    bool connection = await checkConnectivity();
    // if (connection) {
    //   if (refresh) {
    //     existedCustomerCreditline.value.clear();
    //   }
    // }
    // bool isAvailable = false;
    // if (existedCustomerCreditline.value.isNotEmpty) {
    //   isAvailable = existedCustomerCreditline.value
    //       .where((element) => element.retailerUniqueId == uniqueId)
    //       .isNotEmpty;
    // }
    // if (isAvailable) {
    //   customerCreditline = existedCustomerCreditline.value;
    //   notifyListeners();
    // } else {
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            (("${NetworkUrls.retailerWholesalerCreditlineList}1")),
            {"retailer_unique_id": uniqueId});
        final responseData =
            CustomerCreditlineList.fromJson(jsonDecode(response.body));
        customerCreditline = responseData.data!.data!;
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
    // }
  }

  Future<CustomerCreditlineList> getCustomerCreditlineOnlineWeb(
      String uniqueId) async {
    Response response = await _webService.postRequest(
        (("${NetworkUrls.retailerWholesalerCreditlineList}1")),
        {"retailer_unique_id": uniqueId});
    final responseData =
        CustomerCreditlineList.fromJson(jsonDecode(response.body));
    Utils.fPrint('uniqueIduniqueId');
    Utils.fPrint(response.body);
    return responseData;

    // }
  }

  void creditlineSortList(String e) {
    if (e == "Status") {
      customerCreditline.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      customerCreditline.sort((a, b) {
        int aDate =
            DateTime.parse(a.customerSinceDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.customerSinceDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  ////sales
  Future getCustomerSales(String uniqueId, int salePageNumber) async {
    bool connection = await checkConnectivity();
    // bool isAvailable = false;
    // if (existedCustomeSales.value.isNotEmpty) {
    //   isAvailable = existedCustomeSales.value
    //       .where((element) => element.wholesalerStoreId == uniqueId)
    //       .isNotEmpty;
    // }
    // if (isAvailable) {
    //   customerSales = existedCustomeSales.value;
    //   notifyListeners();
    // } else {
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            (("${NetworkUrls.retailerWholesalerSalesList}${salePageNumber.toString()}")),
            {"retailer_unique_id": uniqueId});
        Utils.fPrint({"retailer_unique_id": uniqueId}.toString());
        final responseData = AllSalesModel.fromJson(jsonDecode(response.body));
        if (salePageNumber == 1) {
          customerSales = responseData.data!.data!;
        } else {
          customerSales.addAll(responseData.data!.data!);
        }
        // existedCustomeSales.value.addAll(customerSales);
        if (responseData.data!.nextPageUrl != null) {
          if (responseData.data!.nextPageUrl!.isNotEmpty) {
            salesLoadMoreButton = true;
          } else {
            salesLoadMoreButton = false;
          }
        } else {
          salesLoadMoreButton = false;
        }
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
    // }
  }

  Future<AllSalesModel> getCustomerSalesWeb(
      String uniqueId, String salePageNumber) async {
    Response response = await _webService.postRequest(
        (("${NetworkUrls.retailerWholesalerSalesList}$salePageNumber")),
        {"retailer_unique_id": uniqueId});
    Utils.fPrint({"retailer_unique_id": uniqueId}.toString());
    final responseData = AllSalesModel.fromJson(jsonDecode(response.body));

    return responseData;
  }

  Future refreshSales(String uniqueId, int salePageNumber) async {
    bool connection = await checkConnectivity();

    try {
      if (connection) {
        // existedCustomeSales.value.clear();
        Response response = await _webService.postRequest(
            (("${NetworkUrls.retailerWholesalerSalesList}$salePageNumber")),
            {"retailer_unique_id": uniqueId});
        final responseData = AllSalesModel.fromJson(jsonDecode(response.body));
        customerSales = responseData.data!.data!;
        // existedCustomeSales.value.addAll(customerSales);
        if (responseData.data!.nextPageUrl != null) {
          if (responseData.data!.nextPageUrl!.isNotEmpty) {
            salesLoadMoreButton = true;
          } else {
            salesLoadMoreButton = false;
          }
        } else {
          salesLoadMoreButton = false;
        }
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  void salesCustomerSortList(String e) {
    if (e == "Status") {
      customerSales.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      customerSales.sort((a, b) {
        int aDate = DateTime.parse(a.saleDate ?? '').microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.saleDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  ////Settlements
  Future getCustomerSettlements(String uniqueId, bool refresh) async {
    bool connection = await checkConnectivity();

    try {
      if (connection) {
        Response response = await _webService.postRequest(
            ((NetworkUrls.retailerWholesalerSettlementList)),
            {"retailer_unique_id": uniqueId});
        final responseData =
            CustomerSettlementModel.fromJson(jsonDecode(response.body));
        Utils.fPrint('response.body');
        Utils.fPrint(response.body);
        customerSettlements = responseData.data!;
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
    // }
  }

  Future<List<SettlementWebModelData>> getCustomerSettlementsWeb(
      String uniqueId, bool refresh) async {
    Response response = await _webService.postRequest(
        ((NetworkUrls.retailerWholesalerSettlementList)),
        {"retailer_unique_id": uniqueId});
    // Utils.fPrint('response.bodyxxxxsdasd');
    // Utils.fPrint(response.body);
    final responseData =
        RetailerSettlementWebModel.fromJson(jsonDecode(response.body));

    return responseData.data!;
  }

  Future getCustomerProfile(String uniqueId, bool refresh) async {
    bool connection = await checkConnectivity();

    try {
      if (connection) {
        if (refresh) {
          customerProfile = AssociationWholesalerRequestDetailsModel();
        }
        Response response = await _webService.postRequest(
            NetworkUrls.viewWholesalerRetailerAssociationRequest,
            {"unique_id": uniqueId});
        customerProfile = AssociationWholesalerRequestDetailsModel.fromJson(
            jsonDecode(response.body));
        Utils.fPrint('customerProfilecustomerProfile');
        Utils.fPrint(response.body);
        Utils.fPrint(uniqueId);
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<AssociationWholesalerRequestDetailsModel> getCustomerProfileWeb(
      String uniqueId) async {
    Response response = await _webService.postRequest(
        NetworkUrls.viewWholesalerRetailerAssociationRequest,
        {"unique_id": uniqueId});
    customerProfile = AssociationWholesalerRequestDetailsModel.fromJson(
        jsonDecode(response.body));

    return customerProfile;
  }

  void settlementsCustomerSortList(String e) {
    if (e == "Status") {
      customerSettlements.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      customerSettlements.sort((a, b) {
        int aDate = DateTime.parse(a.postingDate ?? '').microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.postingDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  ////store
  Future getCustomerStore(String uniqueId, bool refresh) async {
    bool connection = await checkConnectivity();
    // if (connection) {
    //   if (refresh) {
    //     Utils.fPrint("i ma here");
    //     existedCustomerStore.value.clear();
    //   }
    // }
    // bool isAvailable = false;
    // if (existedCustomerStore.value.isNotEmpty) {
    //   isAvailable = existedCustomerStore.value
    //       .where((element) => element.retailerUniqueId == uniqueId)
    //       .isNotEmpty;
    // }
    // if (isAvailable) {
    //   customerStore = existedCustomerStore.value;
    //   notifyListeners();
    // } else {
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            ((NetworkUrls.retailerWholesalerStoreList)),
            {"retailer_unique_id": uniqueId});
        final responseData =
            CustomerStoreList.fromJson(jsonDecode(response.body));
        customerStore = responseData.data!;
        // existedCustomerStore.value.addAll(customerStore);
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
    // }
  }

  Future<CustomerStoreData?> getCustomerStoreDetails(
      String uniqueId, String storeId) async {
    Response response = await _webService.postRequest(
        ((NetworkUrls.retailerStoreDetailsForWholesaler)),
        {"retailer_unique_id": uniqueId, "store_unique_id": storeId});
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    CustomerStoreListSingle responseData =
        CustomerStoreListSingle.fromJson(jsonDecode(response.body));
    return responseData.data;
  }

  Future<InternalConfigurationListModel> getInternalConfigurationList() async {
    Response response = await _webService
        .getRequest(NetworkUrls.wholesalerInternalConfigurationList);
    InternalConfigurationListModel responseData =
        InternalConfigurationListModel.fromJson(jsonDecode(response.body));
    Utils.fPrint('configure');
    Utils.fPrint(responseData.toJson().toString());
    return responseData;
  }

  Future<RetailerWholesalerCreditlineSummaryDetailsModel>
      getRetailersCreditlineViewDetails(String? id) async {
    Response responseSummary = await _webService.postRequest(
        NetworkUrls.uri_retailerWholesalerCreditlineSummary,
        {"creditline_unique_id": id});
    Response responseDetails = await _webService.postRequest(
        NetworkUrls.uri_retailerWholesalerCreditlineDetails,
        {"creditline_unique_id": id});
    RetailerWholesalerCreditlineSummaryModel responseDataSummary =
        RetailerWholesalerCreditlineSummaryModel.fromJson(
            jsonDecode(responseSummary.body));
    RetailerWholesalerCreditlineDetailsModel responseDataDetails =
        RetailerWholesalerCreditlineDetailsModel.fromJson(
            jsonDecode(responseDetails.body));
    RetailerWholesalerCreditlineSummaryDetailsModel v =
        RetailerWholesalerCreditlineSummaryDetailsModel(
      retailerWholesalerCreditlineDetailsModel: responseDataDetails,
      retailerWholesalerCreditlineSummaryModel: responseDataSummary,
    );
    Utils.fPrint(jsonEncode(v.retailerWholesalerCreditlineDetailsModel));
    Utils.fPrint(jsonEncode(v.retailerWholesalerCreditlineSummaryModel));
    return v;
  }
}
