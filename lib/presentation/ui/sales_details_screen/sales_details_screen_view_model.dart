import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data_models/enums/user_roles_files.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '/const/app_extensions/strings_extention.dart';
import '/presentation/widgets/scanner_items/qr_alert_dialog.dart';
import '/repository/repository_sales.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../const/connectivity.dart';
import '../../../const/utils.dart';
import '../../../data_models/construction_model/sale_edit_data/sale_edit_data.dart';
import '../../../data_models/enums/sale_qr_states.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/confirmation_dialog.dart';
import '../../widgets/cards/statement_card.dart';

class SalesDetailsScreenViewModel extends ReactiveViewModel {
  SalesDetailsScreenViewModel() {
    checkInternet().then((value) => notifyListeners());
  }
  Future<void> checkInternet() async {
    ConnectivityResult data = (await Connectivity().checkConnectivity());
    if (data == ConnectivityResult.none) {
      connectivity = false;
    } else {
      connectivity = true;
    }
    notifyListeners();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('resultresult');
      print(result);
      if (result == ConnectivityResult.none) {
        connectivity = false;
        notifyListeners();
      } else {
        connectivity = true;
        notifyListeners();
      }
    });
  }

  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  AllSalesData allSalesData = AllSalesData();

  bool startPaymentButtonBusy = false;
  bool? isOfflineOrOnlineFromSaleList;

  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  void makeStartPaymentButtonBusy(bool v) {
    startPaymentButtonBusy = v;
    notifyListeners();
  }

  bool get isOnline => _repositoryComponents.internetConnection.value;

  bool connectivity = false;

  void startPayment(String id) async {
    bool confirm = await _navigationService.animatedDialog(ConfirmationDialog(
      title: AppLocalizations.of(activeContext)!.startPaymentTitle,
      content: AppLocalizations.of(activeContext)!.startPaymentBody,
    ));
    if (confirm) {
      makeStartPaymentButtonBusy(true);
      ResponseMessages? responseBody = await _repositorySales.createPayment(id);
      await _repositorySales.getWholesalersSalesData(1);

      Utils.toast(responseBody!.message!);
      if (responseBody.success!) {
        _navigationService.pop();
      }
      makeStartPaymentButtonBusy(false);
    } else {
      Utils.toast(AppLocalizations.of(activeContext)!.canceledPayment,
          isBottom: true);
    }
  }

  String getSalesType() {
    print(jsonEncode(allSalesData));
    if (allSalesData.saleType!.toLowerCase() == "1s") {
      return AppLocalizations.of(activeContext)!.s1s;
    } else {
      return AppLocalizations.of(activeContext)!.s2s;
    }
  }

  String getFormattedDate(String date) {
    String date0 = date.split(" ").first;
    return date.isNotEmpty
        ? DateFormat('MM/dd/yyyy').format(DateTime.parse(date0))
        : "-";
  }

  String getSaleId(String uId) {
    return uId.isNotEmpty
        ? "${AppLocalizations.of(activeContext)!.stars}${uId.lastChars(10)}"
        : "-";
  }

  cancelSale() async {
    bool isConfirmed =
        await _navigationService.animatedDialog(ConfirmationDialog(
      title: AppLocalizations.of(activeContext)!.cancelTheSale,
      content: AppLocalizations.of(activeContext)!.cancelTheSaleContent,
    ));
    if (isConfirmed) {
      makeButtonBusy(true);
      AllSalesData? data = await _repositorySales.cancelSales(
          allSalesData.uniqueId!,
          8,
          isFromToDo ? saleEditData!.routeZoneId! : "0");
      if (isFromToDo) {
        _navigationService.pop();
      }
      if (data != null) {
        allSalesData = data;
        notifyListeners();
      }

      makeButtonBusy(false);
    }
  }

  void openQRDialog() {
    if (enrollment == UserTypeForWeb.retailer) {}
    _navigationService.displayDialog(QRAlertDialog(allSalesData,
        state: SaleQrState.scanning,
        isRetailer: enrollment == UserTypeForWeb.retailer));
  }

  bool isButtonBusy = false;

  void makeButtonBusy(v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void rejectRequest() async {
    bool isConfirmed = await _navigationService.animatedDialog(
        ConfirmationDialog(
            ifYesNo: true,
            title: AppLocalizations.of(activeContext)!.confirmationDialogTitle,
            content:
                AppLocalizations.of(activeContext)!.confirmationRejectContent));
    if (isConfirmed) {
      makeButtonBusy(true);
      if (isOnline) {
        allSalesData = await _repositorySales.statusOnlineSales(
                allSalesData.uniqueId!,
                2,
                isFromToDo ? saleEditData!.routeZoneId! : "0") ??
            AllSalesData();
        notifyListeners();
      } else {
        await _repositorySales.statusOfflineSales(allSalesData, 2, 2);
        await Future.delayed(const Duration(seconds: 2));
      }
      makeButtonBusy(false);
    } else {
      Utils.toast(AppLocalizations.of(activeContext)!.salesRejectToast);
    }
    // _navigationService.displayDialog(QRAlertDialog(allSalesData));
  }

  void approveRequest() async {
    bool connection = await checkConnectivity();
    bool isConfirmed = await _navigationService.animatedDialog(
        ConfirmationDialog(
            ifYesNo: true,
            title: AppLocalizations.of(activeContext)!.confirmationDialogTitle,
            content: AppLocalizations.of(activeContext)!
                .confirmationApproveContent));
    if (isConfirmed) {
      makeButtonBusy(true);
      if (connection) {
        AllSalesData? data = await _repositorySales.statusOnlineSales(
            allSalesData.uniqueId!,
            1,
            isFromToDo ? saleEditData!.routeZoneId! : "0");
        print('datadatadata');
        print(data);
        if (data != null) {
          allSalesData = data;
          notifyListeners();
        }
        // if (allSalesData.saleType!.toLowerCase() == "1s") {
        //   allSalesData = await _repositorySales.statusOnlineSales(
        //           allSalesData.uniqueId!, 1) ??
        //       AllSalesData();
        //   // allSalesData.status = 1;
        //   // allSalesData.statusDescription =
        //   //     AppLocalizations.of(activeContext)!.statusSaleApprovedDelivered;
        // } else {
        //   allSalesData = await _repositorySales.statusOnlineSales(
        //           allSalesData.uniqueId!, 1) ??
        //       AllSalesData();
        //   // allSalesData.status = 4;
        //   // allSalesData.statusDescription =
        //   //     AppLocalizations.of(activeContext)!.statusSaleProposalApproved;
        // }
      } else {
        if (allSalesData.saleType!.toLowerCase() == "1s") {
          await _repositorySales.statusOfflineSales(allSalesData, 6, 1);
          await Future.delayed(const Duration(seconds: 2));
        } else {
          await _repositorySales.statusOfflineSales(allSalesData, 4, 1);
          await Future.delayed(const Duration(seconds: 2));
        }
      }
      notifyListeners();
      makeButtonBusy(false);
    } else {
      print(isConfirmed);
      Utils.toast(AppLocalizations.of(activeContext)!.salesApproveToast);
    }
    // _navigationService.displayDialog(QRAlertDialog(allSalesData));
  }

  void confirmDeliveryRequest() async {
    bool connection = await checkConnectivity();
    bool isConfirmed = await _navigationService.animatedDialog(
        ConfirmationDialog(
            title: AppLocalizations.of(activeContext)!.confirmationDialogTitle,
            content:
                AppLocalizations.of(activeContext)!.deliveryConfirmationBody));
    print(isConfirmed);
    if (isConfirmed) {
      makeButtonBusy(true);
      if (connection) {
        allSalesData = await _repositorySales.statusOnlineSales(
                allSalesData.uniqueId!,
                3,
                isFromToDo ? saleEditData!.routeZoneId! : "0") ??
            AllSalesData();

        notifyListeners();
        makeButtonBusy(false);
      } else {
        allSalesData =
            await _repositorySales.statusOfflineSales(allSalesData, 1, 3) ??
                AllSalesData();
        await Future.delayed(const Duration(seconds: 2));
        notifyListeners();
        makeButtonBusy(false);
      }
      makeButtonBusy(false);
    } else {
      print(isConfirmed);
      Utils.toast(AppLocalizations.of(activeContext)!.salesApproveToast);
    }
    // _navigationService.displayDialog(QRAlertDialog(allSalesData));
  }

  void deliverProduct() async {
    bool isConfirmed = await _navigationService.animatedDialog(
        ConfirmationDialog(
            title: AppLocalizations.of(activeContext)!.confirmationDialogTitle,
            content: AppLocalizations.of(activeContext)!
                .confirmationDeliverContent));
    print(isConfirmed);
    if (isConfirmed) {
      makeButtonBusy(true);
      if (isOnline) {
        await _repositorySales.statusOnlineSales(allSalesData.uniqueId!, 3,
            isFromToDo ? saleEditData!.routeZoneId! : "0");
        allSalesData.status = 1;
        allSalesData.statusDescription = "Sale Approved/Delivered";
        notifyListeners();
      } else {
        _repositorySales.statusOfflineSales(allSalesData, 1, 3);
        await Future.delayed(const Duration(seconds: 2));
      }
      makeButtonBusy(false);
    } else {
      print(isConfirmed);
      Utils.toast(AppLocalizations.of(activeContext)!.salesDeliverToast);
    }
    // _navigationService.displayDialog(QRAlertDialog(allSalesData));
  }

  setData(AllSalesData arguments) {
    print('allSalesDataallSalesData');
    print(allSalesData);
    allSalesData = arguments;
    notifyListeners();
  }

  setDataFromSaleList(OfflineOnlineSalesModel arguments) {
    allSalesData = arguments.allSalesData!;

    print('allSalesDataallSalesData');
    print(allSalesData);

    isOfflineOrOnlineFromSaleList = arguments.isOffline!;
    notifyListeners();
  }

  gotoEdit() async {
    allSalesData = await _navigationService.pushNamed(
        Routes.editSalesScreenView,
        arguments: SaleEditData(
            allSalesData: allSalesData,
            saleEditScreens: SaleEditScreens.saleList,
            routeZoneId: isFromToDo ? saleEditData!.routeZoneId! : null));
    print('allSalesDataallSalesData');
    print(jsonEncode(allSalesData));
    _repositorySales.openQrAfterAction(allSalesData);
    notifyListeners();
  }

  List<TranctionDetails> allTransaction = [];

  String get language => _authService.selectedLanguageCode;

  Future getSaleTransactionDetails() async {
    setBusyForObject(allTransaction, true);
    notifyListeners();
    await _repositorySales.getSaleTransactionDetails(allSalesData.uniqueId);
    allTransaction = _repositorySales.allTransaction;
    setBusyForObject(allTransaction, false);
    notifyListeners();
    if (allTransaction.isNotEmpty) {
      _navigationService.animatedDialog(
          StatementCard(allTransaction, language, allSalesData.invoiceNumber!));
    } else {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(AlertDialogMessage(
            "${AppLocalizations.of(activeContext)!.noTransectionMessage} "));
      }
    }
  }

  void readQrScanner(BuildContext context) async {
    String forWhom = enrollment == UserTypeForWeb.retailer
        ? allSalesData.wholesalerName!
        : allSalesData.retailerName!;
    _repositorySales.startBarcodeScanner2(
        context, enrollment == UserTypeForWeb.retailer, _authService.user.value,
        isFromSaleDetailsScreen: true, forWhom: forWhom);
  }

  void goBack() {
    startPaymentButtonBusy
        ? () {
            print("i m busy");
          }
        : _navigationService.pop();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryComponents];
  SaleEditData? saleEditData;
  bool isFromToDo = false;

  void setDataFromTodo(SaleEditData arguments) {
    isFromToDo = true;
    saleEditData = arguments;
    allSalesData = arguments.allSalesData;
    notifyListeners();
  }
}
