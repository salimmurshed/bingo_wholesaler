import 'dart:convert';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/repository/repository_website_sale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../app/locator.dart';

import '../../../../const/app_colors.dart';
import '../../../../const/database_helper.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/sale_details_transection_model/sale_details_transection_model.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';

class SaleDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWebsiteSales _repositorySales =
      locator<RepositoryWebsiteSales>();
  final AuthService _auth = locator<AuthService>();
  SaleDetailsTransection saleDetailsTransection = SaleDetailsTransection();
  ScrollController scrollController = ScrollController();

  TextEditingController invoiceToController = TextEditingController();
  TextEditingController fieNameController = TextEditingController();
  TextEditingController dateInvoiceController = TextEditingController();
  TextEditingController duePaymentDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController reservedAmountController = TextEditingController();
  TextEditingController currentAmountController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController bingoStoreIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String saleType = "";
  String currency = "";
  List saleSteps = ["One Step Sale", "Two Step Sale"];
  List saleCurrencies = [];
  bool isEdit = false;
  String availableAmount = "";
  String saleId = "";
  bool buttonBusy = false;
  String status = "";

  String get tabNumber => _webBasicService.tabNumber.value;

  // bool get isRetailer => _auth.isRetailer.value;
  UserTypeForWeb get enrollment => _auth.enrollment.value;

  int selectedTabForSaleDetails = 0;

  void changeTabForSaleDetails(int v, BuildContext context) {
    if (v == 1) {
      context.goNamed(Routes.saleTransaction,
          pathParameters: {'id': saleId, 'type': 'view'},
          queryParameters: {'transaction': 'true'});
    } else {
      context.goNamed(Routes.saleDetails,
          pathParameters: {'id': saleId, 'type': 'view'});
    }
    // selectedTabForSaleDetails = v;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  bool isTransaction = false;

  Future<void> callApi(String id, String? type, String? transaction) async {
    if (transaction != null) {
      isTransaction = true;
    }
    saleId = id;
    isEdit = type == 'view' ? false : true;
    setBusy(true);
    notifyListeners();
    saleDetailsTransection = await _repositorySales.getSaleDetailsForWeb(id);
    invoiceToController.text = enrollment == UserTypeForWeb.retailer
        ? saleDetailsTransection.data![0].wholesalerName!
        : saleDetailsTransection.data![0].retailerName!;
    Utils.fPrint('saleDetailsTransection.data![0]');
    Utils.fPrint(jsonEncode(saleDetailsTransection.data![0]));
    fieNameController.text = saleDetailsTransection.data![0].fieName!;
    dateInvoiceController.text = saleDetailsTransection.data![0].saleDate!;
    duePaymentDateController.text = saleDetailsTransection.data![0].dueDate!;
    amountController.text =
        Utils.stringTo2Decimal(saleDetailsTransection.data![0].amount ?? 0);
    reservedAmountController.text =
        saleDetailsTransection.data![0].reversedAmount ?? '0.00';
    currentAmountController.text =
        saleDetailsTransection.data![0].reversedAmount ?? '0.00';
    status = saleDetailsTransection.data![0].statusDescription ?? "";
    invoiceNumberController.text =
        saleDetailsTransection.data![0].invoiceNumber!;
    orderNumberController.text = saleDetailsTransection.data![0].orderNumber!;
    bingoStoreIdController.text = saleDetailsTransection.data![0].bingoStoreId!;
    descriptionController.text = saleDetailsTransection.data![0].description!;
    saleCurrencies.add(saleDetailsTransection.data![0].currency!);
    currency = saleDetailsTransection.data![0].currency!;
    availableAmount = saleDetailsTransection.data![0].availableAmount!;
    if (saleDetailsTransection.data![0].salesStep!.toLowerCase() == "1s") {
      saleType = "One Step Sale";
    } else {
      saleType = "Two Step Sale";
    }
    if (enrollment == UserTypeForWeb.wholesaler) {
      saleDetailsTransection.data![0].tranctionDetails =
          await _repositorySales.getSaleDetailsTransactionForWeb(id);
    }
    setBusy(false);
    notifyListeners();
  }

  Color statusColor(int status) {
    switch (status) {
      case 0:
        return AppColors.statusConfirmed;
      case 1:
        return AppColors.statusReject;
      case 2:
        return AppColors.statusDark;
      case 3:
        return AppColors.statusProgress;
      case 4:
        return AppColors.statusVerified;
      default:
        return AppColors.statusErrorColor;
    }
  }

  String orderValidation = "";
  String invoiceValidation = "";

  Future<void> update(BuildContext context) async {
    // if (invoiceNumberController.text.isEmpty) {
    //   invoiceValidation =
    //       AppLocalizations.of(context)!.putInvoiceNumberErrorMessage;
    // } else {
    //   invoiceValidation = "";
    // }
    // if (orderNumberController.text.isEmpty) {
    //   orderValidation =
    //       AppLocalizations.of(context)!.putOrderNumberErrorMessage;
    // } else {
    //   orderValidation = "";
    // }
    // notifyListeners();

    if (orderNumberController.text.isNotEmpty ||
        invoiceNumberController.text.isNotEmpty) {
      orderValidation = "";
      invoiceValidation = "";
      buttonBusy = true;
      notifyListeners();
    } else {
      orderValidation =
          AppLocalizations.of(context)!.putOrderNumberErrorMessage;
      invoiceValidation =
          AppLocalizations.of(context)!.putInvoiceNumberErrorMessage;
    }
    bool invOrOrd = invoiceNumberController.text.isNotEmpty ||
        orderNumberController.text.isNotEmpty;
    notifyListeners();

    if (invOrOrd) {
      var body = {
        DataBaseHelperKeys.uniqueId: saleId,
        DataBaseHelperKeys.invoiceNumber: invoiceNumberController.text,
        DataBaseHelperKeys.orderNumber: orderNumberController.text,
        DataBaseHelperKeys.amount: amountController.text,
        DataBaseHelperKeys.description: descriptionController.text,
      };

      try {
        setBusy(true);
        notifyListeners();
        Map<String, dynamic>? response =
            await _repositorySales.updateSales(body);
        if (response != null) {
          if (response['success']) {
            Utils.toast(response['message'], isSuccess: true);
            if (context.mounted) {
              context.goNamed(Routes.saleScreen, pathParameters: {'page': '1'});
            }
          } else {
            Utils.toast(response['message']);
          }
        } else {
          Utils.toast("There has some issue!");
        }
        setBusy(false);
        notifyListeners();
      } on Exception catch (_) {
        setBusy(false);
        notifyListeners();
      }
    }

    // _repositoryComponents.onChangedTab(context, 1);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.saleScreen, pathParameters: {'page': '1'});
  }
}
