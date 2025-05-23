import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';

import '../../../data_models/enums/user_roles_files.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '/app/router.dart';
import '/repository/order_repository.dart';
import '/repository/repository_components.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data_models/models/all_order_model/all_order_model.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/customer_list/customer_list.dart';
import '../../../data_models/models/order_selection_model/order_selection_model.dart';
import '../../../data_models/models/retailer_associated_wholesaler_list/retailer_associated_wholesaler_list.dart';
import '../../../data_models/models/retailer_association_fie_list/retailer_association_fie_list.dart';
import '../../../main.dart';
import '../../../repository/repository_customer.dart';
import '../../../repository/repository_retailer.dart';
import '../../../repository/repository_sales.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../fie_details_view/fie_details_view.dart';
import '../wholesaler_details/wholesaler_details.dart';

class StaticViewModel extends ReactiveViewModel {
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();

  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();

  AutoSizeGroup priceGroup = AutoSizeGroup();

  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  StaticViewModel() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshWholesalersSalesData();
    });
    getWholesalersSalesDataOffline();
    // _repositorySales.getWholesalersSalesData(1);
    getCustomer();
    _repositorySales.getSortedOnlineSale();
    for (var i = 0; i < allOfflineSalesData.length; i++) {
      print(allOfflineSalesData[i].toJson());
    }
    changeAppBar();
    notifyListeners();
  }

  // int get page => _repositorySales.page;
  int customerPage = 0;
  int orderPage = 1;
  int wholesalerPage = 1;
  int fiePage = 1;

  bool get isCustomerPageAvailable =>
      _customerRepository.customerLoadMoreButton;

  List<AllOrderModelData> get allOrder => _repositoryOrder.allOrder.value;

  String sortedItem = AppLocalizations.of(activeContext)!.status;
  String customerSortedItem = AppLocalizations.of(activeContext)!.status;
  String orderSortedItem = AppLocalizations.of(activeContext)!.status;
  String wholesalerSortedItem = AppLocalizations.of(activeContext)!.status;
  String fieSortedItem = AppLocalizations.of(activeContext)!.status;

  // Widget get connectionStreamApiCall =>
  //     _connectivityService.connectionStreamApiCall();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  String get language => _authService.selectedLanguageCode;

  List<AllSalesData> get allSalesData => _repositorySales.allSalesData;

  List<AllSalesData> get allSortedSalesData =>
      _repositorySales.allSortedSalesData.value;

  List<AllSalesData> get allOfflineSalesData =>
      _repositorySales.allOfflineSalesData.value;

  int get currentTabIndex => _repositoryComponents.currentSalesIndex.value;

  bool get isSaleMessageShow => _repositorySales.isSaleMessageShow.value;

  bool get orderLoadMoreButton => _repositoryOrder.orderLoadMoreButton.value;

  String get saleMessageShow => _repositorySales.saleMessage;

  List<CustomerData> get customers => _customerRepository.customers.value;

  List<RetailerAssociatedWholesalerListData> get wholesaler =>
      _repositoryRetailer.retilerAssociationWholesalers.value;

  List<RetailerAssociationFieListData> get retailerAssociationFie =>
      _repositoryRetailer.retailerAssociationFie.value;

  AllSalesData get lastSellItem => _repositorySales.lastSellItem;
  String appBarTitle = AppLocalizations.of(activeContext)!.sales.toUpperCase();

  AppBarText getAppTitle() {
    return AppBarText(appBarTitle.toUpperCase());
  }

  // void openSaleScannerDialog() {
  //   _navigationService.animatedDialog(const SaleScannerDialog());
  // }

  String getAppBarTitle() {
    if (_authService.selectedLanguageCode.toLowerCase() == "en") {
      switch (appBarTitle) {
        case "dashBoard":
          return "DASHBOARD";
        case "request":
          return "REQUESTS";
        case "settings":
          return "SETTINGS";
        case "accountBalance":
          return "ACCOUNT BALANCE";

        default:
          return "DASHBOARD";
      }
    } else {
      switch (appBarTitle) {
        case "dashBoard":
          return "DASHBOARD";
        case "request":
          return "SOLICITUDES";
        case "settings":
          return "AJUSTES";
        case "accountBalance":
          return "BALANCE DE CUENTA";

        default:
          return "DASHBOARD";
      }
    }
  }

  String getOrderType(int value) {
    if (_authService.user.value.data!.languageCode!.toLowerCase() == 'en') {
      switch (value) {
        case 0:
          return "Draft";
        case 1:
          return "Template";
        case 2:
          return "Order";
      }
      return "Draft";
    } else {
      switch (value) {
        case 0:
          return "Borrador";
        case 1:
          return "Plantilla";
        case 2:
          return "Orden";
      }
      return "Borrador";
    }
  }

  OrderSelectionModel get orderSelectionData =>
      _repositoryOrder.orderSelectionModel.value;
  bool isWaiting = false;

  void makeWaiting(v) {
    isWaiting = v;
    notifyListeners();
  }

  Future<void> gotoOrderDetailsScreen(String orderUId, int orderType,
      String wholesalerId, String storeId, BuildContext context) async {
    if (orderType == 2) {
      _navigationService.pushNamed(Routes.orderDetailsScreenView,
          arguments: orderUId);
    } else {
      makeWaiting(true);
      var body = {
        "wholesaler_id": wholesalerId,
        "store_id": storeId,
      };
      print('bodybody');
      print(body);
      // await _repositoryOrder
      //     .callOrderInfoNew(body, wholesalerId, storeId)
      //     .catchError((_) => makeWaiting(false));
      _navigationService.pushNamed(Routes.createOrder, arguments: {
        "type": orderType,
        "id": orderUId,
        "wholesaler_id": wholesalerId,
        "store_id": storeId,
        "from_list": true,
      });
      print({
        "type": orderType,
        "id": orderUId,
        "wholesaler_id": wholesalerId,
        "store_id": storeId,
      });
      makeWaiting(false);
    }
  }

  String changeAppBar() {
    print(_authService.selectedLanguageCode.toLowerCase());
    if (_authService.selectedLanguageCode.toLowerCase() == "en") {
      switch (currentTabIndex) {
        case 0:
          return 'ORDERS';
        case 1:
          return 'SALES';
        case 2:
          return enrollment == UserTypeForWeb.retailer
              ? 'WHOLESALERS'
              : 'CUSTOMERS';
        case 3:
          return 'INSTITUTIONS';
        default:
          return "ORDERS";
      }
    } else {
      switch (currentTabIndex) {
        case 0:
          return 'PEDIDOS';
        case 1:
          return 'VENTAS';
        case 2:
          return enrollment == UserTypeForWeb.retailer
              ? 'MAYORISTAS'
              : 'CLIENTES';
        case 3:
          return 'INSTITUCIONES';
        default:
          return "PEDIDOS";
      }
    }

    // notifyListeners();
  }

  void readQrScanner(BuildContext context) async {
    _repositorySales.startBarcodeScanner2(context,
        enrollment == UserTypeForWeb.retailer, _authService.user.value);
  }

  void setTabIndex(int v) {
    // selectedNumber.value = 1;
    _repositoryComponents.setSalesTabIndex(v);
    changeAppBar();
  }

  gotoDetails(String tempTxAddress, String retailerName, String uniqueId) {
    List<String> list = [
      tempTxAddress,
      retailerName,
      uniqueId,
    ];
    print(uniqueId);
    _navigationService.pushNamed(Routes.customerDetailsView, arguments: list);
  }

  gotoWholesalerDetails(
    RetailerAssociatedWholesalerListData data,
    BuildContext context,
    bool isWholesaler,
  ) {
    _navigationService.push(
        MaterialPageRoute(builder: (context) => WholesalerDetailsView(data)));
  }

  gotoFieDetails(
    RetailerAssociationFieListData data,
    BuildContext context,
    bool isWholesaler,
  ) {
    _navigationService
        .push(MaterialPageRoute(builder: (context) => FieDetailsView(data)));
  }

  void getCustomer() async {
    customerPage += 1;
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerOffline(customerPage);
    // isCustomerPageAvailable
    setBusy(false);
    notifyListeners();
  }

  void getMoreCustomer() async {
    customerPage += 1;
    makeButtonBusy(true);
    await _customerRepository.getCustomerOnline(customerPage);
    makeButtonBusy(false);
  }

  getWholesalersSalesDataOffline() async {
    setBusy(true);
    notifyListeners();
    await _repositorySales.getWholesalersSalesDataOffline();
    isLoadMoreAvailable = _repositorySales.isLoadMoreAvailable.value;
    setBusy(false);
    notifyListeners();
  }

  Future refreshWholesalersSalesData() async {
    pageNumber = 1;
    setBusy(true);
    notifyListeners();
    await _repositorySales.getWholesalersSalesData(pageNumber);
    isLoadMoreAvailable = _repositorySales.isLoadMoreAvailable.value;

    setBusy(false);
    notifyListeners();
  }

  int tabNumber = 2;

  void gotoSalesDetails(AllSalesData saleData, {bool? isOffline}) {
    _navigationService.pushNamed(Routes.salesDetailsScreen,
        arguments: OfflineOnlineSalesModel(
          allSalesData: saleData,
          isOffline: isOffline,
        ));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _repositorySales,
        _repositoryComponents,
        _repositoryRetailer,
        _customerRepository,
        _repositoryOrder
      ];

  void sortList(String e) {
    _repositorySales.sortList(e);
    sortedItem = e;
    notifyListeners();
  }

  void customerSortList(String e) {
    _customerRepository.sortList(e);
    customerSortedItem = e;
    notifyListeners();
  }

  void orderSortList(String e) {
    if (e == "Status") {
      allOrder.sort((a, b) {
        int aDate = a.status!;
        int bDate = b.status!;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    } else {
      allOrder.sort((a, b) {
        int aDate =
            DateTime.parse(a.dateOfTransaction ?? '').microsecondsSinceEpoch;
        int bDate =
            DateTime.parse(b.dateOfTransaction ?? '').microsecondsSinceEpoch;
        notifyListeners();
        return bDate.compareTo(aDate);
      });
    }

    orderSortedItem = e;
    notifyListeners();
  }

  void wholesalerSortList(String e) {
    _repositoryRetailer.sortWholesalerList(e);
    wholesalerSortedItem = e;
    notifyListeners();
  }

  void fieSortList(String e) {
    _repositoryRetailer.sortFieList(e);
    fieSortedItem = e;
    notifyListeners();
  }

  bool isLoadMoreAvailable = false;
  bool isButtonBusy = false;

  void makeButtonBusy(v) {
    isButtonBusy = v;
    notifyListeners();
  }

  int pageNumber = 1;

  void salesLoadMore() async {
    makeButtonBusy(true);
    pageNumber += 1;
    await _repositorySales.getWholesalersSalesDataLoadMore(pageNumber);

    isLoadMoreAvailable = _repositorySales.isLoadMoreAvailable.value;
    notifyListeners();
    makeButtonBusy(false);
  }

  bool isCustomerTabBusy = false;

  setCustomerTabBusy(bool v) {
    isCustomerTabBusy = v;
    notifyListeners();
  }

  Future refreshCustomer() async {
    setCustomerTabBusy(true);
    customerPage = 1;
    await _customerRepository.refreshCustomer();
    setCustomerTabBusy(false);
  }

  Future refreshOrder() async {
    setCustomerTabBusy(true);
    orderPage = 1;
    await _repositoryOrder.getAllOrder(orderPage);
    setCustomerTabBusy(false);
  }

  Future refreshWholesaler() async {
    setCustomerTabBusy(true);
    await _repositoryRetailer.refreshRetailerWholesaler();
    setCustomerTabBusy(false);
  }

  Future refreshFie() async {
    setCustomerTabBusy(true);
    await _repositoryRetailer.refreshRetailerFie(1);
    setCustomerTabBusy(false);
  }

  loadMoreFie() async {
    makeButtonBusy(true);
    fiePage = ++fiePage;
    await _repositoryRetailer.getRetailerFieList(fiePage);
    notifyListeners();
    makeButtonBusy(false);
  }

  loadMoreOrder() async {
    makeButtonBusy(true);
    orderPage = orderPage + 1;
    await _repositoryOrder.getAllOrder(orderPage);
    notifyListeners();
    makeButtonBusy(false);
  }
}
