import 'dart:convert';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:flutter/foundation.dart';

import '../app/app_secrets.dart';
import '../const/special_key.dart';
import '../const/utils.dart';
import '../services/notification_service/notification_servicee.dart';
import '/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import '../app/locator.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../data_models/models/notification_model/notification_model.dart';
import '../data_models/models/retailer_bank_list/retailer_bank_list.dart';

import '../main.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';
import '../services/storage/db.dart';
import '../services/storage/device_storage.dart';

@lazySingleton
class RepositoryNotification with ListenableServiceMixin {
  // final AuthService _authService = locator<AuthService>();
  final LocalData _localData = locator<LocalData>();
  final WebService _webService = locator<WebService>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  ReactiveValue<List<NotificationData>> allNotifications =
      ReactiveValue<List<NotificationData>>([]);
  ReactiveValue<String> notificationMessage = ReactiveValue<String>("");
  bool notificationLoadMoreButton = false;
  final dbHelper = DatabaseHelper.instance;

  bool get isRetailer => true;

  int notificationPageNumber = 1;
  ReactiveValue<int> unseenNotificationNumber = ReactiveValue<int>(0);

  Future getNotification() async {
    notificationPageNumber = 1;
    await getAllNotification(notificationPageNumber);
    notifyListeners();
  }

  getNotificationLoadMore() async {
    notificationPageNumber += 1;
    await getAllNotification(notificationPageNumber);
    notifyListeners();
    // .catchError((_) {});
  }

  Future getAllNotification(int page) async {
    bool connection = await checkConnectivity();

    try {
      if (connection) {
        Response response = await _webService.getRequest(
          isRetailer
              ? ("${NetworkUrls.retailerNotificationsList}$page")
              : ("${NetworkUrls.wholesalerNotificationsList}$page"),
        );
        final responseData =
            NotificationModel.fromJson(jsonDecode(response.body));

        if (responseData.success != null) {
          if (page == 1) {
            allNotifications.value = responseData.data!.data!;
            notificationMessage.value = responseData.message!;

            notifyListeners();
            if (!kIsWeb) {
              _localData.insert(
                  TableNames.notificationList, responseData.data!.data!);
            }
            notifyListeners();
          } else {
            allNotifications.value.addAll(responseData.data!.data!);
            notifyListeners();
          }
          if (responseData.data!.nextPageUrl != null) {
            if (responseData.data!.nextPageUrl!.isNotEmpty) {
              notificationLoadMoreButton = true;
            } else {
              notificationLoadMoreButton = false;
            }
          } else {
            notificationLoadMoreButton = false;
          }
        }
        notifyListeners();
      } else {
        List<Map<String, dynamic>> data =
            await dbHelper.queryAllRows(TableNames.notificationList);
        Utils.fPrint('allNotificationsallNotifications');
        allNotifications.value =
            data.map((d) => NotificationData.fromJson(d)).toList();
        notifyListeners();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<AllSalesData> getSaleDetails(String? targetUniqueId) async {
    Response response = await _webService.postRequest(
        NetworkUrls.retailerSalesDetails, {"unique_id": targetUniqueId});

    AllSalesData saleInfoFromNotification =
        AllSalesData.fromJson((jsonDecode(response.body))['data'][0]);
    return saleInfoFromNotification;
  }

  Future<AllSalesData> getSaleDetailsWholesaler(
      String? targetUniqueId, int i) async {
    Response response = await _webService
        .postRequest(NetworkUrls.getSaleDetails, {"unique_id": targetUniqueId});
    AllSalesData saleInfoFromNotification =
        AllSalesData.fromJson((jsonDecode(response.body))['data'][0]);
    return saleInfoFromNotification;
  }

  Future<RetailerBankListData> getBankDetails(String? targetUniqueId) async {
    Response response = await _webService.postRequest(
        (NetworkUrls.getRetailerBankAccountDetail),
        {"unique_id": targetUniqueId});

    RetailerBankListData responseBody =
        RetailerBankListData.fromJson((jsonDecode(response.body))['data']);
    return responseBody;
  }

  Future seenNotificationSend(String id) async {
    Response response = await _webService.postRequest(
        NetworkUrls.markAsReadNotification, {"unique_id": id, "action": "1"});
    if (response.statusCode == 200) {
      int index = allNotifications.value.indexWhere((e) => e.uniqueId == id);
      allNotifications.value[index].isRead = 1;
    }
  }

  RepositoryNotification() {
    listenToReactiveValues([
      allNotifications,
      unseenNotificationNumber,
    ]);
  }

  getNotificationCounter() async {
    Utils.fPrint("received notification");
    await prefs.reload();
    unseenNotificationNumber.value =
        _storage.getInt(DataBase.notificationNumber);
    notifyListeners();
  }

  Future<void> clearNotificationCounter() async {
    if (unseenNotificationNumber.value > 0) {
      await _storage.setInt(DataBase.notificationNumber, 0);
      await _storage.clearSingleData(DataBase.notificationNumber);

      await ClearAllNotifications.clear();
      unseenNotificationNumber.value = 0;
      await getNotification();
    }
  }

  Future<void> notificationCounter() async {
    unseenNotificationNumber.value =
        _storage.getInt(DataBase.notificationNumber);
    unseenNotificationNumber.value += 1;
    await _storage.setInt(
        DataBase.notificationNumber, unseenNotificationNumber.value);
    notifyListeners();
  }

//getDynamicRoutesList
  // getStaticRoutesList
  //getSalesZonesList
  Future<void> routeNotification(Map<String, dynamic> data) async {
    _showNotification(
        data['notification_type']
            .toString()
            .replaceAll("_changed", "")
            .replaceAll("_", " "),
        data['notification_type'].toString().replaceAll("_", " "));
    if (data['notification_type'] == SpecialKeys.routeType[0]) {
      _wholesaler.getDynamicRoutesList();
    } else if (data['notification_type'] == SpecialKeys.routeType[1]) {
      _wholesaler.getStaticRoutesList();
    } else if (data['notification_type'] == SpecialKeys.routeType[2]) {
      _wholesaler.getSalesZonesList();
    } else if (data['notification_type'] == SpecialKeys.routeType[3]) {
      _wholesaler.getTodayRouteList();
    } else {}

    notifyListeners();
  }

  Future<void> _showNotification(String body, String title) async {
    await NotificationUtils.flutterLocalNotificationsPlugin.show(
      0,
      title.toUpperCase(),
      "$body has been changed, please visit",
      NotificationUtils.platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }
}
