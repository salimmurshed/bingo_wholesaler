import 'dart:convert';
import 'package:universal_html/html.dart';

import 'package:bingo/app/app_secrets.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/locator.dart';
import '../../../../const/database_helper.dart';
import '../../../../data/data_source/sale_types.dart';
import '../../../../data_models/construction_model/sale_types_model.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../../data_models/models/component_models/response_model.dart';
import '../../../../data_models/models/component_models/retailer_list_model.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '../../../../repository/repository_sales.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';

class SalesAddViewModel extends BaseViewModel {
  SalesAddViewModel() {
    getRetailerListWeb();
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String retailerValidation = "";
  String storeValidation = "";
  String salesTypeValidation = "";
  String amountValidation = "";

  double? get maxEligibility => selectStore!.availableAmount!;
  String availableAmount = '0.00';

  UserModel get user => _authService.user.value;
  bool isButtonBusy = false;

  String get tabNumber => _webBasicService.tabNumber.value;

  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<RetailerListData> retailerList = [];
  List<StoreList> storeList = [];
  RetailerListData? selectRetailer;
  StoreList? selectStore;
  SaleTypesModel? selectSaleType;
  String invoiceValidation = "";
  String orderValidation = "";
  bool buttonBusy = false;

  List<SaleTypesModel> get saleTypes => saleTypesList;
  List<StoreList> sortedStoreList = [];

  getRetailerListWeb() async {
    setBusy(true);
    notifyListeners();
    await _repositoryComponents.getRetailerListWeb();
    retailerList = _repositoryComponents.retailerList;
    for (RetailerListData item in retailerList) {
      storeList.addAll(item.storeList!);
    }
    sortedStoreList = storeList;
    setBusy(false);
    notifyListeners();
  }

  changeStoreThenRetailer(StoreList v) {
    selectStore = v;
    currencyController.text = selectStore!.approvedCreditLineCurrency!;
    selectRetailer = retailerList
        .where((element) => element.associationUniqueId == v.associationId)
        .last;
    getNewSortedList(v.associationId);
    checkSaleType();
    storeValidation = "";
    retailerValidation = "";
    notifyListeners();
  }

  void getNewSortedList(String? associationId) {
    sortedStoreList = storeList
        .where((element) => element.associationId == associationId)
        .toList();
  }

  void changeStore(StoreList v) async {
    selectStore = v;
    currencyController.text = selectStore!.approvedCreditLineCurrency!.isEmpty
        ? "USD"
        : selectStore!.approvedCreditLineCurrency!;
    availableAmount = v.availableAmount!.toString();
    checkSaleType();
    // availableAmount();
    notifyListeners();
  }

  checkSaleType() {
    // if (selectStore!.saleType!.isNotEmpty) {
    //   int i = saleTypes.indexWhere((element) =>
    //   element.initiate!.toLowerCase() ==
    //       selectStore!.saleType!.toLowerCase());
    //   selectSaleType = saleTypes[i];
    //   notifyListeners();
    // } else {
    //   selectSaleType = null;
    // }
  }

  void changeSaleType(SaleTypesModel v) async {
    selectSaleType = v;
    invoiceValidation = "";
    orderValidation = "";
    salesTypeValidation = "";
    // makeErrorMessageNull();
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    // ref.read(routerProvider).go()
    window.history.back();
    // context.goNamed(Routes.saleScreen, pathParameters: {'page': '1'});
  }

  void changeRetailerToNull() {
    selectRetailer = null;
    selectStore = null;
    _repositoryComponents.getStoreList();
    notifyListeners();
  }

  void changeRetailer(RetailerListData v) async {
    selectRetailer = v;
    selectStore = null;
    sortedStoreList = v.storeList!;
    retailerValidation = "";
    notifyListeners();
  }

  void setButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  Future<bool> clearForm() async {
    await Future.delayed(const Duration(microseconds: 1));
    selectRetailer = null;
    selectStore = null;
    selectSaleType = null;
    invoiceNumberController.clear();
    orderNumberController.clear();
    amountController.clear();
    descriptionController.clear();
    notifyListeners();
    return true;
  }

  Future<void> addNew(BuildContext context) async {
    if (selectRetailer == null) {
      retailerValidation = AppLocalizations.of(context)!.pleaseAelectARetailer;
    } else {
      retailerValidation = "";
    }
    notifyListeners();
    if (selectStore == null) {
      storeValidation = AppLocalizations.of(context)!.selectAStore;
    } else {
      storeValidation = "";
    }
    notifyListeners();

    if (selectSaleType == null) {
      salesTypeValidation =
          AppLocalizations.of(context)!.selectSaleTypeErrorMessage;
    } else {
      salesTypeValidation = "";
    }
    notifyListeners();
    if (selectSaleType != null) {
      if (selectSaleType!.initiate == saleTypes[0].initiate) {
        if (invoiceNumberController.text.isEmpty) {
          invoiceValidation =
              AppLocalizations.of(context)!.putInvoiceNumberErrorMessage;
          orderValidation = "";
        } else if (invoiceNumberController.text.length <=
            AppSecrets.charsLengthSaleSearch) {
          invoiceValidation =
              "Need to put minimum ${AppSecrets.charsLengthSaleSearch + 1} latter";
        } else {
          invoiceValidation = "";
        }
      } else if (selectSaleType!.initiate == saleTypes[1].initiate) {
        if (orderNumberController.text.isEmpty) {
          orderValidation =
              AppLocalizations.of(context)!.putOrderNumberErrorMessage;
          invoiceValidation = "";
        } else if (orderNumberController.text.length <=
            AppSecrets.charsLengthSaleSearch) {
          orderValidation =
              "Need to put minimum ${AppSecrets.charsLengthSaleSearch + 1} latter";
        } else {
          orderValidation = "";
        }
      } else {
        invoiceValidation = "";
        orderValidation = "";
      }
    }

    if (amountController.text.isEmpty) {
      amountValidation = AppLocalizations.of(context)!.amountEmptyErrorMessage;
    } else if (double.parse(amountController.text) > maxEligibility!) {
      amountValidation =
          "${AppLocalizations.of(context)!.amountExceedErrorMessage} ${selectStore!.approvedCreditLineCurrency!} $maxEligibility.";
    } else {
      amountValidation = "";
    }

    notifyListeners();
    bool invOrOrd = (invoiceNumberController.text.isNotEmpty &&
            invoiceNumberController.text.length >
                AppSecrets.charsLengthSaleSearch) ||
        (orderNumberController.text.isNotEmpty &&
            orderNumberController.text.length >
                AppSecrets.charsLengthSaleSearch);
    notifyListeners();
    if (selectRetailer != null &&
        selectStore != null &&
        selectSaleType != null &&
        (invOrOrd) &&
        amountController.text.isNotEmpty &&
        double.parse(amountController.text) <= maxEligibility!) {
      var body = {
        DataBaseHelperKeys.bpIdR: selectRetailer!.bpIdR,
        DataBaseHelperKeys.storeId: selectStore!.storeId,
        DataBaseHelperKeys.wholesalerStoreId: user.data!.uniqueId,
        DataBaseHelperKeys.saleType: selectSaleType!.initiate,
        DataBaseHelperKeys.invoiceNumber: invoiceNumberController.text,
        DataBaseHelperKeys.orderNumber: orderNumberController.text,
        DataBaseHelperKeys.currency: selectStore!.approvedCreditLineCurrency,
        DataBaseHelperKeys.amount: amountController.text,
        DataBaseHelperKeys.description: descriptionController.text,
      };
      try {
        setBusy(true);
        notifyListeners();

        ResponseMessages? response = await _repositorySales.addSalesWeb(body);
        setBusy(false);
        notifyListeners();
        if (response!.success!) {
          clearForm();
          context.goNamed(Routes.saleScreen, pathParameters: {'page': '1'});

          notifyListeners();
        }
      } catch (_) {
        setBusy(false);
        notifyListeners();
      }
    }

    // _repositoryComponents.onChangedTab(context, 1);
  }

  void changeError(TextEditingController controller, int validation) {
    if (validation == 1) {
      if (controller.text.isNotEmpty) {
        invoiceValidation = "";
      }
    }
    if (validation == 2) {
      if (controller.text.isNotEmpty) {
        orderValidation = "";
      }
    }
    if (validation == 3) {
      if (controller.text.isNotEmpty) {
        amountValidation = "";
      }
    }

    notifyListeners();
  }
}
