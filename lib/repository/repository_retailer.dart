import 'dart:convert';
import 'dart:io';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';

import '/const/app_extensions/widgets_extensions.dart';
import '/const/utils.dart';
import '/data_models/models/failure.dart';
import '/data_models/models/store_model/store_model.dart';
import '/repository/repository_components.dart';
import '/services/network/network_urls.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/network/network_info.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../data_models/construction_model/wholesaler_data.dart';
import '../data_models/enums/status_name.dart';
import '../data_models/models/association_request_model/association_request_model.dart';
import '../data_models/models/component_models/partner_with_currency_list.dart';
import '../data_models/models/component_models/response_model.dart';
import '../data_models/models/deposit_recommendation/deposit_recommendation.dart';
import '../data_models/models/get_company_profile/get_company_profile.dart';
import '../data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import '../data_models/models/retailer_associated_wholesaler_list/retailer_associated_wholesaler_list.dart';
import '../data_models/models/retailer_association_fie_list/retailer_association_fie_list.dart';
import '../data_models/models/retailer_bank_account_balance_model/retailer_bank_account_balance_model.dart';
import '../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../data_models/models/retailer_credit_line_req_model/retailer_credit_line_req_model.dart';
import '../data_models/models/retailer_creditline_request_details_model/retailer_creditline_request_details_model.dart';
import '../data_models/models/retailer_fiancial_statement_model/retailer_fiancial_statement_model.dart';
import '../data_models/models/retailer_sale_financial_statements/retailer_sale_financial_statements.dart';
import '../data_models/models/retailer_settlement_list_model/retailer_settlement_list_model.dart';
import '../data_models/models/retailer_users_model/retailer_users_model.dart';
import '../data_models/models/retailer_wholesaler_association_request_model/retailer_wholesaler_association_request_model.dart';
import '../data_models/models/settlement_details_model/settlement_details_model.dart';
import '../data_models/models/update_response_model/update_response_model.dart';
import '../data_models/models/wholesaler_list_model/wholesaler_list_model.dart';
import '../main.dart';
import '../presentation/widgets/alert/alert_dialog.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/navigation/navigation_service.dart';
import '../services/network/web_service.dart';
import 'package:dio/dio.dart' as dio;

@lazySingleton
class RepositoryRetailer with ListenableServiceMixin {
  final dbHelper = DatabaseHelper.instance;
  var networkInfo = locator<NetworkInfoService>();
  final WebService _webService = locator<WebService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final LocalData _localData = locator<LocalData>();

  RepositoryRetailer() {
    listenToReactiveValues([
      retailerAssociationRequestDetailsList,
      associationRequestRetailerDetails,
      setScreenBusy,
      wholesalerAssociationRequestData,
      fieAssociationRequestData,
      creditLineInformation,
      globalMessage,
      retailerCreditLineReqDetails,
      retilerAssociationWholesalers,
      retailsBankAccounts,
      retailerAssociationFie,
      approveCreditlineRequestData,
      retailersUserList,
      userCompanyProfile
    ]);
  }

  ///List
  ReactiveValue<GetCompanyProfile> userCompanyProfile =
      ReactiveValue<GetCompanyProfile>(GetCompanyProfile());
  List<StoreData> storeList = [];
  List<WholeSalerOrFiaListData> wholeSaleList = [];
  List<WholeSalerOrFiaListData> fiaList = [];
  ReactiveValue<List<RetailerCreditLineRequestData>>
      retailerCreditLineRequestData =
      ReactiveValue<List<RetailerCreditLineRequestData>>([]);
  ReactiveValue<ResponseMessages> globalMessage =
      ReactiveValue(ResponseMessages());

  ///List

  ///ReactiveValue
  ///
  ReactiveValue<List<ApproveCreditlineRequestData>>
      approveCreditlineRequestData =
      ReactiveValue<List<ApproveCreditlineRequestData>>([]);
  ReactiveValue<List<AssociationRequestData>> wholesalerAssociationRequestData =
      ReactiveValue([]);
  ReactiveValue<List<AssociationRequestData>> fieAssociationRequestData =
      ReactiveValue([]);
  ReactiveValue<RetailerAssociationRequestDetailsModel>
      associationRequestRetailerDetails =
      ReactiveValue(RetailerAssociationRequestDetailsModel());

  ReactiveValue<List<RetailerAssociationRequestDetailsModel>>
      retailerAssociationRequestDetailsList =
      ReactiveValue<List<RetailerAssociationRequestDetailsModel>>([]);
  ReactiveValue<List<RetailerAssociationRequestDetailsModel>>
      retailerFieAssociationRequestDetailsList =
      ReactiveValue<List<RetailerAssociationRequestDetailsModel>>([]);

  ReactiveValue<bool> setScreenBusy = ReactiveValue(false);
  ReactiveValue<List<WholesalersData>> creditLineInformation =
      ReactiveValue<List<WholesalersData>>([]);
  ReactiveValue<RetailerCreditLineReqDetailsModel>
      retailerCreditLineReqDetails =
      ReactiveValue(RetailerCreditLineReqDetailsModel());

  ReactiveValue<List<RetailerAssociationFieListData>> retailerAssociationFie =
      ReactiveValue([]);
  ReactiveValue<List<RetailerAssociatedWholesalerListData>>
      retilerAssociationWholesalers =
      ReactiveValue<List<RetailerAssociatedWholesalerListData>>([]);

  ReactiveValue<List<RetailerBankListData>> retailsBankAccounts =
      ReactiveValue<List<RetailerBankListData>>([]);

  ReactiveValue<List<WholesalerData>> sortedWholsaler =
      ReactiveValue<List<WholesalerData>>([]);
  List<WholesalerData> creditLineInformations = [];

  ///ReactiveValue

  bool fieLoadMoreButton = false;

  clearFie() async {
    retailerAssociationFie.value.clear();
    approveCreditlineRequestData.value.clear();
    financialStatements.value.clear();
    settlementList.value.clear();
    storeList.clear();
    await getStores();
  }

  void refreshGlobalMessage() async {
    await Future.delayed(const Duration(seconds: 5));
    globalMessage.value = ResponseMessages();
    notifyListeners();
  }

  void getSortedWholsaler() {
    for (WholesalersData i in creditLineInformation.value) {
      creditLineInformations.add(i.wholesaler!);
    }
    sortedWholsaler.value = _repositoryComponents
        .wholesalerWithCurrency.value.data![0].wholesalerData!
        .where((element) => !(creditLineInformations
            .any((e) => e.wholesalerName == element.wholesalerName)))
        .toList();
    notifyListeners();
  }

  Future getCreditLinesList() async {
    if (!kIsWeb) {
      dbHelper
          .queryAllRows(TableNames.retailerCreditlineRequestList)
          .then((value) {
        retailerCreditLineRequestData.value = value
            .map((d) => RetailerCreditLineRequestData.fromJson(d))
            .toList();
      });
    }
    try {
      Response response = await _webService
          .getRequest(NetworkUrls.retailerCreditlineRequestList);
      final responseData =
          RetailerCreditLineRequestModel.fromJson(jsonDecode(response.body));
      retailerCreditLineRequestData.value = responseData.data!.data!;
      Utils.fPrint('response.bodyx');
      Utils.fPrint(response.body);
      if (responseData.success!) {
        creditLineInformation.value.clear();
      }
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerCreditlineRequestList, responseData.data!.data!);
      }
      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future refreshCreditLinesList() async {
    try {
      Response response = await _webService
          .getRequest(NetworkUrls.retailerCreditlineRequestList);
      final responseData =
          RetailerCreditLineRequestModel.fromJson(jsonDecode(response.body));
      retailerCreditLineRequestData.value = responseData.data!.data!;
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerCreditlineRequestList, responseData.data!.data!);
      }
      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future getCreditLinesDetails(String id) async {
    var jsonBody = {"creditline_unique_id": id};
    try {
      Response response = await _webService.postRequest(
        NetworkUrls.retailerCreditlineRequestDetails,
        jsonBody,
      );
      final responseData =
          RetailerCreditLineReqDetailsModel.fromJson(jsonDecode(response.body));
      retailerCreditLineReqDetails.value = responseData;
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  void addCreditLineInformation(WholesalersData value) {
    creditLineInformation.value.add(value);
    notifyListeners();
  }

  void updateWholesaler(String id, WholesalersData item) {
    int index =
        creditLineInformation.value.indexWhere((element) => element.id == id);
    creditLineInformation.value[index].wholesaler = item.wholesaler;
    creditLineInformation.value[index].currency = item.currency;
    creditLineInformation.value[index].monthlyPurchase = item.monthlyPurchase;
    creditLineInformation.value[index].averageTicket = item.averageTicket;
    creditLineInformation.value[index].visitFrequency = item.visitFrequency;
    creditLineInformation.value[index].amount = item.amount;
    notifyListeners();
  }

  void removeCreditLineInformation(String id) {
    int index =
        creditLineInformation.value.indexWhere((element) => element.id == id);
    creditLineInformation.value.removeAt(index);
    notifyListeners();
  }

  //all store
  Future getStores() async {
    dbHelper.queryAllRows(TableNames.storeTableName).then((value) {
      storeList = value.map((d) => StoreData.fromJson(d)).toList();
    });
    try {
      Response response = await _webService.getRequest(NetworkUrls.storeUrl);
      final responseData = StoreModel.fromJson(jsonDecode(response.body));
      storeList = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(TableNames.storeTableName, responseData.data!);
      }
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }

    notifyListeners();
  }

  //all wholesaler list
  Future getWholesaler() async {
    dbHelper.queryAllRows(TableNames.wholesalerList).then((value) {
      wholeSaleList =
          value.map((d) => WholeSalerOrFiaListData.fromJson(d)).toList();
    });
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.wholesalerListUri);
      final responseData =
          WholeSalerOrFiaListModel.fromJson(jsonDecode(response.body));
      wholeSaleList = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(TableNames.wholesalerList, responseData.data!);
      }
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future<List<WholeSalerOrFiaListData>> getWholesalerFieForRequestWeb(
      String? type) async {
    String url = type == Routes.wholesalerRequest
        ? NetworkUrls.wholesalerListUri
        : NetworkUrls.fiaListURI;
    Response response = await _webService.getRequest(url);

    final responseData =
        WholeSalerOrFiaListModel.fromJson(jsonDecode(response.body));
    wholeSaleList = responseData.data!;
    return wholeSaleList;
  }

  Future<ResponseMessageModel> createWholesalerFieForRequestWeb(
      String? type, List<String?> wholesalerFieUniqueIds) async {
    String ids = wholesalerFieUniqueIds
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "");
    String url = type == Routes.wholesalerRequest
        ? NetworkUrls.addRetailerWholesalerAssociationRequest
        : NetworkUrls.addRetailerFiaAssociationRequest;
    Response response = await _webService.postRequest(url, {"unique_id": ids});

    ResponseMessageModel responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));

    return responseData;
  }

  Future sendWholesalerRequest(List<String> selectedWholeSaler) async {
    String value = selectedWholeSaler
        .toString()
        .replaceAll('[', "")
        .replaceAll(']', "")
        .replaceAll(' ', "");
    var jsonBody = {"unique_id": value};
    try {
      Response res = await _webService.postRequest(
        NetworkUrls.addRetailerWholesalerAssociationRequest,
        jsonBody,
      );
      Response response =
          await _webService.getRequest(NetworkUrls.requestAssociationList);
      final responseData =
          AssociationRequestModel.fromJson(jsonDecode(response.body));
      wholesalerAssociationRequestData.value = responseData.data!;

      Utils.fPrint('associationRequestData.value');
      Utils.fPrint(wholesalerAssociationRequestData.value.toString());
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerAssociationList, responseData.data!);
      }
      _navigationService.pop();
      notifyListeners();
      ResponseMessages result = ResponseMessages.fromJson(jsonDecode(res.body));
      await getRetailersAssociationData();
      globalMessage.value = result;
      notifyListeners();
      refreshGlobalMessage();

      // Utils.fPrint(res.reasonPhrase);
    } on Exception catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  //all fia list
  Future getFia() async {
    dbHelper.queryAllRows(TableNames.fiaList).then((value) {
      fiaList = value.map((d) => WholeSalerOrFiaListData.fromJson(d)).toList();
    });
    try {
      Response response = await _webService.getRequest(NetworkUrls.fiaListURI);
      final responseData =
          WholeSalerOrFiaListModel.fromJson(jsonDecode(response.body));
      fiaList = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(TableNames.fiaList, responseData.data!);
      }
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future sendFiaRequest(List<String> selectedFia) async {
    String value = selectedFia
        .toString()
        .replaceAll('[', "")
        .replaceAll(']', "")
        .replaceAll(' ', "");
    var jsonBody = {"unique_id": value};
    try {
      Response res = await _webService.postRequest(
        NetworkUrls.addRetailerFiaAssociationRequest,
        jsonBody,
      );
      ResponseMessages result = ResponseMessages.fromJson(jsonDecode(res.body));

      await getRetailersFieAssociationData();
      globalMessage.value = result;
      notifyListeners();
      refreshGlobalMessage();
    } on Exception catch (_) {
      rethrow;
    }
  }

  //all retailer Association list
  Future getRetailersAssociationData() async {
    if (!kIsWeb) {
      dbHelper.queryAllRows(TableNames.retailerAssociationList).then((value) {
        wholesalerAssociationRequestData.value =
            value.map((d) => AssociationRequestData.fromJson(d)).toList();

        notifyListeners();
      });
    }
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.requestAssociationList);
      final responseData =
          AssociationRequestModel.fromJson(jsonDecode(response.body));
      wholesalerAssociationRequestData.value = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerAssociationList, responseData.data!);
      }

      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future<List<AssociationRequestData>> getRetailersAssociationDataWeb(
      String? type) async {
    Utils.fPrint('typetypetypetype');
    Utils.fPrint(type);
    try {
      if (type != null) {
        String url = type.toLowerCase() == "wholesaler_request"
            ? NetworkUrls.requestAssociationList
            : NetworkUrls.requestFieAssociationList;
        Response response = await _webService.getRequest(url);
        final responseData =
            AssociationRequestModel.fromJson(jsonDecode(response.body));
        return responseData.data!;
      }
      return [];
    } on Exception catch (_) {
      return [];
    }
  }

  Future refreshgRetailersAssociationData() async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.requestAssociationList);
      final responseData =
          AssociationRequestModel.fromJson(jsonDecode(response.body));
      wholesalerAssociationRequestData.value = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerAssociationList, responseData.data!);
      }

      retailerAssociationRequestDetailsList.value.clear();
      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future getRetailersFieAssociationData() async {
    if (!kIsWeb) {
      dbHelper
          .queryAllRows(TableNames.retailerFieAssociationList)
          .then((value) {
        fieAssociationRequestData.value =
            value.map((d) => AssociationRequestData.fromJson(d)).toList();
        notifyListeners();
      });
    }
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.requestFieAssociationList);
      final responseData =
          AssociationRequestModel.fromJson(jsonDecode(response.body));
      fieAssociationRequestData.value = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerFieAssociationList, responseData.data!);
      }

      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future refreshRetailersFieAssociationData() async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.requestFieAssociationList);
      final responseData =
          AssociationRequestModel.fromJson(jsonDecode(response.body));
      fieAssociationRequestData.value = responseData.data!;
      if (!kIsWeb) {
        _localData.insert(
            TableNames.retailerFieAssociationList, responseData.data!);
      }

      retailerFieAssociationRequestDetailsList.value.clear();
      notifyListeners();
    } on Exception catch (_) {
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future<void> getRetailerAssociationDetails(String id) async {
    int index = 0;
    bool isAvailable = false;
    if (retailerAssociationRequestDetailsList.value.isNotEmpty) {
      index = retailerAssociationRequestDetailsList.value.indexWhere(
          (element) => element.data![0].companyInformation![0].uniqueId == id);
    }
    if (retailerAssociationRequestDetailsList.value.isNotEmpty) {
      isAvailable = false;
      isAvailable = retailerAssociationRequestDetailsList.value
          .where((element) =>
              element.data![0].companyInformation![0].uniqueId == id)
          .isNotEmpty;
    }
    if (isAvailable) {
      associationRequestRetailerDetails.value =
          retailerAssociationRequestDetailsList.value[index];
      Utils.fPrint('isAvailable');
      Utils.fPrint(isAvailable.toString());
    } else {
      try {
        Utils.fPrint('isAvailable');
        Utils.fPrint(isAvailable.toString());
        setScreenBusy.value = true;
        notifyListeners();
        var jsonBody = {"unique_id": id};
        Response response = await _webService.postRequest(
          NetworkUrls.viewRetailerWholesalerAssociationRequest,
          jsonBody,
        );

        RetailerAssociationRequestDetailsModel responseData =
            RetailerAssociationRequestDetailsModel.fromJson(
                jsonDecode(response.body));
        retailerAssociationRequestDetailsList.value.add(responseData);
        associationRequestRetailerDetails.value = responseData;
        setScreenBusy.value = false;
        notifyListeners();
      } on Exception catch (_) {
        setScreenBusy.value = false;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<RetailerAssociationRequestDetailsModel?>
      getRetailerAssociationDetailsWeb(String id, bool forRetailer) async {
    try {
      Utils.fPrint('forRetailer');
      Utils.fPrint(forRetailer.toString());
      var jsonBody = {"unique_id": id};
      Response response = await _webService.postRequest(
        forRetailer
            ? NetworkUrls.viewRetailerWholesalerAssociationRequest
            : NetworkUrls.viewRetailerFieAssociationRequest,
        jsonBody,
      );

      RetailerAssociationRequestDetailsModel responseData =
          RetailerAssociationRequestDetailsModel.fromJson(
              jsonDecode(response.body));
      Utils.fPrint('response.body');
      Utils.fPrint(response.body);
      return responseData;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> refreshRetailerAssociationDetails(String id) async {
    int index = 0;
    if (retailerAssociationRequestDetailsList.value.isNotEmpty) {
      index = retailerAssociationRequestDetailsList.value.indexWhere(
          (element) => element.data![0].companyInformation![0].uniqueId == id);
    }

    try {
      var jsonBody = {"unique_id": id};
      Response response = await _webService.postRequest(
        NetworkUrls.viewRetailerWholesalerAssociationRequest,
        jsonBody,
      );

      RetailerAssociationRequestDetailsModel responseData =
          RetailerAssociationRequestDetailsModel.fromJson(
              jsonDecode(response.body));
      retailerAssociationRequestDetailsList.value[index] = responseData;
      associationRequestRetailerDetails.value = responseData;

      notifyListeners();
    } on Exception catch (_) {}

    notifyListeners();
  }

  Future<void> getRetailerFieAssociationDetails(String id) async {
    int index = 0;
    bool isAvailable = false;
    if (retailerFieAssociationRequestDetailsList.value.isNotEmpty) {
      index = retailerFieAssociationRequestDetailsList.value.indexWhere(
          (element) => element.data![0].companyInformation![0].uniqueId == id);
    }
    if (retailerFieAssociationRequestDetailsList.value.isNotEmpty) {
      isAvailable = retailerFieAssociationRequestDetailsList.value
          .where((element) =>
              element.data![0].companyInformation![0].uniqueId == id)
          .isNotEmpty;
    }
    if (isAvailable) {
      associationRequestRetailerDetails.value =
          retailerFieAssociationRequestDetailsList.value[index];
    } else {
      try {
        setScreenBusy.value = true;
        notifyListeners();
        var jsonBody = {"unique_id": id};
        Response response = await _webService.postRequest(
          NetworkUrls.viewRetailerFieAssociationRequest,
          jsonBody,
        );

        RetailerAssociationRequestDetailsModel responseData =
            RetailerAssociationRequestDetailsModel.fromJson(
                jsonDecode(response.body));
        retailerFieAssociationRequestDetailsList.value.add(responseData);
        associationRequestRetailerDetails.value = responseData;
        setScreenBusy.value = false;
        notifyListeners();
      } on Exception catch (_) {
        setScreenBusy.value = false;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<RetailerAssociationRequestDetailsModel>
      getRetailerFieAssociationDetailsWeb(String id) async {
    var jsonBody = {"unique_id": id};
    Response response = await _webService.postRequest(
      NetworkUrls.viewRetailerFieAssociationRequest,
      jsonBody,
    );
    RetailerAssociationRequestDetailsModel data =
        RetailerAssociationRequestDetailsModel.fromJson(
            jsonDecode(response.body));
    return data;
  }

  Future<void> refreshRetailerFieAssociationDetails(String id) async {
    int index = 0;
    if (retailerFieAssociationRequestDetailsList.value.isNotEmpty) {
      index = retailerFieAssociationRequestDetailsList.value.indexWhere(
          (element) => element.data![0].companyInformation![0].uniqueId == id);
    }

    try {
      var jsonBody = {"unique_id": id};
      Response response = await _webService.postRequest(
        NetworkUrls.viewRetailerFieAssociationRequest,
        jsonBody,
      );

      RetailerAssociationRequestDetailsModel responseData =
          RetailerAssociationRequestDetailsModel.fromJson(
              jsonDecode(response.body));
      retailerFieAssociationRequestDetailsList.value[index] = responseData;
      associationRequestRetailerDetails.value = responseData;
      notifyListeners();
    } on Exception catch (_) {}

    notifyListeners();
  }

  Future<UpdateResponseModel> updateRetailerWholesalerAssociationStatus(
      dynamic data, String uniqueId, int statusID) async {
    int index = retailerAssociationRequestDetailsList.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    notifyListeners();
    try {
      Response response = await _webService.postRequest(
        NetworkUrls.updateRetailerWholesalerAssociationStatus,
        data,
      );
      final responseData =
          UpdateResponseModel.fromJson(jsonDecode(response.body));
      if (responseData.success!) {
        retailerAssociationRequestDetailsList
            .value[index]
            .data![0]
            .companyInformation![0]
            .status = describeEnum(StatusNames.completed).toUpperCamelCase();
        associationRequestRetailerDetails.value =
            retailerAssociationRequestDetailsList.value[index];
        await getRetailerAssociationDetails(uniqueId);
        await getRetailersAssociationData();
        // _navigationService.pop();
      }

      notifyListeners();
      return responseData;
      // throw "Done";
    } on Exception {
      rethrow;
    }
  }

  Future<UpdateResponseModel> updateRetailerFieAssociationStatus(
      dynamic data, String uniqueId, int statusID) async {
    int index = retailerFieAssociationRequestDetailsList.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    notifyListeners();
    try {
      Response response = await _webService.postRequest(
        NetworkUrls.updateRetailerFieAssociationStatus,
        data,
      );
      final responseData =
          UpdateResponseModel.fromJson(jsonDecode(response.body));
      if (responseData.success!) {
        retailerFieAssociationRequestDetailsList
            .value[index]
            .data![0]
            .companyInformation![0]
            .status = describeEnum(StatusNames.completed).toUpperCamelCase();
        associationRequestRetailerDetails.value =
            retailerFieAssociationRequestDetailsList.value[index];
        await getRetailerFieAssociationDetails(uniqueId);
        await getRetailersFieAssociationData();
        // _navigationService.pop();
      }

      notifyListeners();
      return responseData;
      // throw "Done";
    } on Exception {
      rethrow;
    }
  }

  Future<void> rejectRequest(dynamic data, String uniqueId) async {
    int index = retailerAssociationRequestDetailsList.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    int index2 = wholesalerAssociationRequestData.value
        .indexWhere((element) => element.associationUniqueId == uniqueId);

    try {
      Response response = await _webService.postRequest(
        NetworkUrls.updateRetailerWholesalerAssociationStatus,
        data,
      );
      final responseData =
          UpdateResponseModel.fromJson(jsonDecode(response.body));

      if (responseData.success!) {
        //responseData.success!
        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteSuccessful));
        retailerAssociationRequestDetailsList
            .value[index]
            .data![0]
            .companyInformation![0]
            .status = describeEnum(StatusNames.verified).toUpperCamelCase();
        wholesalerAssociationRequestData.value[index2].status =
            describeEnum(StatusNames.verified).toUpperCamelCase();
        notifyListeners();

        notifyListeners();
      } else {
        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteUnsuccessful));
      }
    } on Exception catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  Future<void> rejectRequestFie(dynamic data, String uniqueId) async {
    Utils.fPrint("calllll");
    int index = retailerFieAssociationRequestDetailsList.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    int index2 = fieAssociationRequestData.value
        .indexWhere((element) => element.uniqueId == uniqueId);
    Utils.fPrint(index.toString());
    Utils.fPrint(index2.toString());

    try {
      Response response = await _webService.postRequest(
        NetworkUrls.updateRetailerWholesalerAssociationStatus,
        data,
      );
      final responseData =
          UpdateResponseModel.fromJson(jsonDecode(response.body));

      if (responseData.success!) {
        //responseData.success!

        retailerFieAssociationRequestDetailsList
            .value[index]
            .data![0]
            .companyInformation![0]
            .statusFie = describeEnum(StatusNames.verified).toUpperCamelCase();
        fieAssociationRequestData.value[index2].statusFie =
            describeEnum(StatusNames.verified).toUpperCamelCase();

        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteSuccessful));
        notifyListeners();
      } else {
        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteUnsuccessful));
      }
    } on Exception catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  http.MultipartRequest requestPostResponse() {
    MultipartRequest request =
        _webService.getResponse(NetworkUrls.addCreditlineRequests);
    return request;
  }

  http.MultipartRequest requestReplyResponse() {
    MultipartRequest request =
        _webService.getResponse(NetworkUrls.retailerCreditlineRequestreply);
    return request;
  }

  http.MultipartRequest requestAddStoreResponse() {
    MultipartRequest request =
        _webService.getResponse(NetworkUrls.addEditRetailerStore);
    return request;
  }

  http.MultipartRequest createRequest(url) {
    MultipartRequest request = _webService.getResponse(url);
    return request;
  }

  Future<http.Response> submitRequest(http.MultipartRequest request) async {
    var response = await _webService
        .sendMultiPartRequest(NetworkUrls.updateCompanyProfile, request, []);
    if (response.statusCode == 200) {
      if (activeContext.mounted) {
        await getCompanyProfile();
      }
      notifyListeners();
    }
    Utils.fPrint(response.body);

    return response;
  }

  Future<http.Response?> updateCompanyProfile(
    Map<String, Object> body,
    Uint8List? logoImage,
  ) async {
    dio.MultipartFile? multipartFile;
    if (logoImage != null) {
      multipartFile =
          dio.MultipartFile.fromBytes(logoImage, filename: 'filename');
    }

    final formData = logoImage != null
        ? dio.FormData.fromMap({
            'logo': multipartFile,
            'commercial_name': body['commercialName'],
            'main_products': body['mainProduct'],
            'date_founded': body['dateFounded'],
            'website_url': body['url'],
            'about_us': body['aboutUs'],
            'information': body['information']
          })
        : dio.FormData.fromMap({
            'commercial_name': body['commercialName'],
            'main_products': body['mainProduct'],
            'date_founded': body['dateFounded'],
            'website_url': body['url'],
            'about_us': body['aboutUs'],
            'information': body['information']
          });
    Utils.fPrint(formData.fields.toString());
    Utils.fPrint(formData.files.toString());
    final response = await dio.Dio().post(NetworkUrls.updateCompanyProfile,
        data: formData, options: dio.Options(headers: _webService.headers));
    Utils.fPrint(response.data);
    Utils.toast(response.data['message'], isSuccess: response.data['success']);
    return null;
  }

  Future<http.Response> addCreditlineRequests(
      http.MultipartRequest request, List files) async {
    var response = await _webService.sendMultiPartRequest(
        NetworkUrls.addCreditlineRequests, request, files);
    return response;
  }

  Future<http.Response> addCreditlineRequestsWeb(
      http.MultipartRequest request, List files) async {
    var response = await _webService.sendMultiPartRequest(
        NetworkUrls.addCreditlineRequests, request, files);
    return response;
  }

  Future<http.Response> activeCreditlineRequests(
      http.MultipartRequest request, List files) async {
    var response = await _webService.sendMultiPartRequest(
        NetworkUrls.activeCreditlineRequests, request, files);
    return response;
  }

  Future<Response> changeRetailerStoreStatus(Map<String, String?> data) async {
    Response response = await _webService.postRequest(
      NetworkUrls.changeRetailerStoreStatus,
      data,
    );

    final responseData = ResponseMessages.fromJson(jsonDecode(response.body));
    if (!responseData.success!) {
      _navigationService
          .animatedDialog(AlertDialogMessage(responseData.message!));
    } else {
      if (!kIsWeb) {
        getStores();
        Utils.toast(responseData.message!, isBottom: true);
        _navigationService.pop();
      }
    }
    return response;
  }

  Future<http.Response> addReplyRequests(
      http.MultipartRequest request, List files) async {
    var response = await _webService.sendMultiPartRequest(
        (NetworkUrls.retailerCreditlineRequestreply), request, files);
    RetailerCreditLineReqDetailsModel body =
        RetailerCreditLineReqDetailsModel.fromJson(jsonDecode(response.body));
    if (!body.success!) {
      _navigationService.animatedDialog(AlertDialogMessage(body.message!));
    } else {
      retailerCreditLineReqDetails.value = body;
      int index = retailerCreditLineRequestData.value.indexWhere((element) =>
          element.associationUniqueId == body.data!.associationUniqueId);
      Utils.fPrint('indexindex');
      Utils.fPrint(body.data!.statusDescription);
      retailerCreditLineRequestData.value[index].statusDescription =
          body.data!.statusDescription;
      notifyListeners();
      _navigationService.animatedDialog(AlertDialogMessage(body.message!));
    }
    return response;
  }

  Future<http.Response> addStoreRequests(
    http.MultipartRequest request,
    String? frontBusinessPhoto,
    String? signBoardPhoto,
  ) async {
    List<http.MultipartFile> multipartFiles = [];
    if (frontBusinessPhoto != null) {
      var fbp =
          await http.MultipartFile.fromPath("store_logo", frontBusinessPhoto);
      multipartFiles.add(fbp);
    }
    if (signBoardPhoto != null) {
      var sbp =
          await http.MultipartFile.fromPath("sign_board_photo", signBoardPhoto);
      multipartFiles.add(sbp);
    }

    var response = await _webService.sendMultiPartRequestForMultipleFile(
        NetworkUrls.addEditRetailerStore, request, multipartFiles);

    getStores();

    return response;
  }

  Future<http.Response> updateStoreRequests(
      http.MultipartRequest request) async {
    List<http.MultipartFile> multipartFiles = [];

    var response = await _webService.sendMultiPartRequestForMultipleFile(
        NetworkUrls.addEditRetailerStore, request, multipartFiles);
    getStores();

    return response;
  }

  Future<void> getRetailerBankAccounts() async {
    bool connection = await checkConnectivity();
    dbHelper.queryAllRows(TableNames.retailerBankAccounts).then((value) {
      retailsBankAccounts.value =
          value.map((d) => RetailerBankListData.fromJson(d)).toList();
      notifyListeners();
    });

    if (connection) {
      try {
        Response response = await _webService.getRequest(
          NetworkUrls.retailerBankAccountList,
        );
        RetailerBankList responseData =
            RetailerBankList.fromJson(jsonDecode(response.body));
        retailsBankAccounts.value = responseData.data!;
        if (!kIsWeb) {
          _localData.insert(
              TableNames.retailerBankAccounts, responseData.data!);
        }
        notifyListeners();
      } on Exception catch (_) {
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<RetailerBankList> getRetailerBankAccountsWeb() async {
    Response response = await _webService.getRequest(
      NetworkUrls.retailerBankAccountList,
    );
    RetailerBankList responseData =
        RetailerBankList.fromJson(jsonDecode(response.body));
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    Utils.fPrint(responseData.data!.length.toString());
    return responseData;
  }

  Future<void> clearWholesaler() async {
    retilerAssociationWholesalers.value.clear();
    await getRetailerWholesalerList();
  }

  Future<void> getRetailerWholesalerList() async {
    bool connection = await checkConnectivity();
    dbHelper
        .queryAllRows(TableNames.retailerAssociatedWholesalerList)
        .then((value) {
      Utils.fPrint('jsonEncode(value)');
      Utils.fPrint(jsonEncode(value));
      retilerAssociationWholesalers.value = value
          .map((d) => RetailerAssociatedWholesalerListData.fromJson(d))
          .toList();
      notifyListeners();
    });

    if (connection) {
      try {
        Response response = await _webService
            .postRequest((NetworkUrls.retailerAssociatedWholesalerList), {});
        RetailerAssociatedWholesalerList responseData =
            RetailerAssociatedWholesalerList.fromJson(
                jsonDecode(response.body));
        // if (page == 1) {
        retilerAssociationWholesalers.value = responseData.data!;
        // } else {
        //   retilerAssociationWholesalers.value.addAll(responseData.data!.data!);
        // }
        // if (page == 1) {
        if (!kIsWeb) {
          _localData.insert(
              TableNames.retailerAssociatedWholesalerList, responseData.data!);
        }
        // }
        // if (responseData.data!.nextPageUrl != null) {
        //   if (responseData.data!.nextPageUrl!.isNotEmpty) {
        //     wholesalerLoadMoreButton = true;
        //   } else {
        //     wholesalerLoadMoreButton = false;
        //   }
        // } else {
        //   wholesalerLoadMoreButton = false;
        // }
        notifyListeners();
      } on Exception catch (_) {
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void sortWholesalerList(String e) {
    if (e == "Status") {
      retilerAssociationWholesalers.value.sort((a, b) {
        String aDate = a.status!;
        String bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      retilerAssociationWholesalers.value.sort((a, b) {
        int aDate =
            DateTime.parse(a.associationDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.associationDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  void sortFieList(String e) {
    if (e == "Status") {
      retailerAssociationFie.value.sort((a, b) {
        String aDate = a.status!;
        String bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      retailerAssociationFie.value.sort((a, b) {
        int aDate =
            DateTime.parse(a.associationDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.associationDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  Future refreshRetailerWholesaler() async {
    retilerAssociationWholesalers.value.clear();
    await getRetailerWholesalerList();
  }

  Future refreshRetailerFie(int page) async {
    retailerAssociationFie.value.clear();
    await getRetailerFieList(page);
  }

  Future<void> getRetailerFieList(int page) async {
    bool connection = await checkConnectivity();
    dbHelper.queryAllRows(TableNames.retailerAssociatedFieList).then((value) {
      retailerAssociationFie.value =
          value.map((d) => RetailerAssociationFieListData.fromJson(d)).toList();
      notifyListeners();
    });

    if (connection) {
      try {
        Response response = await _webService
            .postRequest(("${NetworkUrls.retailerAssociatedFieList}$page"), {});
        RetailerAssociationFieList responseData =
            RetailerAssociationFieList.fromJson(jsonDecode(response.body));
        if (page == 1) {
          retailerAssociationFie.value = responseData.data!.data!;
        } else {
          retailerAssociationFie.value.addAll(responseData.data!.data!);
        }
        if (!kIsWeb) {
          if (page == 1) {
            _localData.insert(
                TableNames.retailerAssociatedFieList, responseData.data!.data!);
          }
        }
        if (responseData.data!.nextPageUrl != null) {
          if (responseData.data!.nextPageUrl!.isNotEmpty) {
            fieLoadMoreButton = true;
          } else {
            fieLoadMoreButton = false;
          }
        } else {
          fieLoadMoreButton = false;
        }
        notifyListeners();
      } on Exception catch (_) {
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<RetailerAssociationFieList> getRetailerFieListWeb(String page) async {
    Response response = await _webService
        .postRequest(("${NetworkUrls.retailerAssociatedFieList}$page"), {});
    RetailerAssociationFieList responseData =
        RetailerAssociationFieList.fromJson(jsonDecode(response.body));
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    return responseData;
  }

  Future<Failure> addRetailerBankAccounts(Map<String, String?> jsonBody) async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response = await _webService.postRequest(
          NetworkUrls.addEditRetailerBankAccount,
          jsonBody,
        );
        RetailerBankList responseData =
            RetailerBankList.fromJson(jsonDecode(response.body));
        retailsBankAccounts.value = responseData.data!;
        if (!kIsWeb) {
          _localData.insert(
              TableNames.retailerBankAccounts, responseData.data!);
        }
        notifyListeners();
        return Failure(
            status: responseData.success!, message: responseData.message!);
      } on Exception catch (_) {
        notifyListeners();
        rethrow;
      }
    } else {
      return Failure(status: false, message: ResponseMessage.noInternetError);
    }
  }

  Future<Failure> addRetailerBankAccountsWeb(Map<String, String?> body) async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response = await _webService.postRequest(
          NetworkUrls.addEditRetailerBankAccount,
          (body),
        );
        ResponseMessageModel responseData =
            ResponseMessageModel.fromJson(jsonDecode(response.body));

        notifyListeners();
        return Failure(
            status: responseData.success!, message: responseData.message!);
      } on Exception catch (_) {
        notifyListeners();
        rethrow;
      }
    } else {
      return Failure(status: false, message: ResponseMessage.noInternetError);
    }
  }

  Future accountValidation(Map<String, Object> body) async {
    bool connection = await checkConnectivity();
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            NetworkUrls.changeRetailerBankAccount, body);
        if ((jsonDecode(response.body))['success']) {
          await getRetailerBankAccounts();
          Utils.toast((jsonDecode(response.body))['message'], isBottom: true);
        } else {
          Utils.toast((jsonDecode(response.body))['message'], isBottom: true);
        }
      } else {
        if (activeContext.mounted) {
          Utils.toast(AppLocalizations.of(activeContext)!.noInternetError,
              isBottom: true);
        }
      }
    } catch (_) {
      rethrow;
    }
  }

  ReactiveValue<List<FinancialStatementsData>> financialStatements =
      ReactiveValue<List<FinancialStatementsData>>([]);
  ReactiveValue<List<SettlementsListData>> settlementList =
      ReactiveValue<List<SettlementsListData>>([]);
  String grandTotalFinancialStatements = "0.00";

  bool rFinStatLoadMoreButton = false;

  Future getRetailerFinancialStatements(int page, List<DateTime> date) async {
    try {
      Response response = await _webService
          .postRequest(NetworkUrls.retailerFinancialStatementsList, {});
      RetailerFinancialStatementModel responseData =
          RetailerFinancialStatementModel.fromJson(jsonDecode(response.body));
      Utils.fPrint(responseData.toJson().toString());
      if (page == 1) {
        financialStatements.value =
            responseData.data!.financialStatements!.data!;
      } else {
        financialStatements.value
            .addAll(responseData.data!.financialStatements!.data!);
      }
      if (responseData.data!.financialStatements!.nextPageUrl != null) {
        if (responseData.data!.financialStatements!.nextPageUrl!.isNotEmpty) {
          rFinStatLoadMoreButton = true;
        } else {
          rFinStatLoadMoreButton = false;
        }
      } else {
        rFinStatLoadMoreButton = false;
      }
      grandTotalFinancialStatements = responseData.data!.grandTotal!;

      notifyListeners();
    } catch (p) {
      Utils.fPrint('errorerror');
      Utils.fPrint(p.toString());
    }
  }

  List<RetailerSaleFinancialStatementsData>
      retailerSaleFinancialStatementsList = [];

  Future getRetailerFinancialDocuments(int page, String? saleUniqueId) async {
    try {
      Response response = await _webService.postRequest(
          NetworkUrls.retailerSaleFinancialStatementsList,
          {"sale_unique_id": saleUniqueId});
      RetailerSaleFinancialStatements responseData =
          RetailerSaleFinancialStatements.fromJson(jsonDecode(response.body));

      if (page == 1) {
        retailerSaleFinancialStatementsList =
            responseData.data!.financialStatements!.data!;
      } else {
        retailerSaleFinancialStatementsList
            .addAll(responseData.data!.financialStatements!.data!);
      }
      if (responseData.data!.financialStatements!.nextPageUrl != null) {
        if (responseData.data!.financialStatements!.nextPageUrl!.isNotEmpty) {
          rFinStatLoadMoreButton = true;
        } else {
          rFinStatLoadMoreButton = false;
        }
      } else {
        rFinStatLoadMoreButton = false;
      }

      notifyListeners();
    } catch (p) {
      Utils.fPrint(p.toString());
    }
  }

  Future<SettlementsListModel?> getRetailerSettlementList(String page) async {
    bool connection = await checkConnectivity();
    // dbHelper.queryAllRows(TableNames.retailerSettlementList).then((value) {
    //   settlementList.value =
    //       value.map((d) => SettlementsListData.fromJson(d)).toList();
    //
    //   notifyListeners();
    // });
    if (connection) {
      try {
        Response response = await _webService.getRequest(
          "${NetworkUrls.retailerSettlementList}$page",
        );
        SettlementsListModel responseData =
            SettlementsListModel.fromJson(jsonDecode(response.body));
        settlementList.value = responseData.data!.data!;
        // if (!kIsWeb) {
        //   _localData.insert(
        //       TableNames.retailerSettlementList, responseData.data!);
        // }

        notifyListeners();
        return responseData;
      } catch (_) {
        return null;
      }
    } else {
      Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      return null;
    }
  }

  void sortSettlementsList(String e) {
    if (e == "Status") {
      settlementList.value.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      settlementList.value.sort((a, b) {
        int aDate = DateTime.parse(a.postingDate ?? '').microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.postingDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  // ReactiveValue<List<SettlementDetailsData>> settlementDetailsDataExist =
  //     ReactiveValue<List<SettlementDetailsData>>([]);

  SettlementDetailsData settlementDetailsData = SettlementDetailsData();

  Future getRetailerSettlementDetails(String id) async {
    bool connection = await checkConnectivity();

    if (connection) {
      var jsonBody = {"lot_id": id, "type": "1"};
      try {
        Response response = await _webService.postRequest(
            NetworkUrls.retailerSettlementDetails, jsonBody);
        Utils.fPrint('responseData');
        Utils.fPrint(response.body);
        SettlementDetailsModel responseData =
            SettlementDetailsModel.fromJson(jsonDecode(response.body));
        settlementDetailsData = responseData.data!.first;
        // settlementDetailsDataExist.value.add(responseData.data![0]);
      } catch (e) {
        Utils.fPrint(e.toString());
      }
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
      _navigationService.pop();
    }
  }

  Future<RetailerApproveCreditlineRequest?> getRetailerCreditlineList() async {
    UserTypeForWeb enroll = locator<AuthService>().enrollment.value;
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        // String url=enroll==UserTypeForWeb.retailer?NetworkUrls.retailerApprovedCreditLinesList:;
        Response response = await _webService
            .postRequest(NetworkUrls.retailerApprovedCreditLinesList, {});
        Utils.fPrint('response');
        Utils.fPrint((response.body));
        RetailerApproveCreditlineRequest responseData =
            RetailerApproveCreditlineRequest.fromJson(
                jsonDecode(response.body));
        approveCreditlineRequestData.value = responseData.data!;
        notifyListeners();
        return responseData;
      } catch (e) {
        Utils.toast(e.toString());
      }
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
    return null;
  }

  void sortCreditlineList(String e) {
    if (e == "Status") {
      approveCreditlineRequestData.value.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      approveCreditlineRequestData.value.sort((a, b) {
        int aDate =
            DateTime.parse(a.expirationDate ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.expirationDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  List<DepositRecommendationData> depositRecommendationData = [];

  Future getDepositRecommendation(String v) async {
    bool connection = await checkConnectivity();
    try {
      if (connection) {
        Response response = await _webService.postRequest(
            NetworkUrls.retailerDepositRecommendation, {'date_filter': v});
        DepositRecommendation responseBody =
            DepositRecommendation.fromJson(jsonDecode(response.body));
        depositRecommendationData = responseBody.data!;
        notifyListeners();
      }
    } on HttpException {
      Utils.fPrint("Couldn't find the post 😱");
    } catch (_) {
      rethrow;
    }
  }

  ReactiveValue<List<RetailerUsersData>> retailersUserList =
      ReactiveValue<List<RetailerUsersData>>([]);
  bool retailUsersLoadMoreButton = false;

  Future getRetailersUser(int page) async {
    bool connection = await checkConnectivity();
    try {
      if (connection) {
        Response response = await _webService
            .getRequest(NetworkUrls.retailerUsersList + page.toString());
        Utils.fPrint(response.body);
        RetailerUsersModel responseData =
            RetailerUsersModel.fromJson(jsonDecode(response.body));
        notifyListeners();
        if (page == 1) {
          retailersUserList.value = responseData.data!.data!;
          notifyListeners();
        } else {
          retailersUserList.value.addAll(responseData.data!.data!);
          notifyListeners();
        }
        if (responseData.data!.nextPageUrl != null) {
          if (responseData.data!.nextPageUrl!.isNotEmpty) {
            retailUsersLoadMoreButton = true;
          } else {
            retailUsersLoadMoreButton = false;
          }
        } else {
          retailUsersLoadMoreButton = false;
        }
      }
    } on HttpException {
      Utils.fPrint("Couldn't find the post 😱");
    } catch (_) {
      rethrow;
    }
  }

  Future getCompanyProfile() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.getRequest(NetworkUrls.getCompanyProfile);
      Utils.fPrint('response.body1');
      Utils.fPrint(response.body);
      userCompanyProfile.value =
          GetCompanyProfile.fromJson(jsonDecode(response.body));
    } else {
      userCompanyProfile.value = GetCompanyProfile();
    }
    //{{url}}get-company-profile
  }

  List<RetailerBankAccountBalanceData> retailerBankAccountBalanceData = [];

  Future<void> getRetailerBankAccountBalance() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response = await _webService
          .getRequest(NetworkUrls.getRetailerBankAccountBalance);
      RetailerBankAccountBalanceModel data =
          RetailerBankAccountBalanceModel.fromJson(jsonDecode(response.body));
      retailerBankAccountBalanceData = data.data!;
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
  }

  Future<Response> inactiveUser(Map<String, Object?> body) async {
    Response response =
        await _webService.postRequest(NetworkUrls.inactiveRetailerUser, body);
    return response;
  }

  Future<ResponseMessages> addEditUser(
      Map<String, Object?> body, bool isEdit) async {
    String url =
        isEdit ? NetworkUrls.editRetailerUser : NetworkUrls.addRetailerUser;

    Response response = await _webService
        .postRequest(url, body)
        .catchError((e) => throw (e.toString()));
    Utils.fPrint('bodybody');
    Utils.fPrint(body.toString());
    Utils.fPrint(response.body);
    ResponseMessages responseBody =
        ResponseMessages.fromJson(jsonDecode(response.body));
    if (responseBody.success!) {
      await getRetailersUser(1);
      if (!kIsWeb) {
        _navigationService.pop();
      }
      Utils.toast(
        responseBody.message!,
        isSuccess: true,
        isBottom: true,
      );
    } else {
      Utils.toast(
        responseBody.message!,
        isSuccess: false,
      );
    }
    return responseBody;
  }

  void activateCreditLine(Map body) {
    Utils.fPrint("i am fully checked");
  }

  Future<void> inactiveCreditline(String s) async {
    bool connection = await checkConnectivity();
    if (connection) {
      var body = {"creditline_unique_id": s};
      Response response = await _webService.postRequest(
          NetworkUrls.makeActiveCreditlineInactive, body);
      ResponseMessages data =
          ResponseMessages.fromJson(jsonDecode(response.body));
      Utils.toast(data.message!, isSuccess: data.success!);
      await getRetailerCreditlineList();
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
  }

  Future<RetailerCreditLineRequestModel?> getCreditLinesListWeb(
      int page) async {
    try {
      Response response = await _webService
          .getRequest("${NetworkUrls.retailerCreditlineRequestList}$page");
      final responseData =
          RetailerCreditLineRequestModel.fromJson(jsonDecode(response.body));

      return responseData;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<ApproveCreditlineRequestData> getRetailerApprovedCreditLines(
      String id) async {
    Response response = await _webService
        .getRequest("${NetworkUrls.retailerApprovedCreditLines}$id");
    ApproveCreditlineRequestData data = ApproveCreditlineRequestData.fromJson(
        (jsonDecode(response.body))['data']);
    return data;
  }
}
