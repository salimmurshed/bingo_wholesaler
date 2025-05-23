import 'dart:convert';

import 'package:bingo/repository/repository_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../const/connectivity.dart';
import '../../../const/database_helper.dart';
import '../../../data_models/construction_model/sale_edit_data/sale_edit_data.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../main.dart';
import '../../../repository/repository_sales.dart';
import '../../../services/navigation/navigation_service.dart';

class EditSalesScreenViewModel extends BaseViewModel {
  EditSalesScreenViewModel() {
    _repositorySales.getWholesalersSalesDataOffline();
  }

  final RepositorySales _repositorySales = locator<RepositorySales>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();

  String retailer = "";
  String wholesalerStoreId = "";
  String fieName = "";
  String dateOfInvoice = "";
  String dueDate = "";
  String currency = "";
  String amount = "";
  String currentAmount = "";
  String orderValidation = "";
  String invoiceValidation = "";
  String saleType = "";

  TextEditingController invoiceController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController ammountController = TextEditingController();

  AllSalesData allSalesData = AllSalesData();

  bool isButtonBusy = false;

  void setButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  SaleEditScreens? saleEditScreens;
  String? routeId;

  void setDetails(SaleEditData saleEditData) {
    print('saleEditData');
    print(saleEditData.routeZoneId);
    routeId = saleEditData.routeZoneId;
    // AllSalesData arguments = saleEditData.allSalesData;
    saleEditScreens = saleEditData.saleEditScreens;
    allSalesData = saleEditData.allSalesData;
    retailer = allSalesData.retailerName ?? "";
    wholesalerStoreId = saleEditData.allSalesData.wholesalerStoreId!;
    // saleType = arguments.saleType!;
    if (saleEditData.allSalesData.saleType!.toLowerCase() == "1s") {
      saleType = AppLocalizations.of(activeContext)!.s1s;
      notifyListeners();
    } else {
      saleType = AppLocalizations.of(activeContext)!.s2s;
      ammountController.text = saleEditData.allSalesData.amount!;
      notifyListeners();
    }
    fieName = saleEditData.allSalesData.fieName!;
    dateOfInvoice = saleEditData.allSalesData.saleDate!;
    dueDate = saleEditData.allSalesData.dueDate!;
    currency = saleEditData.allSalesData.currency!;
    amount = saleEditData.allSalesData.amount!.toString();
    // currentAmount = arguments.currency!;
    if (saleEditData.allSalesData.invoiceNumber! != "-") {
      invoiceController.text = saleEditData.allSalesData.invoiceNumber!;
    }
    if (saleEditData.allSalesData.orderNumber! != "-") {
      orderController.text = saleEditData.allSalesData.orderNumber!;
    }
    notifyListeners();
  }

  bool invChange = false;
  bool ordChange = false;
  bool amountChange = false;

  checkInvoice() {
    invChange = invoiceController.text != allSalesData.invoiceNumber;
    notifyListeners();
  }

  checkOrder() {
    ordChange = orderController.text != allSalesData.orderNumber;
    notifyListeners();
  }

  checkAmount() {
    amountChange = ammountController.text != allSalesData.amount;
    notifyListeners();
  }

  Future<void> update(context) async {
    if (orderController.text.isNotEmpty || invoiceController.text.isNotEmpty) {
      orderValidation = "";
      invoiceValidation = "";
    } else {
      orderValidation =
          AppLocalizations.of(context)!.putOrderNumberErrorMessage;
      invoiceValidation =
          AppLocalizations.of(context)!.putInvoiceNumberErrorMessage;
    }
    bool invOrOrd =
        invoiceController.text.isNotEmpty || orderController.text.isNotEmpty;
    notifyListeners();
    bool connection = await checkConnectivity();
    if (invOrOrd) {
      var body = {
        DataBaseHelperKeys.uniqueId: allSalesData.uniqueId,
        DataBaseHelperKeys.invoiceNumber: invoiceController.text,
        DataBaseHelperKeys.orderNumber: orderController.text,
        DataBaseHelperKeys.amount: ammountController.text,
        DataBaseHelperKeys.description: allSalesData.description,
        DataBaseHelperKeys.routeZone: routeId ?? "0",
      };
      int offlineStatus = allSalesData.status!;
      String offlineStatusDescription = allSalesData.statusDescription!;
      if (allSalesData.saleType!.toLowerCase() == "2s" &&
          (allSalesData.amount == ammountController.text) &&
          allSalesData.status == 3) {
        offlineStatus = 7;
        offlineStatusDescription = "Pending Delivery Confirmation";
      } else {
        offlineStatus = allSalesData.status!;
        offlineStatusDescription = allSalesData.statusDescription!;
      }
      var bodyOffline = {
        DataBaseHelperKeys.uniqueId: allSalesData.uniqueId!,
        DataBaseHelperKeys.saleType: allSalesData.saleType!,
        DataBaseHelperKeys.bpIdR: allSalesData.bpIdR ?? "",
        DataBaseHelperKeys.storeId: allSalesData.storeId,
        DataBaseHelperKeys.wholesalerStoreId: allSalesData.wholesalerStoreId,
        DataBaseHelperKeys.invoiceNumber: invoiceController.text,
        DataBaseHelperKeys.orderNumber: orderController.text,
        DataBaseHelperKeys.saleDate: allSalesData.saleDate,
        DataBaseHelperKeys.dueDate: allSalesData.dueDate,
        DataBaseHelperKeys.currency: allSalesData.currency,
        DataBaseHelperKeys.amount: ammountController.text.isEmpty
            ? allSalesData.amount
            : ammountController.text,
        DataBaseHelperKeys.bingoOrderId: allSalesData.bingoOrderId,
        DataBaseHelperKeys.status: offlineStatus,
        DataBaseHelperKeys.statusDescription: offlineStatusDescription,
        DataBaseHelperKeys.isStartPayment: 0,
        DataBaseHelperKeys.retailerName: allSalesData.retailerName,
        DataBaseHelperKeys.wholesalerName: allSalesData.wholesalerName,
        DataBaseHelperKeys.fieName: allSalesData.fieName,
        DataBaseHelperKeys.wholesalerTempTxAddress:
            allSalesData.wholesalerTempTxAddress,
        DataBaseHelperKeys.retailerTempTxAddress:
            allSalesData.retailerTempTxAddress,
        DataBaseHelperKeys.balance: allSalesData.balance,
        DataBaseHelperKeys.isAppUniqId:
            allSalesData.isAppUniqId!.isEmpty ? "0" : "1",
        DataBaseHelperKeys.description: allSalesData.description,
      };
      if (connection) {
        try {
          setButtonBusy(true);
          AllSalesData? response = await _repositorySales.updateSales(body);
          print('responseresponseresponse');
          print(jsonEncode(response));
          setButtonBusy(false);
          // if (response.success!) {
          _repositorySales.changeSaleMessageShow(false);
          setButtonBusy(false);
          notifyListeners();
          // if (saleEditScreens == SaleEditScreens.saleList) {
          if (body[DataBaseHelperKeys.routeZone] == "0") {
            _navigationService.pop(response);
          } else {
            // _navigationService.pop(response);
            _navigationService
              ..pop()
              ..pop();
          }
        } on Exception catch (_) {
          setButtonBusy(false);
        }
      } else {
        try {
          setButtonBusy(true);
          await _repositorySales.addSalesOffline(bodyOffline);
          //
          notifyListeners();
          _navigationService.snackBar(AppLocalizations.of(context)!.dataStored);
          _repositorySales.changeSaleMessageShow(false);
          _repositorySales.getWholesalersSalesDataOffline();
          setButtonBusy(false);
          notifyListeners();
          if (saleEditScreens == SaleEditScreens.saleList) {
            _navigationService
              ..pop()
              ..pop();
          } else {
            _navigationService.pop();
          }
        } on Exception catch (_) {
          setButtonBusy(false);
        }
      }
    }

    // _repositoryComponents.onChangedTab(context, 1);
  }

  void backScreen() {
    _navigationService.pop();
  }
}
