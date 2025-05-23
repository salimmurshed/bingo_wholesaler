import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

// import 'package:app_settings/app_settings.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/services/storage/device_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../../const/server_status_file/manage_account_status.dart';
import '../../../data_models/enums/manage_account_from_pages.dart';
import '../../../data_models/enums/user_roles_files.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../services/storage/db.dart';
import '../../widgets/alert/bio/bio_setting_change.dart';
import '../../widgets/alert/bio/pin_change_security.dart';
import '../../widgets/alert/confirmation_dialog.dart';
import '/app/router.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/utils.dart';
import '/data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '/data_models/models/store_model/store_model.dart';
import '/main.dart';
import '/repository/repository_components.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/locator.dart';
import '../../../const/connectivity.dart';
import '../../../data/data_source/cards_properties_list.dart';
import '../../../data/data_source/date_filters.dart';
import '../../../data/data_source/invoices_data.dart';
import '../../../data/data_source/languages.dart';
import '../../../data_models/construction_model/dashboard_card_properties_model/dashboard_card_properties_model.dart';
import '../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../../data_models/construction_model/invoice_model/invoice_model.dart';
import '../../../data_models/enums/data_source.dart';
import '../../../data_models/enums/home_page_bottom_tabs.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/association_request_model/association_request_model.dart';
import '../../../data_models/models/association_request_wholesaler_model/association_request_wholesaler_model.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/component_models/retailer_role_model.dart';
import '../../../data_models/models/deposit_recommendation/deposit_recommendation.dart';
import '../../../data_models/models/get_company_profile/get_company_profile.dart';
import '../../../data_models/models/retailer_bank_account_balance_model/retailer_bank_account_balance_model.dart';
import '../../../data_models/models/retailer_credit_line_req_model/retailer_credit_line_req_model.dart';
import '../../../data_models/models/retailer_users_model/retailer_users_model.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../data_models/models/wholesaler_credit_line_model/wholesaler_credit_line_model.dart';
import '../../../repository/repository_retailer.dart';
import '../../../repository/repository_sales.dart';
import '../../../repository/repository_wholesaler.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/connectivity/connectivity.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../services/network/network_urls.dart';
import '../../features_parts/home_parts/roles.dart';
import '../../features_parts/home_parts/users.dart';
import '../../widgets/alert/bool_return_alert_dialog.dart';
import '../../widgets/alert/date_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetId {
  String id;
  RetailerTypeAssociationRequest type;
  bool isFie;

  GetId(
      {this.id = "",
      this.type = RetailerTypeAssociationRequest.wholesaler,
      this.isFie = false});
}

class HomeScreenViewModel extends ReactiveViewModel {
  HomeScreenViewModel() {
    setSettingTab();
    getHomeScreenReady();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scanCode();
      getStoreList();
      setLanguage();
      getRetailersUser();
      getRetailerBankAccountBalance();

      if (enrollment == UserTypeForWeb.retailer) {
        getDepositRecommendation(selectedDateFilter.initiate!);
        getCompanyProfile();
      }
    });
    notifyListeners();
  }

  // getRetailersUser() async {
  //   await _repositoryRetailer.getRetailersUser(userPageNumber);
  // }
  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  // bool get isUserFinanceRole {
  //   if (isRetailer) {
  //     return userRoles.contains(UserRoles.finance) ||
  //         userRoles.contains(UserRoles.master);
  //   }
  //   return false;
  // }
  //
  // bool get isUserAdminRole {
  //   if (isRetailer) {
  //     return userRoles.contains(UserRoles.admin) ||
  //         userRoles.contains(UserRoles.master);
  //   }
  //   return false;
  // }

  printToken() {
    log(user.data!.token!);
  }

  getCompanyProfile() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getCompanyProfile().then((value) async {
      await Future.delayed(const Duration(seconds: 2));
      preFillDataCompanyProfile();
    });
    setBusy(false);
    notifyListeners();
  }

  Future getCompanyProfilePullToRefresh() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getCompanyProfile().then((value) async {
      await Future.delayed(Duration(seconds: 2));
      preFillDataCompanyProfile();
    });
    setBusy(false);
    notifyListeners();
  }

  getRetailerBankAccountBalance() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerBankAccountBalance();
    setBusy(false);
    notifyListeners();
  }

  Future refreshRetailerBankAccountBalance() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerBankAccountBalance();
    setBusy(false);
    notifyListeners();
  }

  Future getRoles() async {
    setBusy(true);
    notifyListeners();
    await _repositoryComponents.getRetailerRolesList();
    setBusy(false);
    notifyListeners();
  }

  int userPageNumber = 1;
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  TextEditingController commercialNameController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  TextEditingController mainProductController = TextEditingController();
  TextEditingController webUrlController = TextEditingController();
  TextEditingController dateFoundedController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();
  String image = "";
  String commercialNameError = "";
  String informationError = "";
  String mainProductError = "";
  String webUrlError = "";
  String dateFoundedError = "";
  String aboutUsError = "";

  List<InvoiceModel> invoiceData = invoiceMock;

  List<DateFilterModel> get dateFilters => dateFilterList;

  List<StoreData> get storeData => _repositoryRetailer.storeList;

  List<RetailerBankAccountBalanceData> get retailerBankAccountBalanceData =>
      _repositoryRetailer.retailerBankAccountBalanceData;

  List<AssociationRequestData> get wholesalerAssociationRequestData =>
      _repositoryRetailer.wholesalerAssociationRequestData.value;

  List<AssociationRequestData> get fieAssociationRequestData =>
      _repositoryRetailer.fieAssociationRequestData.value;
  // List<AssociationRequestData> fieAssociationRequestData = [];

  GetCompanyProfile get userCompanyProfile =>
      _repositoryRetailer.userCompanyProfile.value;

  // _associationRequestData;

  List<AssociationRequestWholesalerData> get wholesalerAssociationRequest =>
      _repositoryWholesaler.wholesalerAssociationRequest.value;

  List<RetailerCreditLineRequestData> get retailerCreditLineRequestData =>
      _repositoryRetailer.retailerCreditLineRequestData.value;

  List<WholesalerCreditLineData> get wholesalerCreditLineRequestData =>
      _repositoryWholesaler.wholesalerCreditLineRequestData;

  List<RetailerBankListData> get retailsBankAccounts =>
      _repositoryRetailer.retailsBankAccounts.value;

  List<DashboardCardPropertiesModel> retailerCardsPropertiesList =
      retailerCardsPropertiesListData;
  List<DashboardCardPropertiesModel> wholesalerCardsPropertiesList =
      wholesalerCardsPropertiesListData;

  AllLanguage? selectedLanguage;
  List languages = allLanguages;

  bool get retailUsersLoadMoreButton =>
      _repositoryRetailer.retailUsersLoadMoreButton;

  List<RetailerUsersData> get retailersUserList =>
      _repositoryRetailer.retailersUserList.value;

  String get language => _authService.selectedLanguageCode;

  bool isUserLoadMoreBusy = false;

  List<RetailerRolesData> get retailerRolesList {
    print(_repositoryComponents.retailerRolesList.value.data);
    if (_repositoryComponents.retailerRolesList.value.data == null) {
      return [];
    } else {
      return _repositoryComponents.retailerRolesList.value.data!;
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? uploadImage;

  void picImage() async {
    uploadImage = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void deletePickImage() async {
    uploadImage = null;
    notifyListeners();
  }

  getRetailersUser() async {
    setBusyForObject(retailersUserList, true);
    notifyListeners();
    userPageNumber = 1;
    await _repositoryRetailer.getRetailersUser(userPageNumber);
    setBusyForObject(retailersUserList, false);
    notifyListeners();
  }

  Future<void> getRetailersUserPullToRefresh() async {
    setBusyForObject(retailersUserList, true);
    notifyListeners();
    userPageNumber = 1;
    await _repositoryRetailer.getRetailersUser(userPageNumber);
    setBusyForObject(retailersUserList, false);
    notifyListeners();
  }

  Future<void> selectDateFormedCompanyProfile() async {
    String date = ((await _navigationService.animatedDialog(DatePicker(
              isPreviousData: true,
            ))) ??
            DateTime.now())
        .toString();
    dateFoundedController.text =
        DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    notifyListeners();
  }

  Future<void> submitCompanyProfile() async {
    if (commercialNameController.text.isEmpty) {
      commercialNameError = AppLocalizations.of(activeContext)!
          .commercialNameValidationCompanyProfile;
    } else {
      commercialNameError = "";
    }
    if (informationController.text.isEmpty) {
      informationError = AppLocalizations.of(activeContext)!
          .informationValidationCompanyProfile;
    } else {
      informationError = "";
    }
    if (mainProductController.text.isEmpty) {
      mainProductError = AppLocalizations.of(activeContext)!
          .mainProductValidationCompanyProfile;
    } else {
      mainProductError = "";
    }
    if (webUrlController.text.isEmpty) {
      webUrlError = AppLocalizations.of(activeContext)!
          .websiteUrlValidationCompanyProfile;
    } else {
      webUrlError = "";
    }
    if (dateFoundedController.text.isEmpty) {
      dateFoundedError = AppLocalizations.of(activeContext)!
          .dateFoundedValidationCompanyProfile;
    } else {
      dateFoundedError = "";
    }
    if (aboutUsController.text.isEmpty) {
      aboutUsError =
          AppLocalizations.of(activeContext)!.aboutUsValidationCompanyProfile;
    } else {
      aboutUsError = "";
    }
    notifyListeners();
    if (commercialNameError.isEmpty &&
        informationError.isEmpty &&
        mainProductError.isEmpty &&
        webUrlError.isEmpty &&
        dateFoundedError.isEmpty &&
        aboutUsError.isEmpty) {
      makeButtonBusy(true);
      MultipartRequest request =
          _repositoryRetailer.createRequest(NetworkUrls.updateCompanyProfile);
      request.fields["commercial_name"] = commercialNameController.text;
      request.fields["information"] = informationController.text;
      request.fields["main_products"] = mainProductController.text;
      request.fields["date_founded"] = dateFoundedController.text;
      request.fields["website_url"] = webUrlController.text;
      request.fields["about_us"] = aboutUsController.text;
      if (uploadImage != null) {
        var logo = await http.MultipartFile.fromPath("logo", uploadImage!.path);
        request.files.add(logo);
      }
      http.Response response =
          await _repositoryRetailer.submitRequest(request).catchError((_) {
        makeButtonBusy(false);
      });
      if (response.statusCode == 200) {
        uploadImage = null;
        if (activeContext.mounted) {
          Utils.toast(AppLocalizations.of(activeContext)!.dataStoredMessage,
              isSuccess: true);
        }
      } else {
        Utils.toast(response.reasonPhrase!);
      }

      makeButtonBusy(false);
    } else {
      makeButtonBusy(false);
    }
  }

  void preFillDataCompanyProfile() {
    commercialNameController.text = userCompanyProfile.data!.commercialName!;
    informationController.text = userCompanyProfile.data!.information!;
    mainProductController.text = userCompanyProfile.data!.mainProducts!;
    webUrlController.text = userCompanyProfile.data!.websiteUrl!;
    dateFoundedController.text = userCompanyProfile.data!.dateFounded!;
    aboutUsController.text = userCompanyProfile.data!.aboutUs!;
    image = userCompanyProfile.data!.logo!;
    notifyListeners();
  }

  void loadMoreUsers() {
    isUserLoadMoreBusy = true;
    notifyListeners();
    userPageNumber += 1;
    _repositoryRetailer.getRetailersUser(userPageNumber);
    isUserLoadMoreBusy = false;
    notifyListeners();
  }

  setLanguage() {
    _authService.getLanguage().then((v) {
      if (_authService.selectedLanguageCode.isEmpty) {
        Locale deviceLocale = window.locale;
        String langCode = deviceLocale.languageCode;
        if (langCode == 'en' || langCode == 'es') {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == langCode);
        } else {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == 'en');
        }
        notifyListeners();
      } else {
        if (_authService.selectedLanguageCode == 'en' ||
            _authService.selectedLanguageCode == 'es') {
          selectedLanguage = allLanguages.firstWhere(
              (element) => element.code == _authService.selectedLanguageCode);
        } else {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == 'en');
        }
        notifyListeners();
      }
    });
  }

  //mock data
  // List<RecommendationModel> recommadationData = recommadationDataMockUp;

  UserModel get user => _authService.user.value;

  HomePageBottomTabs get homeScreenBottomTabs =>
      _repositoryComponents.homeScreenBottomTabs.value;

  HomePageRequestTabsW get requestTabTitleWholesaler =>
      _repositoryComponents.requestTabTitleWholesaler.value;

  HomePageRequestTabsR get requestTabTitleRetailer =>
      _repositoryComponents.requestTabTitleRetailer.value;

  HomePageSettingTabs get settingTabTitle =>
      _repositoryComponents.settingTabTitle;

  String get appBarTitle => _repositoryComponents.homeappBarTitle.value;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  bool get isMaster => _authService.user.value.data!.isMaster!;

  bool hasCreditLineNextPage = false;
  bool isButtonBusy = false;

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  setSettingTab() {
    _repositoryComponents.setSettingTab();
    notifyListeners();
  }

  ResponseMessages get globalMessage => _repositoryRetailer.globalMessage.value;

  List<AllSalesData> get pendingSaleData =>
      _repositorySales.pendingSaleData.value;

  DateFilterModel selectedDateFilter = dateFilterList[0];
  bool isDepositRecommendationBusy = false;

  List<DepositRecommendationData> get depositRecommendationData =>
      _repositoryRetailer.depositRecommendationData;

  Widget get connectivityWidget => _connectivityService.connectionStream();

  // Widget get connectionStreamApiCall =>
  //     _connectivityService.connectionStreamApiCall();

  bool get connection => _repositoryComponents.internetConnection.value;

  getStoreList() async {
    await _repositoryComponents.getRetailerListOffline();
  }

  String getDepositRecommendationError = "";

  getDepositRecommendation(String date) async {
    isDepositRecommendationBusy = true;
    notifyListeners();
    await _repositoryRetailer.getDepositRecommendation(date).then((value) {
      getDepositRecommendationError = "";
      notifyListeners();
    });
    // .catchError((error) {
    //   isDepositRecommendationBusy = false;
    //   getDepositRecommendationError =
    //       AppLocalizations.of(activeContext)!.serverError;
    //   notifyListeners();
    //   print("some arbitrary error");
    // });

    isDepositRecommendationBusy = false;
    notifyListeners();
  }

  void changeFilterDate(DateFilterModel filteredDate) {
    selectedDateFilter = filteredDate;
    getDepositRecommendation(filteredDate.initiate!);
    notifyListeners();
  }

  Future getHomeScreenReady() async {
    setBusy(true);
    notifyListeners();
    await _repositorySales.getDashboardPendingSales();
    setBusy(false);
    notifyListeners();
  }

  String getFormattedDate(String date) {
    String date0 = date.split(" ").first;
    return date.isNotEmpty
        ? DateFormat('MM/dd/yyyy').format(DateTime.parse(date0))
        : "-";
  }

  void gotoSalesDetails(AllSalesData storeList) {
    print('storeListstoreList');
    print(jsonEncode(storeList));
    _navigationService.pushNamed(Routes.salesDetailsScreen,
        arguments: OfflineOnlineSalesModel(
          allSalesData: storeList,
          isOffline: false,
        ));
  }

  //wholesaler app
  Future refreshWholesalerAssReq() async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.refreshWholesalersAssociationData();
    setBusy(false);
    notifyListeners();
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? qrInfo = 'Scan a QR/Bar code';
  bool camState = false;

  qrCallback(String? code) {
    camState = false;
    qrInfo = code;

    notifyListeners();
  }

  scanCode() {
    camState = true;
    notifyListeners();
  }

  Future refreshWholesalerCreditLine() async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.refreshCreditLinesList();
    hasCreditLineNextPage = _repositoryWholesaler.hasCreditLineNextPage.value;
    setBusy(false);
    notifyListeners();
  }

  //retailer app
  Future refreshRetailerWHSAssReq() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.refreshgRetailersAssociationData();
    setBusy(false);
    notifyListeners();
  }

  Future refreshRetailerFIEAssReq() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.refreshRetailersFieAssociationData();
    setBusy(false);
    notifyListeners();
  }

  Future refreshRetailerCreditLine() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.refreshCreditLinesList();
    setBusy(false);
    notifyListeners();
  }

  Future refreshStores() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getStores();
    setBusy(false);
    notifyListeners();
  }

  Future refreshManageAccount() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerBankAccounts();
    await _repositoryRetailer.getRetailerWholesalerList();
    await _repositoryRetailer.getRetailerFieList(1);
    setBusy(false);
    notifyListeners();
  }

  void changeSecondaryBottomTab(HomePageBottomTabs v, context) {
    _repositoryComponents.changeHomeBottomTab(v, context);
    notifyListeners();
  }

  String getAppBarTitle() {
    print(_authService.selectedLanguageCode.toLowerCase());
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
        case "security":
          return "Security";

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
        case "security":
          return "Security";

        default:
          return "DASHBOARD";
      }
    }
  }

  void changeRequestTabWholesaler(int i, BuildContext context) {
    _repositoryComponents.changeRequestTabWholesaler(i, context);
  }

  void changeRequestTabRetailer(int i, BuildContext context) {
    _repositoryComponents.changeRequestTabRetailer(i, context);
  }

  bool changeButton(scrollNotification) {
    if (scrollNotification is ScrollEndNotification) {}
    return false;
  }

  void changeSettingTab(HomePageSettingTabs title) {
    // if (title == HomePageSettingTabs.security) {
    //   _navigationService.animatedDialog(Security());
    // } else {
    _repositoryComponents.changeSettingTab(title);
    // }
  }

  Future<bool> checkInternet() async {
    bool connection = await checkConnectivity();
    if (!connection) {
      Utils.toast("There is no Internet Connection, please check again");
    }
    return connection;
  }

  //navigate services

  void gotoAddNewRequest(
      RetailerTypeAssociationRequest retailerTypeAssociationRequest) async {
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addNewAssociationRequest,
          arguments: retailerTypeAssociationRequest);
    }
  }

  void gotoAddNewStore() async {
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addStoreView);
    }
  }

  void gotoAddManageAccount() async {
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addManageAccountView);
    }
  }

  ///[CreditLine]
  void gotoAddCreditLine() async {
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addCreditLineView);
    }
  }

  void gotoViewCreditLineWholeSaler(int j) {
    _navigationService.pushNamed(Routes.viewCreditLineRequestWholesalerView,
        arguments: wholesalerCreditLineRequestData[j]);
  }

  Future<void> loadMoreCreditLineWholesaler() async {
    setBusyForObject(hasCreditLineNextPage, true);
    notifyListeners();
    await _repositoryWholesaler.loadMoreCreditLinesList();
    hasCreditLineNextPage = _repositoryWholesaler.hasCreditLineNextPage.value;
    setBusyForObject(hasCreditLineNextPage, false);
    notifyListeners();
  }

  void gotoViewStore(int j) async {
    print(storeData[j].toJson());
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addStoreView,
          arguments: storeData[j]);
    }
  }

  void gotoAssociationRequestDetailsScreen(
      String id, RetailerTypeAssociationRequest type,
      {bool isFie = false}) async {
    GetId v = GetId(id: id, type: type, isFie: isFie);
    print(id);
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.associationRequestDetailsScreen,
          arguments: v);
    }
  }

  void gotoViewManageAccount(int j) async {
    bool connection = await checkInternet();
    if (connection) {
      //RetailerBankListData
      _navigationService.pushNamed(Routes.addManageAccountView,
          arguments: ScreenBasedRetailerBankListData(
              data: retailsBankAccounts[j], page: ManageAccountFromPages.home));
    }
  }

  void gotoViewCreditLine(int j) async {
    bool connection = await checkInternet();
    if (connection) {
      _navigationService.pushNamed(Routes.addCreditLineView,
          arguments: retailerCreditLineRequestData[j].creditlineUniqueId);
    }
    print(retailerCreditLineRequestData[j].creditlineUniqueId);
  }

  void readQrScanner(BuildContext context) async {
    _repositorySales.startBarcodeScanner2(context,
        enrollment == UserTypeForWeb.retailer, _authService.user.value);
  }

  String getSaleId(String text) {
    return text.isNotEmpty ? text.lastChars(10) : "-";
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authService,
        _repositoryRetailer,
        _repositoryWholesaler,
        _repositorySales,
        _repositoryComponents,
      ];
  final key1 = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  String statusForSetting(int j) {
    return statusForSettingCheck(
        user.data!.languageCode!.toLowerCase(), retailsBankAccounts[j]);
  }
  // String statusForSetting(int j) {
  //   if (user.data!.languageCode!.toLowerCase() == 'en') {
  //     return retailsBankAccounts[j].statusDescription!;
  //   } else {
  //     switch (retailsBankAccounts[j].statusDescription!.toLowerCase()) {
  //       case "approved":
  //         return "Aprobada";
  //       case "not validated":
  //         return "No validada";
  //       case "rejected":
  //         return "Rechazada";
  //       case "validation pending":
  //         return "Pendiente de Validación";
  //     }
  //     return "";
  //   }
  // }

  String statusForConfirmationBoard(int j) {
    if (user.data!.languageCode!.toLowerCase() == 'en') {
      return pendingSaleData[j].statusDescription!;
    } else {
      switch (pendingSaleData[j].statusDescription!.toLowerCase()) {
        case "sale pending approval":
          return "Venta Pendiente de \nAprobación";
        case "pending delivery confirmation":
          return "Pendiente Confirmación \nde Entrega";
        case "sale proposal pending approval":
          return "Propuesta de Venta \nPendiente de Aprobación";
      }
      return "";
    }
  }

  String statusForCreditline(int j) {
    print(wholesalerCreditLineRequestData[j].statusDescription!.toLowerCase());
    if (user.data!.languageCode!.toLowerCase() == 'en') {
      return wholesalerCreditLineRequestData[j].statusDescription!;
    } else {
      switch (
          wholesalerCreditLineRequestData[j].statusDescription!.toLowerCase()) {
        case "pending wholesaler review":
          return "Pendiente Revisión \nde Mayorista";
        case "pending fie forward":
          return "Pendiente de Enviar \na Institución";
        case "fie queue":
          return "En cola de la Institución";
        case "association pending / fie queue":
          return "Asociación Pendiente/En \ncola de la Institución";
        case "on evaluation/association pending":
          return "En Evaluación/\nAsociación Pendiente";
        case "on evaluation":
          return "En Evaluación";
        case "rejected":
          return "Rechazada";
        case "waiting reply/association pending":
          return "Esperando Respuesta/\nAsociación Pendiente";
        case "waiting reply":
          return "Esperando Respuesta";
        case "association pending/recommended":
          return "Asociación Pendiente/\nRecomendada";
        case "recommended":
          return "Recomendada";
        case "formalized":
          return "Formalizada";
        case "approved":
          return "Aprobada";
        case "active":
          return "Activa";
        case "inactive":
          return "Inactiva";
      }
      return "";
    }
  }

  void launchMapsUrl(String originPlaceId, String destinationPlaceId) async {
    String mapOptions = [
      'origin=$originPlaceId',
      'origin_place_id=$originPlaceId',
      'destination=$destinationPlaceId',
      'destination_place_id=$destinationPlaceId',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps/dir/api=1&$mapOptions';
    if (await canLaunchUrl(Uri.parse(url))) {
      await canLaunchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  gotoUserDetails(RetailerUsersData retailersUser) {
    _navigationService.animatedDialog(UserDetails(retailersUser.uniqueId!));
  }

  RetailerUsersData usersData = RetailerUsersData();

  void getUserDetails(String uId) {
    print('getData');
    usersData =
        retailersUserList.firstWhere((element) => element.uniqueId == uId);
  }

  String statusCheckUser(status) {
    if (user.data!.languageCode!.toLowerCase() == 'en') {
      return status!;
    } else {
      switch (status!.toLowerCase()) {
        case "active":
          return "Activa";
        case "inactive":
          return "Inactiva";
      }
      return "";
    }
  }

  editUser(RetailerUsersData usersData) async {
    var body = {
      "unique_id": usersData.uniqueId,
      "status": usersData.status == 0 ? "1" : "0",
    };
    String msg = usersData.status == 0
        ? AppLocalizations.of(activeContext)!.activeUserAlertMessage
        : AppLocalizations.of(activeContext)!.inactiveUserAlertMessage;
    bool isConfirm =
        await _navigationService.animatedDialog(BoolReturnAlertDialog(msg)) ??
            false;
    if (isConfirm) {
      setBusy(true);
      notifyListeners();
      await _repositoryRetailer.inactiveUser(body);
      userPageNumber = 1;
      await _repositoryRetailer.getRetailersUser(userPageNumber);
      setBusy(false);
      notifyListeners();
    }
  }

  gotoAddNewUser() {
    _navigationService.pushNamed(Routes.addEditUsersView);
  }

  gotoEditUser(RetailerUsersData retailersUser) {
    _navigationService.pushNamed(Routes.addEditUsersView,
        arguments: retailersUser);
  }

  gotoUserRoleDetails(RetailerRolesData retailerRolesList) {
    _navigationService.animatedDialog(Roles(retailerRolesList));
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  bool isBioEnable = true;

  bool hasBio = false;
  bool supported = false;

  void canTestBio() async {
    hasBio = false;
    setBusy(true);
    notifyListeners();
    final LocalAuthentication auth = LocalAuthentication();
    supported = await auth.isDeviceSupported();
    if (supported) {
      List canAuthenticateWithBiometrics = await auth.getAvailableBiometrics();
      hasBio = canAuthenticateWithBiometrics.isNotEmpty;
      setBusy(false);
      notifyListeners();
    } else {
      setBusy(false);
      notifyListeners();
    }
  }

  changeSecurityBio(bool v, BuildContext context) async {
    if (!supported) {
      {
        bool action = await _navigationService.animatedDialog(
                BoolReturnAlertDialog(
                    AppLocalizations.of(context)!.needPhoneBio,
                    noButton: AppLocalizations.of(context)!.cancelButton,
                    yesButton: AppLocalizations.of(context)!.set)) ??
            false;
        if (action) {
          // AppSettings.openAppSettings(type: AppSettingsType.location);
        } else {
          // _navigationService.pop();
        }
      }
    } else {
      if (hasBio) {
        bool confirm = await _navigationService.animatedDialog(SizedBox(
          width: 100.0.wp,
          child: const CheckBioAuth(),
        ));
        if (confirm) {
          if (v) {
            prefs.setInt(DataBase.unlockTypeBio, 1);
          } else {
            prefs.setInt(DataBase.unlockTypeBio, 0);
          }
          isBioEnable = v;
        } else {}
        notifyListeners();
      } else {
        bool confirm = await _navigationService.animatedDialog(SizedBox(
                width: 100.0.wp,
                child: ConfirmationDialog(
                    submitButtonText: AppLocalizations.of(context)!.enable,
                    title: AppLocalizations.of(context)!.bioCheckTitle(
                        AppLocalizations.of(context)!
                            .enabled
                            .toLowerCase())))) ??
            false;
        if (confirm) {
          // AppSettings.openAppSettings(type: AppSettingsType.security);
        }
      }
    }
  }

  checkPin() {
    int unlockTypeBio = _storage.getInt(DataBase.unlockTypeBio);
    if (unlockTypeBio == 0) {
      isBioEnable = false;
    } else {
      isBioEnable = true;
    }
    // notifyListeners();
  }

  openPinDialog() async {
    setBusyForObject(openPinDialogBox, true);
    notifyListeners();
    var body =
        await _navigationService.animatedDialog(const PinChangeSecurityView());
    print('bodybody');
    print(body);
    if (body != null) {
      ResponseMessageModel? response = await _authService.changePin(body);
      if (response != null) {
        Utils.toast(response.message!, isSuccess: response.success!);
      }
    }
    // await Future.delayed(const Duration(seconds: 5));

    setBusyForObject(openPinDialogBox, false);
    notifyListeners();
  }

  String openPinDialogBox = "";
  void setPinBusy() {}
}
