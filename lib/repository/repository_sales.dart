import 'dart:convert' as convert;
import 'dart:convert';

import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:flutter/foundation.dart';

import '../const/special_key.dart';
import '../data_models/enums/user_type_for_web.dart';
import '../data_models/models/failure.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';
import '/repository/repository_components.dart';
import '/repository/repository_retailer.dart';
import '/services/auth_service/auth_service.dart';
import '/services/network/web_service.dart';
import 'package:http/http.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../app/app_secrets.dart';
import '../app/router.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../data_models/enums/sale_qr_states.dart';
import '../data_models/models/all_sales_model/all_sales_model.dart';
import '../data_models/models/component_models/response_model.dart';
import '../data_models/models/component_models/retailer_list_model.dart';
import '../data_models/models/store_model/store_model.dart';
import '../data_models/models/update_response_model/update_response_model.dart';
import '../data_models/models/user_model/user_model.dart';
import '../main.dart';
import '../presentation/widgets/alert/alert_dialog.dart';
import '../presentation/widgets/scanner_items/qr_alert_dialog.dart';
import '../presentation/widgets/scanner_items/sale_scanner_dialog.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/navigation/navigation_service.dart';
import '../services/network/network_urls.dart';

@lazySingleton
class RepositorySales with ListenableServiceMixin {
  final LocalData _localData = locator<LocalData>();
  // final RepositoryComponents _repositoryComponents =
  //     locator<RepositoryComponents>();
  final WebService _webService = locator<WebService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();
  final dbHelper = DatabaseHelper.instance;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  ReactiveValue<bool> isSaleMessageShow = ReactiveValue(false);
  String saleMessage = "";

  List<AllSalesData> allSalesData = [];
  ReactiveValue<List<AllSalesData>> allSortedSalesData = ReactiveValue([]);
  ReactiveValue<List<AllSalesData>> allOfflineSalesData = ReactiveValue([]);
  AllSalesData lastSellItem = AllSalesData();

  ReactiveValue<bool> isLoadMoreAvailable = ReactiveValue<bool>(false);

  RepositorySales() {
    listenToReactiveValues([
      isLoadMoreAvailable,
      isSaleMessageShow,
      allSortedSalesData,
      allOfflineSalesData,
      pendingSaleData
    ]);
  }

  Future getSortedOnlineSale() async {
    await getWholesalersSalesDataOffline();
    notifyListeners();
  }

  void changeSaleMessageShow(isAdd) async {
    isSaleMessageShow.value = true;
    notifyListeners();
    saleMessage = isAdd
        ? AppLocalizations.of(activeContext)!.orderPlacedSuccessfully
        : AppLocalizations.of(activeContext)!.orderUpdateSuccessfully;
    await Future.delayed(const Duration(seconds: 10));
    lastSellItem = AllSalesData();
    isSaleMessageShow.value = false;
    notifyListeners();
  }

  bool getTestCheck() {
    return true;
  }

  Future<AllSalesModel?> addSales(
    Map<String, dynamic> body,
  ) async {
    try {
      Response response =
          await _webService.postRequest((NetworkUrls.addSales), body);
      ResponseMessages responseData =
          ResponseMessages.fromJson(jsonDecode(response.body));

      String lastSellItemID = responseData.data!;
      if (body[DataBaseHelperKeys.routeZone] == "0") {
        await getWholesalersSalesData(1).then((value) {
          // dbHelper
          //     .queryAllSortedRows(TableNames.salesList,
          //         DataBaseHelperKeys.uniqueId, lastSellItemID)
          //     .then((v) {
          //   lastSellItem = allSalesDataSqliteToModel(v);
          //   notifyListeners();
          // });
        });
        await getWholesalersSalesDataOffline();
        return AllSalesModel(
            success: responseData.success,
            message: responseData.message,
            data: SaleData(data: [lastSellItem]));
      } else {
        locator<RepositoryWholesaler>().getTodayRouteList();
        _navigationService.pop();
        return null;
      }

      // return lastSellItem;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseMessages?> addSalesWeb(
    Map<String, dynamic> body,
  ) async {
    try {
      Response response =
          await _webService.postRequest((NetworkUrls.addSales), body);
      ResponseMessages responseData =
          ResponseMessages.fromJson(jsonDecode(response.body));

      return responseData;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future addSalesOffline(Map<String, dynamic> body) async {
    Utils.fPrint(body.toString());
    try {
      if (!kIsWeb) {
        _localData.insertSingleData(TableNames.createTemSales, body);
      }

      lastSellItem =
          AllSalesData.fromJson(convert.jsonDecode(json.encode(body)));
      await getWholesalersSalesDataOffline();
      dbHelper.queryAllRows(TableNames.createTemSales).then((value) {
        Utils.fPrint(value.toString());
      });
    } on Exception catch (_) {}
  }

  Future<AllSalesData?> updateSales(Map<String, dynamic> body) async {
    try {
      Response response =
          await _webService.postRequest((NetworkUrls.updateSales), body);
      AllSalesModel responseData =
          AllSalesModel.fromJson(jsonDecode(response.body));
      Utils.fPrint('jsonDecode(response.body)');
      Utils.fPrint(jsonEncode(response.body));
      AllSalesData singleData =
          AllSalesData.fromJson(jsonDecode(response.body)["data"]);
      String lastSellItemID =
          convert.jsonDecode(response.body)["data"]["unique_id"];
      if (body[DataBaseHelperKeys.routeZone] == "0") {
        await getWholesalersSalesData(1).then((value) async {
          // dbHelper
          //     .queryAllSortedRowsSingle(
          //         TableNames.salesList, 'unique_id', lastSellItemID)
          //     .then((value) {
          //   lastSellItem = updateSalesDataSqliteToModel(value);
          // });

          await getSortedOnlineSale();
          notifyListeners();
        });
      } else {
        locator<RepositoryWholesaler>().getTodayRouteList();
      }
      Utils.toast(responseData.message!);
      await getWholesalersSalesDataOffline();

      return singleData;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<AllSalesModel> getSalesDetails(Map<String, dynamic> body) async {
    try {
      Response response =
          await _webService.postRequest((NetworkUrls.addSales), body);
      final responseData = AllSalesModel.fromJson(jsonDecode(response.body));
      await getWholesalersSalesData(1);
      await getWholesalersSalesDataOffline();

      return responseData;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> clearSale() async {
    allSalesData.clear();
    allSortedSalesData.value.clear();
    await getWholesalersSalesData(1);
  }

  Future getWholesalersSalesData(int pageNumber) async {
    bool connection = await checkConnectivity();

    if (connection) {
      String url = enrollment == UserTypeForWeb.retailer
          ? NetworkUrls.retailerSalesList
          : NetworkUrls.salesList;
      print('response.statusCode');
      print(url);
      try {
        Response response = await _webService.postRequest(
          url,
          {"page": pageNumber.toString()},
        );
        print('response.statusCode');
        print(response.statusCode);
        print(response.body);
        if (response.statusCode != 500) {
          final responseData =
              AllSalesModel.fromJson(jsonDecode(response.body));
          isLoadMoreAvailable.value =
              responseData.data!.nextPageUrl!.isEmpty ? false : true;

          allSalesData = responseData.data!.data!;

          // _localData.insert(TableNames.salesList, responseData.data!.data!);
          // await Future.delayed(const Duration(seconds: 1));

          notifyListeners();
          getSortedOnlineSale();
          notifyListeners();
        } else {
          isLoadMoreAvailable.value = false;
          _navigationService.displayDialog(
              AlertDialogMessage(response.reasonPhrase.toString()));
        }
      } on Exception catch (_) {
        isLoadMoreAvailable.value = false;
        notifyListeners();
        // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    } else {
      dbHelper.queryAllRows(TableNames.salesList).then((value) {
        allSalesData = value.map((d) => AllSalesData.fromJson(d)).toList();
      });
    }
  }

  int totalPage = 0;
  int saleTo = 0;
  int saleFrom = 0;
  int saleTotal = 0;

  Future getWholesalersSalesDataForWeb(int pageNumber, String? query) async {
    String url = enrollment == UserTypeForWeb.retailer
        ? query == null
            ? NetworkUrls.retailerSalesList
            : "${NetworkUrls.retailerSalesList}?search=$query"
        : query == null
            ? NetworkUrls.salesList
            : "${NetworkUrls.salesList}?search=$query";
    try {
      Response response = await _webService.postRequest(
        url,
        {"page": pageNumber.toString()},
      );

      if (response.statusCode != 500) {
        final responseData = AllSalesModel.fromJson(jsonDecode(response.body));
        totalPage = responseData.data!.lastPage!;
        saleTo = responseData.data!.to!;
        saleFrom = responseData.data!.from!;
        saleTotal = responseData.data!.total!;
        allSalesData = responseData.data!.data!;

        notifyListeners();
      } else {
        _navigationService.displayDialog(
            AlertDialogMessage(response.reasonPhrase.toString()));
      }
    } on Exception catch (_) {
      notifyListeners();
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
  }

  Future getWholesalersSalesDataLoadMore(int pageNumber) async {
    bool connection = await checkConnectivity();
    String url = enrollment == UserTypeForWeb.retailer
        ? NetworkUrls.retailerSalesList
        : NetworkUrls.salesList;
    if (connection) {
      try {
        Utils.fPrint("pagination1");
        Utils.fPrint(jsonEncode({
          // "per_page": AppSecrets.perPageAmount.toString(),
          "page": pageNumber.toString()
        }));
        Utils.fPrint("page type ${pageNumber.runtimeType}");
        Response response = await _webService.postRequest(url, {
          // "per_page": AppSecrets.perPageAmount.toString(),
          "page": pageNumber.toString()
        });
        final responseData = AllSalesModel.fromJson(jsonDecode(response.body));
        allSalesData.addAll(responseData.data!.data!);
        allSortedSalesData.value.addAll(responseData.data!.data!);
        await Future.delayed(Duration.zero);
        isLoadMoreAvailable.value =
            responseData.data!.nextPageUrl!.isEmpty ? false : true;
        notifyListeners();
        if (enrollment == UserTypeForWeb.retailer) {
          offlineCheckRetailerStore();
        }
      } on Exception catch (e) {
        Utils.fPrint(e.toString());
        isLoadMoreAvailable.value = false;
        notifyListeners();
      }
    }
  }

  Future getWholesalersSalesDataOffline() async {
    dbHelper
        .queryAllRowsByGroup(TableNames.createTemSales, "id DESC", 'unique_id')
        .then((value) {
      allOfflineSalesData.value.clear();
      List<AllSalesData> data =
          value.map((d) => AllSalesData.fromJson(d)).toList();
      for (var d in data) {
        if (allOfflineSalesData.value
            .every((element) => element.uniqueId != d.uniqueId)) {
          allOfflineSalesData.value.add(d);
        }
      }
      notifyListeners();
      allSortedSalesData.value = allSalesData
          .where((element) => !(allOfflineSalesData.value
              .any((e) => e.uniqueId == element.uniqueId)))
          .toList();
    });
    dbHelper.queryAllRows(TableNames.salesList).then((value) {
      allSalesData.sort((a, b) {
        int aDate = DateTime.parse(a.saleDate ?? '').microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.saleDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
      Utils.fPrint(value.toString());
    });
  }

  void sortList(String e) {
    if (e == "Status") {
      allSalesData.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      allSalesData.sort((a, b) {
        int aDate = DateTime.parse(a.saleDate ?? '').microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.saleDate ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }
  }

  List<RetailerListData> get retailerList =>
      locator<RepositoryComponents>().retailerList;

  // List<StoreList> get storeList => _repositoryComponents.storeList;
  List<StoreData> get storeList => _repositoryRetailer.storeList;
  final key1 = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(32);

  Future<AllSalesData> startBarcodeScanner2(
      BuildContext context, bool isRetailer, UserModel user,
      {bool isFromSaleDetailsScreen = false, String forWhom = ""}) async {
    bool connection = await checkConnectivity();
    await Permission.camera.request();
    String? barcode;
    var p;
    try {
      Barcode d = await _navigationService.animatedDialog(SaleScannerDialog(
          isFromSaleDetailsScreen: isFromSaleDetailsScreen,
          forWhom: forWhom,
          isRetailer: isRetailer));

      barcode = Utils.encrypter.decrypt64(d.code!, iv: SpecialKeys.iv);

      p = json.decode(jsonEncode(jsonDecode(jsonDecode(barcode))));

      Utils.fPrint("ppsspsps ${p['e']}");
      // barcode = Encryptor.decrypt(AppSecrets.qrKey, d.code!);
      Utils.fPrint(p);
    } catch (_) {}

    if (barcode != null) {
      try {
        String wholesalerName = "";
        String retailerName = "";
        if (!isRetailer) {
          RetailerListData data =
              retailerList.firstWhere((element) => element.bpIdR == p['f']);
          retailerName = data.retailerName!;
          Utils.fPrint('wholesalerName');
          Utils.fPrint(retailerName);
        } else {
          var v = await dbHelper.queryAllSortedRowsSingle(
              TableNames.wholesalerList, DataBaseHelperKeys.uniqueId, p['e']);
          wholesalerName = v['name'];
        }

        AllSalesData allSalesData =
            saleData(p, isRetailer, wholesalerName, user, retailerName);
        if (isRetailer) {
          if (allSalesData.retailerTempTxAddress == user.data!.tempTxAddress!) {
            try {
              // if (connection) {
              //   Utils.fPrint(connection);
              // } else {
              int id = await _localData.insertSingleDataSales(
                  TableNames.createTemSales, allSalesData);
              dbHelper
                  .queryAllSortedRowsSingle(
                      TableNames.createTemSales, DataBaseHelperKeys.id, id)
                  .then((value) {
                _navigationService.pushNamed(Routes.salesDetailsScreen,
                    arguments: allSalesData);
              });
              await getWholesalersSalesDataOffline(); //barcode
              // _navigationService.displayDialog(QRAlertDialog(
              //   allSalesData,
              //   state: SaleQrState.scanning,
              // ));
              // }
              notifyListeners();
            } on Exception catch (_) {}
          } else {
            if (activeContext.mounted) {
              _navigationService.displayBottomSheet(AlertDialogMessage(
                  AppLocalizations.of(activeContext)!.saleNotForYou));
            }
          }
        } else if (!isRetailer) {
          if (allSalesData.wholesalerTempTxAddress ==
              user.data!.tempTxAddress!) {
            try {
              int id = await _localData.insertSingleDataSales(
                  TableNames.createTemSales, ((allSalesData)));
              dbHelper
                  .queryAllSortedRowsSingle(
                      TableNames.createTemSales, DataBaseHelperKeys.id, id)
                  .then((v) {
                Future.delayed(Duration.zero).then((_) {
                  _navigationService.pushNamed(Routes.salesDetailsScreen,
                      arguments: allSalesData);
                });
              });
              await getWholesalersSalesDataOffline();
              // _navigationService.displayDialog(QRAlertDialog(
              //   allSalesData,
              //   state: SaleQrState.scanning,
              // ));
              if (connection) {
                //DIRECT ONLINE SALE FROM QR
                await offlineApiCall();
                notifyListeners();
              }
              notifyListeners();
            } on Exception catch (_) {}
          } else {
            if (activeContext.mounted) {
              _navigationService.displayBottomSheet(AlertDialogMessage(
                  AppLocalizations.of(activeContext)!.saleNotForYou));
            }
          }
        } else {
          if (activeContext.mounted) {
            _navigationService.displayBottomSheet(AlertDialogMessage(
                AppLocalizations.of(activeContext)!.saleNotForYou));
          }
        }

        return allSalesData;
      } on Exception catch (_) {}
    }

    return AllSalesData();
  }

  AllSalesData saleData(dynamic barcode, bool isRetailer, String wholesalerName,
      UserModel user, String retailerName) {
    return AllSalesData.fromJson({
      'unique_id': barcode['1'],
      'invoice_number': (barcode)['2'],
      'order_number': (barcode)['3'],
      'sale_date': (barcode)['4'],
      'bp_id_r': (barcode)['f'],
      'store_id': (barcode)['6'], //
      'wholesaler_name': isRetailer
          ? wholesalerName
          : "${user.data!.firstName!} ${user.data!.lastName!}",
      'retailer_name': isRetailer
          ? "${user.data!.firstName!} ${user.data!.lastName!}"
          : retailerName,
      'wholesaler_store_id': (barcode)['c'],
      'bingo_order_id': (barcode)['9'],
      'fie_name': (barcode)['d'],
      'sale_type': (barcode)['5'],
      'due_date': "",
      'currency': (barcode)['7'],
      'amount': (barcode)['8'],
      'status': (barcode)['a'],
      'description': (barcode)['b'],
      'wholesaler_temp_tx_address': (barcode)['e'],
      'retailer_temp_tx_address': (barcode)['f'],
      'status_description':
          int.parse((barcode)['a'].toString()).toSaleStatusDes(),
      'is_start_payment': (barcode)['g'],
      'balance': (barcode)['h'],
      'is_app_unique_id': (barcode)['i'],
      'action': (barcode)['j']
    });
  }

  Future<AllSalesData?> statusOnlineSales(
      String uniqueId, int action, String routeZoneId) async {
    try {
      var body = {
        "unique_id": uniqueId,
        "action": action.toString(),
        DataBaseHelperKeys.routeZone: routeZoneId
      };

      Response response =
          await _webService.postRequest(NetworkUrls.updateSalesStatus, body);
      AllSalesModel responseModel =
          AllSalesModel.fromJson(jsonDecode(response.body));
      Utils.fPrint('responseModel');
      Utils.fPrint(body.toString());
      Utils.fPrint(jsonEncode(responseModel));
      if (responseModel.success!) {
        await getWholesalersSalesData(1);
        await getWholesalersSalesDataOffline();
        await getDashboardPendingSales();

        AllSalesData data =
            allSalesData.where((element) => element.uniqueId == uniqueId).first;
        Utils.fPrint('datadatadatadatadata');
        Utils.fPrint(jsonEncode(data));
        Utils.fPrint(jsonEncode(body));
        if (routeZoneId == '0') {
          openQrAfterAction(data);
        } else {
          _navigationService.pop();
        }

        Utils.toast(responseModel.message!, isBottom: true);
        return data;
      } else {
        _navigationService
            .animatedDialog(AlertDialogMessage(responseModel.message!));
      }
    } catch (e) {
      Utils.fPrint(e.toString());
    }
    return null;
  }

  Future<AllSalesData?> statusOfflineSales(
      AllSalesData allSalesData, int status, int action) async {
    bool connection = await checkConnectivity();
    if (!connection) {
      try {
        AllSalesData data = allSalesData;
        data.status = status;
        data.action = action.toString();
        if (status == 2) {
          data.statusDescription = "Sale Reject";
        } else if (status == 6) {
          data.statusDescription = "Sale Approved";
        } else if (status == 4) {
          data.statusDescription = "Sale Proposal Pending Approval";
        } else if (status == 7) {
          data.statusDescription = "Pending Delivery Confirmation";
        } else if (status == 1) {
          data.statusDescription = "Sale Approved/Delivered";
        }
        if (!kIsWeb) {
          _localData.insertSingleData(
              TableNames.createTemSales, jsonDecode(jsonEncode(data)));
        }
        await getSortedOnlineSale();
        allSalesData = data;
        openQrAfterAction(data);
        notifyListeners();

        return data;
      } on Exception catch (e) {
        Utils.fPrint(e.toString());
      }
    }
    return null;
  }

  Future<ResponseMessageModel?> statusChangeSalesWeb(
      Map<String, String> body) async {
    Response response =
        await _webService.postRequest(NetworkUrls.updateSalesStatus, body);
    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  openQrAfterAction(AllSalesData data) {
    _navigationService.displayDialog(QRAlertDialog(
      data,
      state: SaleQrState.scanning,
      isRetailer: enrollment == UserTypeForWeb.retailer,
    ));
  }

  Future<AllSalesData?> cancelSales(
      String uniqueId, int status, String? routeZoneId) async {
    bool connection = await checkConnectivity();

    if (connection) {
      try {
        var body = {
          "unique_id": uniqueId,
          "action": status.toString(),
          DataBaseHelperKeys.routeZone: routeZoneId
        };
        Utils.fPrint(body.toString());
        Response response =
            await _webService.postRequest(NetworkUrls.cancelSalesq, body);

        UpdateResponseModel responseModel =
            UpdateResponseModel.fromJson(jsonDecode(response.body));
        if (responseModel.success!) {
          if (routeZoneId == '0') {
            await getWholesalersSalesData(1);
            AllSalesData data = allSalesData
                .where((element) => element.uniqueId == uniqueId)
                .first;
            openQrAfterAction(data);
            if (activeContext.mounted) {
              Utils.toast(
                  AppLocalizations.of(activeContext)!.saleCancellMessage);
            }
            return data;
          } else {
            locator<RepositoryWholesaler>().getTodayRouteList();
            if (activeContext.mounted) {
              Utils.toast(
                  AppLocalizations.of(activeContext)!.saleCancellMessage);
            }
            return null;
          }
        } else {
          _navigationService
              .animatedDialog(AlertDialogMessage(responseModel.message!));
          return null;
        }
      } catch (e) {
        Utils.fPrint(e.toString());
      }
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.needInternetMessage);
      }
      return null;
    }
    return null;
  }

  Future<ResponseMessageModel?> cancelSalesWeb(String uniqueId) async {
    var body = {"unique_id": uniqueId};
    Utils.fPrint(body.toString());
    Response response =
        await _webService.postRequest(NetworkUrls.cancelSalesq, body);
    ResponseMessageModel data =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<ResponseMessages?> createPayment(String id) async {
    bool connection = await checkConnectivity();
    if (connection) {
      var body = {"sale_unique_id": id};
      Response response =
          await _webService.postRequest(NetworkUrls.createPayment, body);
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

  ReactiveValue<List<AllSalesData>> pendingSaleData =
      ReactiveValue<List<AllSalesData>>([]);

  Future getDashboardPendingSales() async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response = await _webService
            .postRequest(NetworkUrls.retailerPendingSalesList, {});
        List<dynamic> d = (jsonDecode(response.body))['data'];
        pendingSaleData.value = d.map((e) => AllSalesData.fromJson(e)).toList();

        notifyListeners();
      } catch (e) {
        Utils.fPrint('pendingSaleData2');
        Utils.fPrint(e.toString());
      }
    } else {
      // if (activeContext.mounted) {
      //   Utils.toast(AppLocalizations.of(activeContext)!.needInternetMessage);
      // }
    }
  }

  ReactiveValue<bool> isAppBusy = ReactiveValue<bool>(false);

  Future offlineSalesAddToServer() async {
    bool connection = await checkConnectivity();
    if (connection && enrollment == UserTypeForWeb.wholesaler) {
      if (allOfflineSalesData.value.isNotEmpty) {
        Utils.toast("Start of Offline uploading");
        await offlineApiCall();
        Utils.toast("End of Offline uploading");
      }
    } else if (connection && enrollment == UserTypeForWeb.retailer) {
      if (allOfflineSalesData.value.isNotEmpty) {
        await offlineCheckRetailerStore();
      }
    }
  }

  offlineCheckRetailerStore() {
    dbHelper.queryAllRows(TableNames.createTemSales).then((value) async {
      List<JMap> groupedData = groupById(value);
      allOfflineSalesData.value.removeWhere((element) =>
          element.uniqueId == groupedData[0][DataBaseHelperKeys.uniqueId]);
      if (groupedData.isNotEmpty) {
        dbHelper.deleteData(TableNames.createTemSales,
            groupedData[0][DataBaseHelperKeys.uniqueId]);
      }
    });
    // getWholesalersSalesData(1);
  }

  Future offlineApiCall() async {
    Utils.fPrint("offline connection");
    Utils.fPrint(allOfflineSalesData.value.toString());
    if (allOfflineSalesData.value.isNotEmpty) {
      dbHelper.queryAllRows(TableNames.createTemSales).then((value) async {
        List<JMap> groupedData = groupById(value);
        Utils.fPrint(groupedData.toString());
        Utils.fPrint('groupedData.length');
        Utils.fPrint(groupedData.length.toString());
        Utils.fPrint(groupedData.toString());
        Utils.fPrint(value.toString());
        for (int i = 0; i < groupedData.length; i++) {
          callOfflineApi(groupedData[i]['data']);
        }
      });
      notifyListeners();
    }
  }

  Future callOfflineApi(groupedData) async {
    var headers = _webService.headers;
    var request =
        http.Request('POST', Uri.parse(NetworkUrls.wholesalerSyncOfflineSales));
    request.body = jsonEncode({"data": groupedData});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      allOfflineSalesData.value.removeWhere((element) =>
          element.uniqueId == groupedData[0][DataBaseHelperKeys.uniqueId]);
      dbHelper.deleteData(TableNames.createTemSales,
          groupedData[0][DataBaseHelperKeys.uniqueId]);
      getWholesalersSalesData(1);
    } else {
      Utils.fPrint(response.reasonPhrase);
    }
  }

  List<TranctionDetails> allTransaction = [];

  Future<List<TranctionDetails>> getSaleTransactionDetails(
      String? uniqueId) async {
    Response response = await _webService.postRequest(
        NetworkUrls.retailerSalesTransactionDetails, {"unique_id": uniqueId});
    allTransaction = TranctionDetails.fromJsonList(
        (jsonDecode(response.body))['data'][0]['tranction_details']);
    return allTransaction;
  }

  Future addSaleZone(Map<String, String> body, bool isEdit) async {
    Response response = await _webService.postRequest(
        isEdit ? NetworkUrls.updateSaleZoneDetails : "", body);
    return response;
  }
}

typedef JMap = Map<String, dynamic>;

List<JMap> groupById(List<Map<String, dynamic>> value) {
  List<JMap> result = [];
  value.map((m) => m[DataBaseHelperKeys.uniqueId]).toSet().forEach((e) {
    result.add({
      DataBaseHelperKeys.uniqueId: e,
      'data': value
          .where((m) => m[DataBaseHelperKeys.uniqueId] == e)
          .map((m) => {
                DataBaseHelperKeys.uniqueId: m[DataBaseHelperKeys.uniqueId],
                DataBaseHelperKeys.isAppUniqId:
                    m[DataBaseHelperKeys.isAppUniqId] ?? 0,
                DataBaseHelperKeys.bpIdR: m[DataBaseHelperKeys.bpIdR],
                DataBaseHelperKeys.storeId: m[DataBaseHelperKeys.storeId],
                DataBaseHelperKeys.wholesalerStoreId:
                    m[DataBaseHelperKeys.wholesalerStoreId],
                DataBaseHelperKeys.saleType: m[DataBaseHelperKeys.saleType],
                DataBaseHelperKeys.invoiceNumber:
                    m[DataBaseHelperKeys.invoiceNumber],
                DataBaseHelperKeys.orderNumber:
                    m[DataBaseHelperKeys.orderNumber],
                DataBaseHelperKeys.currency: m[DataBaseHelperKeys.currency],
                DataBaseHelperKeys.amount:
                    double.parse(m[DataBaseHelperKeys.amount]),
                DataBaseHelperKeys.description:
                    m[DataBaseHelperKeys.description],
                DataBaseHelperKeys.status:
                    m[DataBaseHelperKeys.status].toString() == "1" ? 1 : 0,
                DataBaseHelperKeys.action: m[DataBaseHelperKeys.action]
                // m[DataBaseHelperKeys.status].toString() == "1"
                //     ? 1
                //     : m[DataBaseHelperKeys.status].toString() == "2"
                //         ? 2
                //         : m[DataBaseHelperKeys.status].toString() == "7"
                //             ? 3
                //             : 0
              })
          .toList()
    });
  });
  return result;
}
