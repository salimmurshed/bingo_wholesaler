import 'dart:convert';
import 'dart:developer';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/presentation/web/requests/association_actions.dart';

import '../data_models/models/component_models/priceing_group_model.dart';
import '../data_models/models/delivery_method_model.dart';
import '../data_models/models/payment_methods_model.dart';
import '../data_models/models/product_summary_model.dart';
import '../data_models/models/promo_code_model/promo_code_model.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/const/utils.dart';
import '/data_models/enums/status_name.dart';
import '/data_models/models/routes_details_model/routes_details_model.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../app/app_secrets.dart';
import '../app/locator.dart';
import '../const/app_strings.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../const/special_key.dart';
import '../data_models/construction_model/routes_argument_model/routes_argument_model.dart';
import '../data_models/models/association_request_wholesaler_model/association_request_wholesaler_model.dart';
import '../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../data_models/models/component_models/response_model.dart';
import '../data_models/models/routes_model/routes_model.dart';
import '../data_models/models/sales_zone_details_model/sales_zone_details_model.dart';
import '../data_models/models/sales_zones/sales_zones.dart';
import '../data_models/models/today_decline_reason_model/today_decline_reason_model.dart';
import '../data_models/models/update_response_model/update_response_model.dart';
import '../data_models/models/wholesaler_credit_line_model/wholesaler_credit_line_model.dart';
import '../data_models/models/today_route_list_model/today_route_list_model.dart';
import '../main.dart';
import '../presentation/widgets/alert/alert_dialog.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/navigation/navigation_service.dart';
import '../services/network/network_info.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';

@lazySingleton
class RepositoryWholesaler with ListenableServiceMixin {
  RepositoryWholesaler() {
    listenToReactiveValues([
      setScreenBusy,
      wholesalerAssociationRequestDetailsReactive,
      wholesalerAssociationRequestDetails,
      wholesalerAssociationRequest,
      dynamicRoutes,
      todayRouteList,
      hasCreditLineNextPage
    ]);
    // _localData.delete(TableNames.countryTableName);
    // _localData.delete(TableNames.storeTableName);
    // _localData.delete(TableNames.wholesalerList);
    // _localData.delete(TableNames.fiaList);
    // _localData.delete(TableNames.retailerAssociationList);
    // _localData.delete(TableNames.wholeSalerAssociationList);
  }

  final dbHelper = DatabaseHelper.instance;
  var networkInfo = locator<NetworkInfoService>();
  final WebService _webService = locator<WebService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalData _localData = locator<LocalData>();
  ReactiveValue<TodayRouteListData> todayRouteList =
      ReactiveValue<TodayRouteListData>(TodayRouteListData());
  List<WholesalerCreditLineData> wholesalerCreditLineRequestData = [];

  ReactiveValue<List<AssociationRequestWholesalerData>>
      wholesalerAssociationRequest = ReactiveValue([]);
  ReactiveValue<AssociationWholesalerRequestDetailsModel>
      wholesalerAssociationRequestDetails =
      ReactiveValue(AssociationWholesalerRequestDetailsModel());
  ReactiveValue<List<AssociationWholesalerRequestDetailsModel>>
      wholesalerAssociationRequestDetailsReactive =
      ReactiveValue<List<AssociationWholesalerRequestDetailsModel>>([]);

  ReactiveValue<bool> setScreenBusy = ReactiveValue(false);

  int pageCreditLineWholesale = 1;
  int pageDynamicRoutes = 1;
  int pageStaticRoutes = 1;
  int pageSaleZones = 1;
  ReactiveValue<bool> hasCreditLineNextPage = ReactiveValue(false);
  bool hasDynamicRoutesNextPage = false;
  bool hasStaticRoutesNextPage = true;
  bool hasSaleZonesNextPage = true;

  //all Wholesaler Association list
  Future getWholesalersAssociationData() async {
    bool connection = await checkConnectivity();
    if (!kIsWeb) {
      dbHelper.queryAllRows(TableNames.wholeSalerAssociationList).then((value) {
        wholesalerAssociationRequest.value = value
            .map((d) => AssociationRequestWholesalerData.fromJson(d))
            .toList();
        notifyListeners();
      });
    }
    if (connection) {
      try {
        Response response = await _webService
            .getRequest((NetworkUrls.requestAssociationListForWholesaler));
        final responseData = AssociationRequestWholesalerModel.fromJson(
            jsonDecode(response.body));
        wholesalerAssociationRequest.value = responseData.data!;

        if (!kIsWeb) {
          _localData.insert(
              TableNames.wholeSalerAssociationList, responseData.data!);
        }
        await Future.delayed(const Duration(seconds: 1));
      } on Exception catch (e) {
        Utils.fPrint(e.toString());
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    }
    notifyListeners();
  }

  Future refreshWholesalersAssociationData() async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response = await _webService
            .getRequest((NetworkUrls.requestAssociationListForWholesaler));
        final responseData = AssociationRequestWholesalerModel.fromJson(
            jsonDecode(response.body));
        wholesalerAssociationRequest.value = responseData.data!;

        if (!kIsWeb) {
          _localData.insert(
              TableNames.wholeSalerAssociationList, responseData.data!);
        }
        wholesalerAssociationRequestDetailsReactive.value.clear();
        await Future.delayed(const Duration(seconds: 1));
      } on Exception catch (e) {
        Utils.fPrint(e.toString());
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    }
    notifyListeners();
  }

  Future getWholesalersAssociationDataLocal() async {
    dbHelper.queryAllRows(TableNames.wholeSalerAssociationList).then((value) {
      wholesalerAssociationRequest.value = value
          .map((d) => AssociationRequestWholesalerData.fromJson(d))
          .toList();
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> getWholesalersAssociationDetails(String uniqueId) async {
    try {
      setScreenBusy.value = true;
      notifyListeners();
      var jsonBody = {"unique_id": uniqueId};
      Response response = await _webService.postRequest(
        NetworkUrls.viewWholesalerRetailerAssociationRequest,
        jsonBody,
      );
      final responseData = AssociationWholesalerRequestDetailsModel.fromJson(
          jsonDecode(response.body));
      wholesalerAssociationRequestDetailsReactive.value.add(responseData);
      wholesalerAssociationRequestDetails.value = responseData;
      setScreenBusy.value = false;
      notifyListeners();
    } on Exception catch (_) {}
    notifyListeners();
  }

  Future<Response> updateWholesalerRetailerInternalProfile(data) async {
    Response response = await _webService.postRequest(
      NetworkUrls.updateWholesalerRetailerAssociationStatus,
      data,
    );
    return response;
  }

  //updateWholesalerRetailerAssociationStatus
  Future<UpdateResponseModel> updateWholesalerRetailerAssociationStatus(
      dynamic data, String uniqueId, int statusID) async {
    int index = wholesalerAssociationRequestDetailsReactive.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    Utils.fPrint('indexindex');
    Utils.fPrint(index.toString());
    notifyListeners();
    try {
      Response response = await _webService.postRequest(
        NetworkUrls.updateWholesalerRetailerAssociationStatus,
        data,
      );
      final responseData =
          UpdateResponseModel.fromJson(jsonDecode(response.body));

      wholesalerAssociationRequestDetailsReactive.value[index].data![0].companyInformation![0].status =
          statusID == 1
              ? describeEnum(StatusNames.accepted).toUpperCamelCase()
              : statusID == 3
                  ? describeEnum(StatusNames.verified).toUpperCamelCase()
                  : describeEnum(StatusNames.active).toUpperCamelCase();
      await getWholesalersAssociationData();
      if (statusID == 4) {
        wholesalerAssociationRequestDetailsReactive.value.removeAt(index);
        var jsonBody = {"unique_id": uniqueId};
        Response responseGet = await _webService.postRequest(
          NetworkUrls.viewWholesalerRetailerAssociationRequest,
          jsonBody,
        );

        final responseDataGet =
            AssociationWholesalerRequestDetailsModel.fromJson(
                jsonDecode(response.body));
        wholesalerAssociationRequestDetailsReactive.value.add(responseDataGet);
        wholesalerAssociationRequestDetails.value = responseDataGet;
        wholesalerAssociationRequest.value
            .removeWhere((element) => element.associationUniqueId == uniqueId);
        notifyListeners();
      }
      if (!responseData.success!) {
        _navigationService
            .animatedDialog(AlertDialogMessage(responseData.message!));
      }
      wholesalerAssociationRequestDetails.value =
          wholesalerAssociationRequestDetailsReactive.value[index];
      notifyListeners();
      return responseData;
    } on Exception {
      rethrow;
    }
  }

  Future<ResponseMessageModel> webWholesaler_RequsetSetPricing(
      dynamic data, List body2list) async {
    Response response = await _webService.postRequest(
      NetworkUrls.updateWholesalerRetailerAssociationStatus,
      data,
    );
    final responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future rejectRequest(dynamic data, String uniqueId) async {
    int index = wholesalerAssociationRequestDetailsReactive.value.indexWhere(
        (element) =>
            element.data![0].companyInformation![0].uniqueId == uniqueId);
    int index2 = wholesalerAssociationRequest.value
        .indexWhere((element) => element.uniqueId == uniqueId);
    Response response = await _webService.postRequest(
      NetworkUrls.updateRetailerWholesalerAssociationStatus,
      data,
    );
    final responseData =
        UpdateResponseModel.fromJson(jsonDecode(response.body));
    if (responseData.success!) {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteSuccessful));
      }
      wholesalerAssociationRequestDetailsReactive
          .value[index]
          .data![0]
          .companyInformation![0]
          .status = describeEnum(StatusNames.rejected).toUpperCamelCase();
      wholesalerAssociationRequest.value[index2].status =
          describeEnum(StatusNames.rejected).toUpperCamelCase();
      notifyListeners();
    } else {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(AlertDialogMessage(
            AppLocalizations.of(activeContext)!.rejectionCompleteUnsuccessful));
      }
    }
  }

  Future getCreditLinesList() async {
    bool connection = await checkConnectivity();
    pageCreditLineWholesale = 1;
    dbHelper
        .queryAllRows(TableNames.wholesalerCreditlineRequestList)
        .then((value) {
      wholesalerCreditLineRequestData =
          value.map((d) => WholesalerCreditLineData.fromJson(d)).toList();
    });
    if (connection) {
      try {
        Response response = await _webService.getRequest(
            ("${NetworkUrls.wholesalerCreditlineRequestList}$pageCreditLineWholesale"));
        final responseData =
            WholesalerCreditLineModel.fromJson(jsonDecode(response.body));
        log('responseData.toString()');
        log(responseData.data!.nextPageUrl!.isEmpty.toString());
        wholesalerCreditLineRequestData = responseData.data!.data!;
        if (responseData.data!.nextPageUrl!.isEmpty) {
          hasCreditLineNextPage.value = false;
          notifyListeners();
        } else {
          hasCreditLineNextPage.value = true;
          notifyListeners();
        }
        if (!kIsWeb) {
          _localData.insert(TableNames.wholesalerCreditlineRequestList,
              responseData.data!.data!);
        }
        await Future.delayed(const Duration(seconds: 1));
        notifyListeners();
      } on Exception catch (e) {
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    }
    notifyListeners();
  }

  Future refreshCreditLinesList() async {
    bool connection = await checkConnectivity();
    pageCreditLineWholesale = 1;

    if (connection) {
      try {
        Response response = await _webService.getRequest(
            ("${NetworkUrls.wholesalerCreditlineRequestList}$pageCreditLineWholesale"));
        final responseData =
            WholesalerCreditLineModel.fromJson(jsonDecode(response.body));
        wholesalerCreditLineRequestData = responseData.data!.data!;
        log('responseData.toString()');
        log(responseData.data!.nextPageUrl!.isEmpty.toString());
        if (responseData.data!.nextPageUrl!.isEmpty) {
          hasCreditLineNextPage.value = false;
          notifyListeners();
        } else {
          hasCreditLineNextPage.value = true;
          notifyListeners();
        }
        if (!kIsWeb) {
          _localData.insert(TableNames.wholesalerCreditlineRequestList,
              responseData.data!.data!);
        }
        await Future.delayed(const Duration(seconds: 1));
        notifyListeners();
      } on Exception catch (e) {
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    }
    notifyListeners();
  }

  Future getCreditLinesListLocal() async {
    pageCreditLineWholesale = 1;
    dbHelper
        .queryAllRows(TableNames.wholesalerCreditlineRequestList)
        .then((value) {
      wholesalerCreditLineRequestData =
          value.map((d) => WholesalerCreditLineData.fromJson(d)).toList();
    });
    notifyListeners();
  }

  Future loadMoreCreditLinesList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      pageCreditLineWholesale += pageCreditLineWholesale;
      try {
        Response response = await _webService.getRequest(
            ("${NetworkUrls.wholesalerCreditlineRequestList}$pageCreditLineWholesale"));
        final responseData =
            WholesalerCreditLineModel.fromJson(jsonDecode(response.body));
        wholesalerCreditLineRequestData.addAll(responseData.data!.data!);
        if (responseData.data!.nextPageUrl!.isEmpty) {
          hasCreditLineNextPage.value = false;
          notifyListeners();
        } else {
          hasCreditLineNextPage.value = true;
          notifyListeners();
        }
        notifyListeners();
      } on Exception catch (e) {
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
      notifyListeners();
    }
  }

  Future clearToDo() async {
    Response response =
        await _webService.deleteRequest(NetworkUrls.clearTodayRoutes);
    ResponseMessageModel responseModel =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    if (responseModel.success!) {
      todayRouteList.value = TodayRouteListData();
      notifyListeners();
    }
  }

////dynamicRoutes////
  ReactiveValue<List<RoutesModelData>> dynamicRoutes =
      ReactiveValue<List<RoutesModelData>>([]);
  RoutesDetailsModelData routesDetailsModelData = RoutesDetailsModelData();
  SaleZonesDetailsData saleZonesDetailsData = SaleZonesDetailsData();

  List<DateTime> dateDynamicRoutes = [
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now()
  ];

  Future changeDate(List<DateTime> dates) async {
    bool connection = await checkConnectivity();
    if (connection) {
      dateDynamicRoutes = dates;
      Utils.fPrint('dates');
      Utils.fPrint(dateDynamicRoutes.toString());
      await getDynamicRoutesList(dateChange: true);
    } else {
      Utils.toast(AppString.noInternetError);
    }
  }

  Future pullToRefreshDynamicRoutes() async {
    dateDynamicRoutes = [
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now()
    ];
    await getDynamicRoutesList();
  }

  Future<RoutesModel> getRouteZone(int page, String value,
      {List dateDynamicRoutes = const []}) async {
    if (Routes.zoneRouteDynamic == value) {
      var body = {
        SpecialKeys.startDate: dateDynamicRoutes[0],
        SpecialKeys.endDate: dateDynamicRoutes[1],
      };
      Response response = await _webService.postRequest(
          ("${NetworkUrls.dynamicRoutesUrl}${page.toString()}"), body);
      RoutesModel responseData =
          RoutesModel.fromJson(jsonDecode(response.body));
      return responseData;
    } else if (Routes.zoneRouteStatic == value) {
      Response response = await _webService
          .getRequest(("${NetworkUrls.staticRoutesUrl}${page.toString()}"));
      RoutesModel responseData =
          RoutesModel.fromJson(jsonDecode(response.body));
      return responseData;
    } else {
      Response response = await _webService
          .getRequest(("${NetworkUrls.getSaleZone}${page.toString()}"));
      RoutesModel responseData =
          RoutesModel.fromJson(jsonDecode(response.body));
      return responseData;
    }
  }

  Future getDynamicRoutesList({bool dateChange = false}) async {
    Utils.fPrint("i am called from notification");
    bool connection = await checkConnectivity();
    if (connection) {
      pageDynamicRoutes = 1;
      var body = {
        SpecialKeys.startDate:
            DateFormat(SpecialKeys.dateFormat).format(dateDynamicRoutes[0]),
        SpecialKeys.endDate:
            DateFormat(SpecialKeys.dateFormat).format(dateDynamicRoutes[1]),
        SpecialKeys.perPage: AppSecrets.perPageAmount.toString(),
      };
      Utils.fPrint('bodybodybodybody');
      Utils.fPrint(body.toString());
      Response response = await _webService.postRequest(
          ("${NetworkUrls.dynamicRoutesUrl}${pageDynamicRoutes.toString()}"),
          body);
      final responseData = RoutesModel.fromJson(jsonDecode(response.body));
      dynamicRoutes.value = responseData.data!.data!;
      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasDynamicRoutesNextPage = false;
        notifyListeners();
      } else {
        hasDynamicRoutesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    }
  }

  Future loadMoreDynamicRoutesList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      pageDynamicRoutes += pageDynamicRoutes;
      var body = {
        SpecialKeys.startDate:
            DateFormat(SpecialKeys.dateFormat).format(dateDynamicRoutes[0]),
        SpecialKeys.endDate:
            DateFormat(SpecialKeys.dateFormat).format(dateDynamicRoutes[1]),
        SpecialKeys.perPage: AppSecrets.perPageAmount.toString(),
      };
      Response response = await _webService.postRequest(
          ("${NetworkUrls.dynamicRoutesUrl}$pageDynamicRoutes"), body);
      final responseData = RoutesModel.fromJson(jsonDecode(response.body));
      dynamicRoutes.value.addAll(responseData.data!.data!);
      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasDynamicRoutesNextPage = false;
        notifyListeners();
      } else {
        hasDynamicRoutesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    } else {
      Utils.toast(AppString.noInternetError);
    }
  }

  Future getRoutesDetails(
      RoutesZoneArgumentModel routesZoneArgumentModel) async {
    bool connection = await checkConnectivity();
    if (connection) {
      var body = {
        SpecialKeys.uniqueId: routesZoneArgumentModel.uniqueId,
      };

      if (routesZoneArgumentModel.isZone) {
        Response response = await _webService.postRequest(
            NetworkUrls.manageSaleZoneDetails, body);
        SaleZonesDetailsModel saleZonesDetailsModel =
            SaleZonesDetailsModel.fromJson(jsonDecode(response.body));
        saleZonesDetailsData = saleZonesDetailsModel.data![0];
      } else {
        String uri = routesZoneArgumentModel.isDynamic
            ? NetworkUrls.dynamicRoutesDetails
            : NetworkUrls.staticRoutesDetails;
        Response response = await _webService.postRequest(uri, body);
        RoutesDetailsModel routesModel =
            RoutesDetailsModel.fromJson(jsonDecode(response.body));
        routesDetailsModelData = routesModel.data![0];
      }
    } else {
      Utils.fPrint(connection.toString());
    }
  }

  ////staticRoutes////
  ReactiveValue<List<RoutesModelData>> staticRoutes =
      ReactiveValue<List<RoutesModelData>>([]);

  Future pullToRefreshStaticRoutes() async {
    await getStaticRoutesList();
  }

  Future getStaticRoutesList() async {
    Utils.fPrint("i am called from notification");
    bool connection = await checkConnectivity();
    if (connection) {
      pageStaticRoutes = 1;
      Response response = await _webService.getRequest(
          ("${NetworkUrls.staticRoutesUrl}${pageStaticRoutes.toString()}"));

      final responseData = RoutesModel.fromJson(jsonDecode(response.body));
      staticRoutes.value = responseData.data!.data!;
      if (!kIsWeb) {
        _localData.insert(TableNames.staticRoutes, responseData.data!.data!);
      }
      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasStaticRoutesNextPage = false;
        notifyListeners();
      } else {
        hasStaticRoutesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    } else {
      dbHelper.queryAllRows(TableNames.staticRoutes).then((value) {
        staticRoutes.value =
            value.map((d) => RoutesModelData.fromJson(d)).toList();
        notifyListeners();
      });
    }
  }

  Future loadMoreStaticRoutesList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      pageStaticRoutes += pageStaticRoutes;

      Response response = await _webService
          .getRequest(("${NetworkUrls.staticRoutesUrl}$pageStaticRoutes"));

      final responseData = RoutesModel.fromJson(jsonDecode(response.body));
      staticRoutes.value.addAll(responseData.data!.data!);
      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasStaticRoutesNextPage = false;
        notifyListeners();
      } else {
        hasStaticRoutesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    } else {
      Utils.toast(AppString.noInternetError);
    }
  }

  ////SaleZonesData////
  ReactiveValue<List<SaleZonesData>> saleZones =
      ReactiveValue<List<SaleZonesData>>([]);

  Future pullToRefreshSalesZone() async {
    await getSalesZonesList();
  }

  Future getSalesZonesList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      pageSaleZones = 1;
      Response response = await _webService.getRequest(
          ("${NetworkUrls.getSaleZone}${pageSaleZones.toString()}"));
      Utils.fPrint('response');
      Utils.fPrint(response.toString());
      final responseData = SaleZones.fromJson(jsonDecode(response.body));
      saleZones.value = responseData.data!.data!;
      if (!kIsWeb) {
        _localData.insert(TableNames.salesZone, responseData.data!.data!);
      }

      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasSaleZonesNextPage = false;
        notifyListeners();
      } else {
        hasSaleZonesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    } else {
      dbHelper.queryAllRows(TableNames.salesZone).then((value) {
        saleZones.value = value.map((d) => SaleZonesData.fromJson(d)).toList();
        notifyListeners();
      });
    }
  }

  Future<SaleZones> getSalesZonesListWeb(int page) async {
    Response response = await _webService
        .getRequest(("${NetworkUrls.getSaleZone}${page.toString()}"));
    Utils.fPrint('responseresponseresponseresponse');
    Utils.fPrint(response.toString());
    SaleZones responseData = SaleZones.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future loadMoreSalesZonesListx() async {
    bool connection = await checkConnectivity();
    if (connection) {
      pageSaleZones += pageSaleZones;

      Response response = await _webService
          .getRequest(("${NetworkUrls.getSaleZone}$pageSaleZones"));

      final responseData = SaleZones.fromJson(jsonDecode(response.body));
      saleZones.value.addAll(responseData.data!.data!);
      if (responseData.data!.nextPageUrl!.isEmpty) {
        hasSaleZonesNextPage = false;
        notifyListeners();
      } else {
        hasSaleZonesNextPage = true;
        notifyListeners();
      }
      notifyListeners();
    } else {
      Utils.toast(AppString.noInternetError);
    }
  }

  Future getSalesZoneDetails(String uniqueId) async {
    bool connection = await checkConnectivity();
    if (connection) {
      var body = {
        SpecialKeys.uniqueId: uniqueId,
      };
      Response response = await _webService.postRequest(
          NetworkUrls.manageSaleZoneDetails, body);
      SaleZonesDetailsModel saleZonesDetailsModel =
          SaleZonesDetailsModel.fromJson(jsonDecode(response.body));
      saleZonesDetailsData = saleZonesDetailsModel.data![0];
    } else {
      Utils.fPrint(connection.toString());
    }
  }

  Future<void> addStaticRouteToTodoList(String uid, int t,
      {required bool isRoute}) async {
    try {
      Utils.fPrint('jsonBody');
      var jsonBody = isRoute
          ? {"route_id": uid, "replace": t.toString()}
          : {"zone_id": uid, "replace": t.toString()};
      Utils.fPrint(jsonBody.toString());

      String url = isRoute
          ? NetworkUrls.addRemoveTodayRoute
          : NetworkUrls.addRemoveTodayZone;
      Utils.fPrint(url);
      Response response = await _webService.postRequest(url, jsonBody);
      Utils.fPrint('jsonBody');
      Utils.fPrint(jsonBody.toString());
      Utils.fPrint(response.body);
      ResponseMessages responseData =
          ResponseMessages.fromJson(jsonDecode(response.body));
      Utils.fPrint(response.body);
      Utils.fPrint(url);
      if (responseData.success!) {
        // SchedulerBinding.instance.addPostFrameCallback((_) async {
        await getTodayRouteList();
        // });
        // await getTodayRouteList();
      }
      Utils.toast(responseData.message!);
      notifyListeners();
    } on Exception catch (_) {}
  }

  Future getTodayRouteList() async {
    Utils.fPrint('callcall');
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.getTodayRouteList);
      Utils.fPrint('response.body');
      Utils.fPrint(NetworkUrls.getTodayRouteList);
      TodayRouteListModel responseData =
          TodayRouteListModel.fromJson(jsonDecode(response.body));
      todayRouteList.value = responseData.data!;
      notifyListeners();
    } on Exception catch (_) {}
  }

  List<TodayDeclineReasonsData> todayDeclineReasons = [];

  Future<void> getTodayStoreDeclineReasonList() async {
    try {
      if (todayDeclineReasons.isEmpty) {
        Response response = await _webService
            .getRequest(NetworkUrls.getTodayStoreDeclineReasonList);
        TodayDeclineReasonsModel responseData =
            TodayDeclineReasonsModel.fromJson(jsonDecode(response.body));
        todayDeclineReasons = responseData.data ?? [];
        notifyListeners();
      }
    } catch (_) {}

    // try {
    //   Response response = await _webService
    //       .getRequest(NetworkUrls.getTodayStoreDeclineReasonList);
    //   TodayDeclineReasonsModel responseData =
    //       TodayDeclineReasonsModel.fromJson(jsonDecode(response.body));
    //   return responseData.data!;
    // } on Exception catch (_) {
    //   return null;
    // }
  }

  Future<void> markAsDone(Map<String, Object?> body) async {
    try {
      var response = await _webService.postRequest(
          NetworkUrls.updateTodayRouteStoreStatus, body);

      ResponseMessages responseData =
          ResponseMessages.fromJson(jsonDecode(response.body));
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      await getTodayRouteList();
      // });
      Utils.toast(responseData.message!);
      notifyListeners();
    } on Exception catch (_) {}
  }

  Future<PromoCodeModel> getPromoCode(String page) async {
    Response response = await _webService
        .postRequest(NetworkUrls.promoCodeList, {"page": page});
    PromoCodeModel data = PromoCodeModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> addEditPromoCode(
      Map<String, Object?> body) async {
    var response =
        await _webService.postRequest(NetworkUrls.addEditPromocode, body);
    Utils.fPrint(response.body);
    return ResponseMessageModel.fromJson(jsonDecode(response.body));
  }

  // Future<ResponseMessageModel?> associationAction(
  //     String uniqueId, AssociationActions action) async {
  //   String v = action.value.toString();
  //
  //   Response response = await _webService.postRequest(
  //       NetworkUrls.updateWholesalerRetailerAssociationStatus,
  //       {"unique_id": uniqueId, "action": v});
  //   ResponseMessageModel data =
  //       ResponseMessageModel.fromJson(jsonDecode(response.body));
  //   return data;
  // }

  Future<UpdateResponseModel?> associationActionForActivationCode(
      String uniqueId, AssociationActions action) async {
    String v = action.value.toString();
    Response response = await _webService.postRequest(
        NetworkUrls.updateWholesalerRetailerAssociationStatus,
        {"unique_id": uniqueId, "action": v});
    UpdateResponseModel data =
        UpdateResponseModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<WholesalerCreditLineModel?> getCreditLinesListWeb(int page) async {
    try {
      Response response = await _webService
          .getRequest("${NetworkUrls.wholesalerCreditlineRequestList}$page");
      final responseData =
          WholesalerCreditLineModel.fromJson(jsonDecode(response.body));

      return responseData;
    } on Exception catch (e) {
      _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      return null;
    }
  }

  Future<List<String>> getPricingGroups() async {
    Response response =
        await _webService.getRequest(NetworkUrls.pricingGroupsList);
    PricingGroupModel body =
        PricingGroupModel.fromJson(jsonDecode(response.body));
    List<String> data = body.data!.map((e) => e.pricingGroups ?? "").toList();

    return data;
  }

  Future<ProductSummaryModel> getPricingSummary() async {
    Response response = await _webService
        .postRequest(NetworkUrls.productListWithPriceGroup, {});
    ProductSummaryModel data =
        ProductSummaryModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<PaymentMethodsModel> getPaymentMethods() async {
    Response response =
        await _webService.getRequest(NetworkUrls.paymentMethods);
    PaymentMethodsModel data =
        PaymentMethodsModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> deletePaymentMethods(String? id) async {
    Response response =
        await _webService.deleteRequest("${NetworkUrls.paymentMethods}/$id");

    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> editPaymentMethods(
      String title, String id) async {
    if (id.isEmpty) {
      Response response = await _webService
          .postRequest(NetworkUrls.paymentMethods, {"payment_method": title});
      ResponseMessageModel data =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      Response response = await _webService.putRequest(
          "${NetworkUrls.paymentMethods}/$id", {"payment_method": title});
      ResponseMessageModel data =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      return data;
    }

    // ResponseMessageModel data =
    //     ResponseMessageModel.fromJson(jsonDecode(response.body));
    // return data;
  }

  Future<DeliveryMethodModel> getDeleveryMethods({String? id}) async {
    String url = "${NetworkUrls.deleveryMethods}${id == null ? '' : '/$id'}";
    Response response = await _webService.getRequest(url);
    DeliveryMethodModel data =
        DeliveryMethodModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> deleteDeleveryMethods(String? id) async {
    Response response =
        await _webService.deleteRequest("${NetworkUrls.deleveryMethods}/$id");
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> statusChangeDeleveryMethods(
      String? id, int status) async {
    Response response = await _webService.putRequest(
        "${NetworkUrls.deleveryMethods}/$id", {"status": status.toString()});
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> editDeleveryMethods(
      Map<String, Object?> body, String id) async {
    Response response = id.isEmpty
        ? await _webService.postRequest(NetworkUrls.deleveryMethods, (body))
        : await _webService.putRequest(
            "${NetworkUrls.deleveryMethods}/$id", (body));
    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessageModel> changeStaticRouteStatus(
      Map<String, Object> body, String screenType) async {
    String url = screenType == Routes.zoneRouteZone
        ? NetworkUrls.uri_updateManageSaleZoneLocationStatus
        : screenType == Routes.zoneRouteStatic
            ? NetworkUrls.uri_updateStaticRouteStatus
            : NetworkUrls.uri_updateDynamicRouteStatus;
    Response response = await _webService.postRequest(url, (body));
    print('response.body');
    print(response.body);
    ResponseMessageModel res =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return res;
  }
}
