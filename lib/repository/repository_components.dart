import 'dart:convert';
import 'package:bingo/const/utils.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';

import '../data_models/enums/user_type_for_web.dart';
import '/data_models/models/component_models/all_city_model.dart';
import '/data_models/models/component_models/all_country_model.dart';
import '/data_models/models/component_models/customer_type_model.dart';
import '/data_models/models/component_models/priceing_group_model.dart';
import '/data_models/models/component_models/sales_zone_model.dart';
import '/data_models/models/component_models/tax_id_type_model.dart';
import '/main.dart';
import '/repository/order_repository.dart';
import '/services/network/network_urls.dart';
import '/services/storage/db.dart';
import '/services/storage/device_storage.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../const/connectivity.dart';
import '../const/database_helper.dart';
import '../data_models/enums/home_page_bottom_tabs.dart';
import '../data_models/enums/static_page_enums.dart';
import '../data_models/models/component_models/bank_list.dart';
import '../data_models/models/component_models/fie_list_creditline_request_model.dart';
import '../data_models/models/component_models/grace_period_group.dart';
import '../data_models/models/component_models/partner_with_currency_list.dart';
import '../data_models/models/component_models/retailer_list_model.dart';
import '../data_models/models/component_models/retailer_role_model.dart';
import '../services/local_data/local_data.dart';
import '../services/local_data/table_names.dart';
import '../services/network/web_service.dart';

@lazySingleton
class RepositoryComponents with ListenableServiceMixin {
  final dbHelper = DatabaseHelper.instance;
  final WebService _webService = locator<WebService>();
  final ZDeviceStorage _deviceStorage = locator<ZDeviceStorage>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();

  final LocalData _localData = locator<LocalData>();

  RepositoryComponents() {
    listenToReactiveValues([
      wholesalerWithCurrency,
      retailerRolesList,
      selectedNumberMainTab,
      currentSalesIndex,
      currentFourthTabIndex,
      sortedStoreList,
      requestTabTitleRetailer,
      requestTabTitleWholesaler,
      selectedNumberPrevious,
      customerTab,
      homeappBarTitle,
      internetConnection,
      retailerBankList
    ]);
  }

  // bool get isRetailer => locator<AuthService>().isRetailer.value;

  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;
  ReactiveValue<bool> internetConnection = ReactiveValue<bool>(true);

  ReactiveValue<int> selectedNumberMainTab = ReactiveValue(0);
  ReactiveValue<int> selectedNumberPrevious = ReactiveValue(0);
  ReactiveValue<int> currentSalesIndex = ReactiveValue(0);
  ReactiveValue<int> currentFourthTabIndex = ReactiveValue(0);
  ReactiveValue<HomePageBottomTabs> homeScreenBottomTabs =
      ReactiveValue(HomePageBottomTabs.dashboard);
  ReactiveValue<StaticTabs> staticScreenBottomTabs =
      ReactiveValue(StaticTabs.sales);
  ReactiveValue<CustomersTabs> customersScreenBottomTabs =
      ReactiveValue(CustomersTabs.sales);
  ReactiveValue<HomePageRequestTabsW> requestTabTitleWholesaler =
      ReactiveValue(HomePageRequestTabsW.associateRequest);
  ReactiveValue<HomePageRequestTabsR> requestTabTitleRetailer =
      ReactiveValue(HomePageRequestTabsR.wAssociateRequest);
  HomePageSettingTabs settingTabTitle = HomePageSettingTabs.users;

  TaxIdType taxIdType = TaxIdType();
  ReactiveValue<RetailerRolesModel> retailerRolesList =
      ReactiveValue<RetailerRolesModel>(RetailerRolesModel());
  CustomerTypeModel customerType = CustomerTypeModel();
  GracePeriodGroupModel gracePeriodGroup = GracePeriodGroupModel();
  FieCreditLineRequestModel allFieCreditLine = FieCreditLineRequestModel();
  PricingGroupModel pricingGroup = PricingGroupModel();
  SalesZoneModel salesZone = SalesZoneModel();
  ReactiveValue<AllCountryModel> allCountryData =
      ReactiveValue(AllCountryModel());
  ReactiveValue<AllCityModel> allCityData = ReactiveValue(AllCityModel());

  ReactiveValue<PartnerWithCurrencyList> wholesalerWithCurrency =
      ReactiveValue<PartnerWithCurrencyList>(PartnerWithCurrencyList());

  List<RetailerListData> retailerList = [];
  List<StoreList> storeList = [];
  ReactiveValue<List<StoreList>> sortedStoreList = ReactiveValue([]);
  ReactiveValue<List<BankListData>> retailerBankList =
      ReactiveValue<List<BankListData>>([]);
  ReactiveValue<String> homeappBarTitle = ReactiveValue<String>('DashBoard');
  // ReactiveValue<String>(AppLocalizations.of(activeContext)!.dashBoard);
  ReactiveValue<CustomersTabs> customerTab =
      ReactiveValue(CustomersTabs.creditlines);
  int logisticTab = 0;

  setSettingTab() {
    settingTabTitle = enrollment == UserTypeForWeb.retailer
        ? HomePageSettingTabs.users
        : HomePageSettingTabs.security;
    // notifyListeners();
  }

  Future<void> changeTabFourth(int i) async {
    logisticTab = i;
  }

  void changeInternetStatus(bool v) {
    internetConnection.value = v;
  }

  void changeSettingTab(HomePageSettingTabs title) {
    settingTabTitle = title;
    notifyListeners();
  }

  void changeTab(int i, BuildContext context) {
    customerTab.value = CustomersTabs.values[i];
    notifyListeners();
  }

  void changeRequestTabWholesaler(int i, BuildContext context) {
    requestTabTitleWholesaler.value = i == 0
        ? HomePageRequestTabsW.associateRequest
        : HomePageRequestTabsW.creditLineRequest;
    notifyListeners();
  }

  void changeRequestTabRetailer(int i, BuildContext context) {
    requestTabTitleRetailer.value = i == 0
        ? HomePageRequestTabsR.wAssociateRequest
        : requestTabTitleRetailer.value = i == 1
            ? HomePageRequestTabsR.fAssociateRequest
            : HomePageRequestTabsR.creditLineRequest;
    DefaultTabController.of(context).animateTo(i);
    notifyListeners();
  }

  // changeFourthAppBar(FourthPageBottomTabs v) {
  //   if (currentTabIndex == 0) {
  //     fourthAppBarTitle = AppBarTitles.creditlines;
  //   } else if (currentTabIndex == 1) {
  //     fourthAppBarTitle = AppBarTitles.fIS;
  //   } else if (currentTabIndex == 2) {
  //     fourthAppBarTitle = AppBarTitles.settlements;
  //   }
  //   notifyListeners();
  // }

  void setFourthTabIndex(int v) {
    currentFourthTabIndex.value = v;
    notifyListeners();
  }

  void changeHomeBottomTab(HomePageBottomTabs v, context) {
    homeScreenBottomTabs.value = v;
    switch (v) {
      case HomePageBottomTabs.dashboard:
        homeappBarTitle.value = "dashBoard";
        notifyListeners();
        break;
      case HomePageBottomTabs.requests:
        homeappBarTitle.value = "request";
        notifyListeners();
        break;
      case HomePageBottomTabs.settings:
        homeappBarTitle.value = "settings";
        notifyListeners();
        break;
      case HomePageBottomTabs.accountBalance:
        homeappBarTitle.value = "accountBalance";
        notifyListeners();
        break;

      default:
        homeappBarTitle.value = "dashBoard";
    }
    notifyListeners();
  }

  void setSalesTabIndex(int v) {
    currentSalesIndex.value = v;
    notifyListeners();
  }

  void onChangedTab(context, int index) {
    if (index != 2) {
      selectedNumberPrevious.value = index;
    }
    selectedNumberMainTab.value = index;
    tabController.animateTo(index);
    notifyListeners();
  }

  void onChangedTab1(context) {
    selectedNumberMainTab.value = selectedNumberPrevious.value;
    tabController.animateTo(selectedNumberPrevious.value);
    notifyListeners();
  }

  void onChangedTabToManageAccount(context) {
    selectedNumberMainTab.value = 0;
    tabController.animateTo(selectedNumberMainTab.value);
    changeHomeBottomTab(HomePageBottomTabs.settings, context);
    settingTabTitle = HomePageSettingTabs.manageAccounts;
    notifyListeners();
  }

  void changeSettingsTabBar(HomePageSettingTabs v) {
    settingTabTitle = v;
    notifyListeners();
  }

  void setDashBoardInitialPage(context) {
    selectedNumberMainTab.value = 0;
    changeHomeBottomTab(HomePageBottomTabs.dashboard, context);
    notifyListeners();
  }

  void setBottomTabBarTSales(context) {
    selectedNumberMainTab.value = 1;
    DefaultTabController.of(context).animateTo(1);
    currentSalesIndex.value = 1;
    notifyListeners();
  }

  void setBottomTabBarTOrder(context) {
    selectedNumberMainTab.value = 1;
    DefaultTabController.of(context).animateTo(1);
    currentSalesIndex.value = 0;
    staticScreenBottomTabs.value = StaticTabs.orders;
    notifyListeners();
  }

  getComponentsReady() async {
    await getTaxIdType();
    await getCustomerType();
    await getRetailerRolesList();
    getGracePeriodGroup();
    getPricingGroup();
    getSalesZone();
    getRetailerList();
    notifyListeners();
  }

  Future getComponentsRetailerReady() async {
    await getAllFieListForCreditLine();

    await getRetailerBankList();
    await getTaxIdType();
    await getRetailerRolesList();
    await _repositoryOrder.getOrderBanners();
  }

  getTaxIdType() async {
    bool connection = await checkConnectivity();
    Utils.fPrint(NetworkUrls.taxIdType);
    if (connection) {
      Response response = await _webService.getRequest(NetworkUrls.taxIdType);
      Utils.fPrint('response.body');
      Utils.fPrint(response.body);
      _deviceStorage.setString(DataBase.taxIdType, jsonEncode(response.body));
      taxIdType = TaxIdType.fromJson(jsonDecode(response.body));
    }
  }

  Future getRetailerRolesList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.getRequest(NetworkUrls.retailerRolesList);

      _deviceStorage.setString(
          DataBase.retailerRoleList, jsonEncode(response.body));
      retailerRolesList.value =
          RetailerRolesModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    }
  }

  Future getCustomerType() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.getRequest(NetworkUrls.customerType);

      _deviceStorage.setString(
          DataBase.customerType, jsonEncode(response.body));
      customerType = CustomerTypeModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    }
  }

  Future getGracePeriodGroup() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.getRequest(NetworkUrls.gracePeriodGroup);
      _deviceStorage.setString(
          DataBase.gracePeriodGroup, jsonEncode(response.body));
      gracePeriodGroup =
          GracePeriodGroupModel.fromJson(jsonDecode(response.body));
    }
  }

  Future getPricingGroup() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response =
          await _webService.getRequest(NetworkUrls.pricingGroup);
      _deviceStorage.setString(
          DataBase.pricingGroup, jsonEncode(response.body));
      pricingGroup = PricingGroupModel.fromJson(jsonDecode(response.body));
    }
  }

  void getSalesZone() async {
    bool connection = await checkConnectivity();
    if (connection) {
      Response response = await _webService.getRequest(NetworkUrls.salesZone);
      _deviceStorage.setString(
          DataBase.salesZoneRoute, jsonEncode(response.body));
      salesZone = SalesZoneModel.fromJson(jsonDecode(response.body));
    }
  }

  Future getCountry() async {
    bool connection = await checkConnectivity();
    if (connection) {
      if (allCountryData.value.data == null) {
        Response response =
            await _webService.getRequest(NetworkUrls.countryUri);
        _deviceStorage.setString(
            DataBase.allCountry, jsonEncode(response.body));
        allCountryData.value =
            AllCountryModel.fromJson(jsonDecode(response.body));
      }
    }
  }

  Future getCity() async {
    bool connection = await checkConnectivity();
    if (connection) {
      if (allCityData.value.data == null) {
        Response response = await _webService.getRequest(NetworkUrls.cityUri);
        _deviceStorage.setString(DataBase.allCity, response.body);
        allCityData.value = AllCityModel.fromJson(jsonDecode(response.body));
      }
    } else {
      var data = _deviceStorage.getString(DataBase.allCity);
      allCityData.value = AllCityModel.fromJson(jsonDecode(data));
    }
  }

  Future getAllFieListForCreditLine() async {
    Utils.fPrint(NetworkUrls.allFieListForCreditLine);

    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response =
            await _webService.getRequest(NetworkUrls.allFieListForCreditLine);
        allFieCreditLine =
            FieCreditLineRequestModel.fromJson(jsonDecode(response.body));
        Utils.fPrint(NetworkUrls.allFieListForCreditLine);

        if (!kIsWeb) {
          _localData.insert(
              TableNames.fieFistForCreditlineRequest, allFieCreditLine.data!);
        }

        notifyListeners();
      } catch (_) {
        rethrow;
      }
    }
  }

  Future getWholesalerWithCurrency() async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.partnerWithCurrencyList);
      wholesalerWithCurrency.value =
          PartnerWithCurrencyList.fromJson(jsonDecode(response.body));
      Utils.fPrint('wholesalerWithCurrency');
      Utils.fPrint(jsonEncode(wholesalerWithCurrency.value));
      notifyListeners();
    } catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  // final Connectivity _connectivity = Connectivity();
  getStoreList() {
    sortedStoreList.value = storeList;
    notifyListeners();
  }

  Future getRetailerListOffline() async {
    await dbHelper.queryAllRows(TableNames.retailerList).then((value) {
      retailerList = value
          .map((d) => RetailerListData(
              bpIdR: d['bp_id_r'],
              internalId: d['internal_id'],
              associationUniqueId: d['association_unique_id'],
              retailerName: d['retailer_name'],
              fieName: d['fie_name'],
              hasActiveCreditline:
                  d['has_active_creditline'] == 0 ? false : true,
              storeList: d['store_list']))
          .toList();
      notifyListeners();
    });
    await dbHelper.queryAllRows(TableNames.storeList).then((value) {
      storeList = value.map((d) => StoreList.fromJson(d)).toList();
      notifyListeners();
    });
    getStoreList();
  }

  // RetailerListData(
  //     bpIdR:,
  //       internalId:,
  //       associationUniqueId:,
  //       retailerName:,
  //       fieName:,
  //       hasActiveCreditline:,
  //       storeList:);
  Future getRetailerList() async {
    print(_deviceStorage.getString(DataBase.userToken));
    dbHelper.queryAllRows(TableNames.retailerList).then((value) {
      retailerList = value
          .map((d) => RetailerListData(
              bpIdR: d['bp_id_r'],
              internalId: d['internal_id'],
              associationUniqueId: d['association_unique_id'],
              retailerName: d['retailer_name'],
              fieName: d['fie_name'],
              hasActiveCreditline:
                  d['has_active_creditline'] == 0 ? false : true,
              storeList: d['store_list']))
          .toList();
      notifyListeners();
    });
    dbHelper.queryAllRows(TableNames.storeList).then((value) {
      storeList = value.map((d) => StoreList.fromJson(d)).toList();

      notifyListeners();
    });
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response =
            await _webService.getRequest(NetworkUrls.getRetailerStoreList);
        Utils.fPrint('response.body');
        Utils.fPrint(response.body);
        RetailerListModel retailerListModel =
            RetailerListModel.fromJson(jsonDecode(response.body));
        retailerList = retailerListModel.data!;
        for (RetailerListData item in retailerList) {
          var d = {
            'bp_id_r': item.bpIdR,
            'internal_id': item.internalId,
            'association_unique_id': item.associationUniqueId,
            'retailer_n'
                'ame': item.retailerName,
            'has_active_creditline': item.hasActiveCreditline! ? 1 : 0,
            'fie_name': item.fieName
          };
          if (!kIsWeb) {
            _localData.insertSingleData(TableNames.retailerList, d);
          }
        }

        if (!kIsWeb) {
          for (RetailerListData item in retailerListModel.data!) {
            _localData.insert(TableNames.storeList, item.storeList);
          }
        }

        dbHelper.queryAllRows(TableNames.storeList).then((value) {
          storeList = value.map((d) => StoreList.fromJson(d)).toList();
          notifyListeners();
        });
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  void getNewSortedList(String? associationId) {
    sortedStoreList.value = storeList
        .where((element) => element.associationId == associationId)
        .toList();
    // sortedStoreList = v;
  }

  void getSortedStore(String? associationUniqueId) {
    dbHelper
        .queryAllSortedRows(
      TableNames.storeList,
      DataBaseHelperKeys.associationIdStore,
      associationUniqueId,
    )
        .then((value) {
      sortedStoreList.value = value.map((d) => StoreList.fromJson(d)).toList();
      notifyListeners();
    });
  }

  Future getRetailerBankList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        Response response =
            await _webService.getRequest(NetworkUrls.retailerBankList);
        BankList retailerBankListObject =
            BankList.fromJson(jsonDecode(response.body));

        Utils.fPrint('NetworkUrls.retailerBankList');
        Utils.fPrint(response.body);
        retailerBankList.value = retailerBankListObject.data!;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List<RetailerListData>> getRetailerListWeb() async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.getRetailerStoreList);
      Utils.fPrint('response.body');
      Utils.fPrint(response.body);
      RetailerListModel retailerListModel =
          RetailerListModel.fromJson(jsonDecode(response.body));
      retailerList = retailerListModel.data!;

      notifyListeners();
      return retailerList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FieCreditLineRequestData>?>
      getAllFieListForCreditLineWeb() async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.allFieListForCreditLine);
      allFieCreditLine =
          FieCreditLineRequestModel.fromJson(jsonDecode(response.body));
      return allFieCreditLine.data!;
    } catch (_) {
      return null;
    }
  }

  Future<void> addCustomerType(Map<String, String> body, bool isEdit) async {
    Response response = await _webService.postRequest(
        isEdit
            ? NetworkUrls.addCustomerTypesUpdate
            : NetworkUrls.addCustomerTypes,
        body);
    ResponseMessageModel res =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    Utils.toast(res.message!, isSuccess: res.success!);
  }

  Future<void> addGracePeriod(Map<String, String> body, bool isEdit) async {
    Response response = await _webService.postRequest(
        isEdit
            ? NetworkUrls.addGracePeriodGroupsUpdate
            : NetworkUrls.addGracePeriodGroups,
        body);
    ResponseMessageModel res =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    Utils.toast(res.message!, isSuccess: res.success!);
  }

  Future<ResponseMessageModel> addPricingGroup(
      Map<String, String> body, bool isEdit, String? uid) async {
    Response response = isEdit
        ? (await _webService.putRequest(
            "${NetworkUrls.addPricingGroups}/$uid", body))
        : (await _webService.postRequest(NetworkUrls.addPricingGroups, body));
    ResponseMessageModel res =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
    return res;
  }
}
