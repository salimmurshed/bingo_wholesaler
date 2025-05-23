import 'dart:convert';
import 'dart:developer';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/data_models/enums/user_types.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';

import '../data_models/models/order_details_wholesaler/order_details_wholesaler.dart';
import '/const/special_key.dart';
import '/const/utils.dart';
import '/main.dart';
import '/services/network/web_service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../app/locator.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../data_models/models/all_order_model/all_order_model.dart';
import '../data_models/models/order_details/order_details.dart';
import '../data_models/models/order_selection_model/order_selection_model.dart';
import '../data_models/models/response_message_model/response_message_model.dart';
import '../data_models/models/wholesaler_for_order_model/wholesaler_for_order_model.dart';
import '../presentation/widgets/alert/alert_dialog.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/navigation/navigation_service.dart';
import '../services/network/network_urls.dart';

@lazySingleton
class RepositoryOrder with ListenableServiceMixin {
  final WebService _webService = locator<WebService>();

  final LocalData _localData = locator<LocalData>();
  final NavigationService _navigationService = locator<NavigationService>();
  final dbHelper = DatabaseHelper.instance;

  RepositoryOrder() {
    listenToReactiveValues(
        [orderSelectionModel, wholesalerForOrderData, orderLoadMoreButton]);
  }

  ReactiveValue<bool> orderLoadMoreButton = ReactiveValue<bool>(false);
  ReactiveValue<List<WholesalerForOrderData>> wholesalerForOrderData =
      ReactiveValue<List<WholesalerForOrderData>>([]);
  ReactiveValue<OrderSelectionModel> orderSelectionModel =
      ReactiveValue<OrderSelectionModel>(OrderSelectionModel());
  List<Promotions> promotionalImages = [];
  Map<String, String?> orderInfo = {};

  ReactiveValue<ResponseMessageModel> applyPromoCodeReplyMessage =
      ReactiveValue<ResponseMessageModel>(ResponseMessageModel());

  Future callWholesalerListForOrder() async {
    try {
      if (wholesalerForOrderData.value.isEmpty) {
        Response response =
            await _webService.getRequest(NetworkUrls.wholesalerListForOrder);
        WholesalerForOrderModel responseData =
            WholesalerForOrderModel.fromJson(jsonDecode(response.body));
        wholesalerForOrderData.value = responseData.data!;

        notifyListeners();
      }
    } on Exception catch (e) {
      _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
  }

  Future<void> callOrderInfo(
    Map<String, String?> body,
  ) async {
    // orderSelectionModel.value = OrderSelectionModel();
    orderInfo = body;
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.postRequest(NetworkUrls.orderSelection, body);
      Utils.fPrint("response.body");
      Utils.fPrint(response.body);
      orderSelectionModel.value = OrderSelectionModel();
      orderSelectionModel.value =
          OrderSelectionModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      Utils.fPrint('orderSelectionModel.value');
      Utils.fPrint(orderSelectionModel.value.data!.deliveryMethod.toString());
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
  }

  Future<OrderDetailWholesaler?> callOrderDetailer(
    Map<String, String?> body,
  ) async {
    // orderSelectionModel.value = OrderSelectionModel();
    orderInfo = body;
    bool connection = await checkConnectivity();
    if (connection) {
      Response response = await _webService.postRequest(
          NetworkUrls.viewWholesalerOrderDetails, body);
      OrderDetailWholesaler orderDetails =
          OrderDetailWholesaler.fromJson(jsonDecode(response.body));
      return orderDetails;
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
      return null;
    }
  }

  Future<void> callOrderInfoNew(
    Map<String, String?> body,
    String? selectedWholesaler,
    String? selectedStore,
  ) async {
    orderInfo = body;
    Utils.fPrint('orderInfo');
    Utils.fPrint(orderInfo.toString());
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.postRequest(NetworkUrls.orderSelection, body);
      orderSelectionModel.value =
          OrderSelectionModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      Utils.fPrint(orderSelectionModel.value.toString());
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
  }

  Future<Response> getOrderBanners() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.postRequest(NetworkUrls.orderSelection, {});
      OrderSelectionModel data =
          OrderSelectionModel.fromJson(jsonDecode(response.body));
      promotionalImages = data.data!.promotions!;
      Utils.fPrint('promotionalImages');
      Utils.fPrint(promotionalImages.toString());
      notifyListeners();
      return response;
    } else {
      throw "";
    }
  }

  ReactiveValue<List<AllOrderModelData>> allOrder =
      ReactiveValue<List<AllOrderModelData>>([]);

  Future getAllOrder(int pageNumber) async {
    Utils.fPrint('response.body.for.order.list');
    // UserTypeForWeb isRetailer = locator<AuthService>().enrollment.value;
    // if (!kIsWeb) {
    //   dbHelper.queryAllRows(TableNames.orderList).then((value) {
    //     allOrder.value =
    //         value.map((d) => AllOrderModelData.fromJson(d)).toList();
    //     Utils.fPrint('allOrder.value.length');
    //     Utils.fPrint(allOrder.value.length.toString());
    //     notifyListeners();
    //   });
    // }
    bool connection = await checkConnectivity();
    if (connection) {
      // String url = isRetailer == UserTypeForWeb.retailer
      //     ? NetworkUrls.retailerOrderList
      //     : NetworkUrls.wholesalerOrderList;
      Response response = await _webService
          .getRequest(("${NetworkUrls.retailerOrderList}$pageNumber"));

      AllOrderModel data = AllOrderModel.fromJson(jsonDecode(response.body));
      Utils.fPrint('response.body');
      log(response.body);
      if (pageNumber == 1) {
        allOrder.value = data.data!.data!;

        Utils.fPrint(data.data!.data!.length.toString());
        if (!kIsWeb) {
          await _localData.insert(TableNames.orderList, data.data!.data!);
        }
      } else {
        allOrder.value.addAll(data.data!.data!);
        Utils.fPrint(data.data!.data!.length.toString());
      }
      Utils.fPrint('allOrder.value.length');
      for (int i = 0; i < allOrder.value.length; i++) {
        Utils.fPrint(allOrder.value[i].uniqueId);
      }
      Utils.fPrint(allOrder.value.length.toString());
      if (data.data!.nextPageUrl != null) {
        if (data.data!.nextPageUrl!.isNotEmpty) {
          orderLoadMoreButton.value = true;
        } else {
          orderLoadMoreButton.value = false;
        }
      } else {
        orderLoadMoreButton.value = false;
      }
      notifyListeners();
    } else {
      // if (!kIsWeb) {
      //   dbHelper.queryAllRows(TableNames.orderList).then((value) {
      //     allOrder.value =
      //         value.map((d) => AllOrderModelData.fromJson(d)).toList();
      //     notifyListeners();
      //   });
      // }
    }
  }

  Future<AllOrderModel> getAllOrderWeb(
      String pageNumber, bool isRetailer) async {
    String uri = isRetailer
        ? NetworkUrls.retailerOrderList
        : NetworkUrls.wholesalerOrderList;
    Response response = await _webService.getRequest("$uri$pageNumber");

    AllOrderModel data = AllOrderModel.fromJson(jsonDecode(response.body));
    return data;
  }

  OrderDetail? orderDetail = OrderDetail();

  Future<OrderDetail?> getDetails(String orderUId) async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response = await _webService.postRequest(
          NetworkUrls.retailerOrderDetails, {SpecialKeys.uniqueId: orderUId});

      orderDetail = OrderDetail.fromJson(jsonDecode(response.body));
      Utils.fPrint('orderDetail');
      Utils.fPrint(jsonEncode(orderDetail));
      notifyListeners();
      return orderDetail;
    }
    return null;
  }

  void clearOrderSelection() {
    orderSelectionModel =
        ReactiveValue<OrderSelectionModel>(OrderSelectionModel());
  }

  void clearPromoCode() {
    applyPromoCodeReplyMessage =
        ReactiveValue<ResponseMessageModel>(ResponseMessageModel());
  }

  Future<bool> applyPromoCode(Map<String, String> body) async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.postRequest(NetworkUrls.applyPromoCode, body);
      applyPromoCodeReplyMessage.value =
          ResponseMessageModel.fromJson(jsonDecode(response.body));

      notifyListeners();
      return applyPromoCodeReplyMessage.value.success!;
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
      return false;
    }
  }

  Future<ResponseMessageModel> createOrder(Map<String, dynamic> body) async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.postRequest(NetworkUrls.addOrder, body);
      Utils.fPrint('response.body');
      Utils.fPrint(response.body);
      ResponseMessageModel responseData =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      await getAllOrder(1);
      return responseData;
    } else {
      if (activeContext.mounted) {
        return ResponseMessageModel(
            success: false,
            message: AppLocalizations.of(activeContext)!.noInternet);
      }
      return ResponseMessageModel(
          success: false,
          message: AppLocalizations.of(activeContext)!.noInternet);
    }
  }

  Future<ResponseMessageModel> createOrderWeb(Map<String, dynamic> body) async {
    Response response =
        await _webService.postRequest(NetworkUrls.addOrder, body);
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    ResponseMessageModel responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future<ResponseMessageModel> updateOrderWebWholesaler(
      Map<String, dynamic> body) async {
    Response response =
        await _webService.postRequest(NetworkUrls.wholesalerUpdateOrder, body);
    Utils.fPrint('response.body');
    Utils.fPrint(response.body);
    ResponseMessageModel responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return responseData;
  }
}
