import '../../../data_models/enums/user_type_for_web.dart';
import '/const/utils.dart';
import '/data_models/construction_model/sale_types_model.dart';
import '/presentation/widgets/alert/alert_dialog.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../const/connectivity.dart';
import '../../../const/database_helper.dart';
import '../../../data/data_source/sale_types.dart';
import '../../../data_models/construction_model/route_to_sale_model/route_to_sale_model.dart';
import '../../../data_models/construction_model/route_zone_argument_model/route_zone_argument_model.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/component_models/retailer_list_model.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';
import '../../../repository/repository_sales.dart';

class AddSalesViewModel extends ReactiveViewModel {
  AddSalesViewModel() {
    selectStore = null;
    selectRetailer = null;
    selectSaleType = null;
    notifyListeners();
  }

  int screenNumber = 0;
  String? routeZoneId;

  getStoreList() async {
    selectStore = null;
    await _repositoryComponents.getRetailerListOffline();
  }

  String routeId = "";

  Future<void> getDataFromRoutes(RouteToSaleModel arguments) async {
    screenNumber = 1;
    routeZoneId = arguments.routeId;
    setBusy(true);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    routeId = arguments.routeId!;
    selectStore = storeList
        .firstWhere((element) => element.storeId == arguments.storeId!);
    currencyController.text = selectStore!.approvedCreditLineCurrency!;
    // selectRetailer = retailerList.firstWhere(
    //     (element) => element.associationUniqueId == selectStore!.associationId);
    // changeRetailer(selectRetailer!);
    selectRetailer == null
        ? changeStoreThenRetailer(selectStore!)
        : changeStore(selectStore!);
    // changeStore(selectStore!);
    notifyListeners();

    if (arguments.salesType != '') {
      selectSaleType = saleTypes.firstWhere((element) =>
          element.initiate!.toLowerCase() ==
          arguments.salesType!.toLowerCase());
    }

    setBusy(false);
    notifyListeners();
  }

  getStoreListWithAutoSelect(RoutesZonesArgumentData arguments) async {
    screenNumber = 2;
    // selectStore = null;
    // await _repositoryComponents.getRetailerListOffline();
    //
    // // selectRetailer = retailerList
    // //     .firstWhere((element) => element.bpIdR == arguments.retailerId);
    //
    // selectStore = storeList
    //     .firstWhere((element) => element.storeId == arguments.bingoStoreId);
  }

  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  RetailerListData? selectRetailer;
  StoreList? selectStore;
  SaleTypesModel? selectSaleType;

  UserModel get user => _authService.user.value;

  // bool get isRetailer => _authService.isRetailer.value;

  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  List<RetailerListData> get retailerList => _repositoryComponents.retailerList
      .where((d) => d.hasActiveCreditline == true)
      .toList();

  List<StoreList> get storeList => _repositoryComponents.storeList;

  List<StoreList> get sortedStoreList =>
      _repositoryComponents.sortedStoreList.value;

  List<AllSalesData> get allOfflineSalesData =>
      _repositorySales.allOfflineSalesData.value;

  String getSalesTypeBaseOnLang(v) {
    if (_authService.selectedLanguageCode == "en") {
      return v == "1S" ? "One step sale" : "Two step sale";
    } else {
      return v == "1S" ? "Venta directa" : "Pedido";
    }
    // _saleTypes = _authService.selectedLanguageCode == "en"
    //     ? [
    //         SaleTypesModel(title: "One step sale", initiate: "1S"),
    //         SaleTypesModel(title: "Two step sale", initiate: "2S"),
    //       ]
    //     : [
    //         SaleTypesModel(title: "Venta directa", initiate: "1S"),
    //         SaleTypesModel(title: "Pedido", initiate: "2S"),
    //       ];
  }

  List<SaleTypesModel> get saleTypes => saleTypesList;

  // [
  //       SaleTypesModel(title: "One step sale", initiate: "1S"),
  //       SaleTypesModel(title: "Two step sale", initiate: "2S")
  //     ];
  String availableAmountText = "";

  bool isStoreBusy = false;

  TextEditingController currencyController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String retailerValidation = "";
  String storeValidation = "";
  String salesTypeValidation = "";
  String invoiceValidation = "";
  String orderValidation = "";
  String amountValidation = "";

  double? get maxEligibility => selectStore!.availableAmount!;

  makeErrorMessageNull() {
    retailerValidation = "";
    storeValidation = "";
    salesTypeValidation = "";
    invoiceValidation = "";
    orderValidation = "";
    amountValidation = "";
    notifyListeners();
  }

  void setStoreBudy(bool v) {
    isStoreBusy = v;
    notifyListeners();
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
    setStoreBudy(true);
    _repositoryComponents.getSortedStore(v.associationUniqueId);
    notifyListeners();
    setStoreBudy(false);
    notifyListeners();
  }

  void changeStore(StoreList v) async {
    selectStore = v;
    currencyController.text = selectStore!.approvedCreditLineCurrency!;
    checkSaleType();
    availableAmount();
    notifyListeners();
  }

  checkSaleType() {
    if (selectStore!.saleType!.isNotEmpty) {
      int i = saleTypes.indexWhere((element) =>
          element.initiate!.toLowerCase() ==
          selectStore!.saleType!.toLowerCase());
      selectSaleType = saleTypes[i];
      notifyListeners();
    } else {
      selectSaleType = null;
    }
  }

  double availableAmount() {
    double sum = 0.0;
    List<AllSalesData> offlineSales = allOfflineSalesData
        .where((c) => c.storeId == selectStore!.storeId!)
        .toList();
    offlineSales.forEach((element) {
      sum += double.parse(element.amount!);
    });
    return selectStore!.availableAmount! - sum;
  }

  changeStoreThenRetailer(StoreList v) {
    selectStore = v;
    selectRetailer = retailerList
        .where((element) => element.associationUniqueId == v.associationId)
        .last;
    _repositoryComponents.getNewSortedList(v.associationId);
    checkSaleType();
    currencyController.text = selectStore!.approvedCreditLineCurrency!;
    notifyListeners();
  }

  void setAvailableAmount() {
    double availableBalance = availableAmount();
    availableAmountText = amountController.text.isEmpty
        ? availableBalance.toString()
        : (availableBalance - double.parse(amountController.text)).toString();
    notifyListeners();
  }

  void changeSaleType(SaleTypesModel v) async {
    selectSaleType = v;
    invoiceValidation = "";
    orderValidation = "";
    // makeErrorMessageNull();
    notifyListeners();
  }

  void showMessage() {
    Utils.toast(AppLocalizations.of(activeContext)!.offlineSaleLogoutAlert);
  }

  void checkBalance(String v) {
    if (v.isNotEmpty) {
      if (availableAmount() < double.parse(v)) {
        amountValidation =
            "${AppLocalizations.of(activeContext)!.purchaseAbilityTextFormat} ${selectStore!.approvedCreditLineCurrency!} "
            "${availableAmount()}";
      } else {
        amountValidation = "";
      }
    }
    notifyListeners();
  }

  bool isButtonBusy = false;

  void setButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  Future<void> addNew(context) async {
    if (selectRetailer == null) {
      retailerValidation = AppLocalizations.of(context)!.pleaseAelectARetailer;
    } else {
      retailerValidation = "";
    }

    if (selectRetailer != null) {
      if (selectStore == null) {
        storeValidation = AppLocalizations.of(context)!.selectAStore;
      } else {
        storeValidation = "";
      }
    }

    if (selectSaleType == null) {
      salesTypeValidation =
          AppLocalizations.of(context)!.selectSaleTypeErrorMessage;
    } else {
      salesTypeValidation = "";
    }
    if (selectSaleType != null) {
      if (selectSaleType!.initiate == saleTypes[0].initiate) {
        if (invoiceController.text.isEmpty) {
          invoiceValidation =
              AppLocalizations.of(context)!.putInvoiceNumberErrorMessage;
          orderValidation = "";
        } else {
          invoiceValidation = "";
        }
      } else if (selectSaleType!.initiate == saleTypes[1].initiate) {
        if (orderController.text.isEmpty) {
          orderValidation =
              AppLocalizations.of(context)!.putOrderNumberErrorMessage;
          invoiceValidation = "";
        } else {
          orderValidation = "";
        }
      } else {
        invoiceValidation = "";
        orderValidation = "";
      }
    }

    print(amountController.text);
    if (amountController.text.isEmpty) {
      amountValidation = AppLocalizations.of(context)!.amountEmptyErrorMessage;
    } else if (double.parse(amountController.text) > maxEligibility!) {
      amountValidation =
          "${AppLocalizations.of(context)!.amountExceedErrorMessage} ${selectStore!.approvedCreditLineCurrency!} $maxEligibility.";
    } else {
      amountValidation = "";
    }
    bool invOrOrd =
        invoiceController.text.isNotEmpty || orderController.text.isNotEmpty;
    print(invOrOrd);
    notifyListeners();
    bool connection = await checkConnectivity();
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
        DataBaseHelperKeys.invoiceNumber: invoiceController.text,
        DataBaseHelperKeys.orderNumber: orderController.text,
        DataBaseHelperKeys.currency: selectStore!.approvedCreditLineCurrency,
        DataBaseHelperKeys.amount: amountController.text,
        DataBaseHelperKeys.description: descriptionController.text,
        DataBaseHelperKeys.routeZone: routeZoneId ?? "0",
      };
      var bodyOffline = {
        DataBaseHelperKeys.bpIdR: selectRetailer!.bpIdR!,
        DataBaseHelperKeys.storeId: selectStore!.storeId,
        DataBaseHelperKeys.wholesalerStoreId: selectStore!.wholesalerStoreId,
        DataBaseHelperKeys.saleDate:
            (DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toString()))
                .toString(),
        DataBaseHelperKeys.saleType: selectSaleType!.initiate,
        DataBaseHelperKeys.retailerName: selectRetailer!.retailerName!,
        DataBaseHelperKeys.fieName: selectRetailer!.fieName,
        DataBaseHelperKeys.status: 0,
        DataBaseHelperKeys.statusDescription: "Sale Pending Approval",
        DataBaseHelperKeys.isStartPayment: 0,
        DataBaseHelperKeys.invoiceNumber: invoiceController.text,
        DataBaseHelperKeys.orderNumber: orderController.text,
        DataBaseHelperKeys.currency:
            selectStore!.approvedCreditLineCurrency.toString(),
        DataBaseHelperKeys.amount: amountController.text,
        DataBaseHelperKeys.retailerTempTxAddress: selectRetailer!.bpIdR,
        DataBaseHelperKeys.wholesalerTempTxAddress: user.data!.tempTxAddress,
        DataBaseHelperKeys.description: descriptionController.text,
        DataBaseHelperKeys.uniqueId:
            "local_${DateTime.now().millisecondsSinceEpoch}",
        DataBaseHelperKeys.isAppUniqId: '1',
      };
      if (connection) {
        try {
          setButtonBusy(true);
          if (routeId.isNotEmpty) {
            body.addAll({'w_route_zone_id': routeId});
          }
          print('bodybodybody');
          print(body);
          AllSalesModel? response = await _repositorySales.addSales(body);
          setButtonBusy(false);
          if (response!.success!) {
            clearForm();
            if (screenNumber == 1 && screenNumber == 2) {
              _navigationService.pop();
            } else {
              // _repositorySales.changeSaleMessageShow(true);
              setButtonBusy(false);
              _repositoryComponents.onChangedTab(context, 1);
              _repositoryComponents.setSalesTabIndex(1);
            }

            notifyListeners();
          } else {
            _navigationService
                .animatedDialog(AlertDialogMessage(response.message!));
            setButtonBusy(false);
          }
        } catch (_) {
          clearForm();
          setButtonBusy(false);
        }
      } else {
        try {
          setButtonBusy(true);
          await _repositorySales.addSalesOffline(bodyOffline);
          clearForm();

          _repositorySales.changeSaleMessageShow(true);
          _repositoryComponents.onChangedTab(context, 1);
          _repositoryComponents.setSalesTabIndex(1);

          setButtonBusy(false);
        } catch (_) {
          clearForm();
          setButtonBusy(false);
        }
      }
    }

    // _repositoryComponents.onChangedTab(context, 1);
  }

  Future<void> clearForm() async {
    print('adfjakjdflkajdfkajskj');
    selectRetailer = null;
    selectStore = null;
    selectSaleType = null;
    invoiceController.clear();
    orderController.clear();
    amountController.clear();
    descriptionController.clear();
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryComponents, _repositorySales];

  void cancelSellScreen() {
    _navigationService.pop();
    // backScreen();
  }

  void backScreen(BuildContext context) {
    _repositoryComponents.onChangedTab1(context);
    notifyListeners();
  }

  void goBack() {
    _navigationService.pop();
  }

  Future<bool> showExitPopup(BuildContext context) async {
    _repositoryComponents.onChangedTab1(context);
    notifyListeners();
    return false;
  }
}
