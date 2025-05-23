import 'dart:convert';

import 'package:bingo/repository/repository_website_statements.dart';
import 'package:intl/intl.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../widgets/alert/confirmation_dialog.dart';
import '../statement_sales_details/statement_sales_details_view_model.dart';
import '/app/locator.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/utils.dart';
import '/data_models/models/all_sales_model/all_sales_model.dart';
import '/repository/repository_components.dart';
import '/repository/repository_retailer.dart';
import '/repository/repository_sales.dart';
import '/repository/repository_wholesaler.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:stacked/stacked.dart';

import '../../../app/router.dart';
import '../../../const/connectivity.dart';
import '../../../data_models/construction_model/route_to_sale_model/route_to_sale_model.dart';
import '../../../data_models/construction_model/routes_argument_model/routes_argument_model.dart';
import '../../../data_models/construction_model/sale_edit_data/sale_edit_data.dart';
import '../../../data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import '../../../data_models/models/retailer_fiancial_statement_model/retailer_fiancial_statement_model.dart';
import '../../../data_models/models/retailer_sale_financial_statements/retailer_sale_financial_statements.dart';
import '../../../data_models/models/retailer_settlement_list_model/retailer_settlement_list_model.dart';
import '../../../data_models/models/routes_model/routes_model.dart';
import '../../../data_models/models/sales_zones/sales_zones.dart';
import '../../../data_models/models/today_decline_reason_model/today_decline_reason_model.dart';
import '../../../data_models/models/today_route_list_model/today_route_list_model.dart';
import '../../../main.dart';
import '../../../services/connectivity/connectivity.dart';
import '../../../services/storage/db.dart';
import '../../../services/storage/device_storage.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/bool_return_alert_dialog.dart';
import '../../widgets/alert/today_sale_decline.dart';
import '../../widgets/alert/today_sale_more_desplay.dart';
import '../statement_sales_details/statement_sales_details_view.dart';

class FourthTabViewModel extends ReactiveViewModel {
  FourthTabViewModel() {
    if (enrollment == UserTypeForWeb.wholesaler) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        getTodayRouteList();
      });
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkInternet();
      isTutorialOneVisit();
    });
    callDynamicApi();
    print('hasDynamicRoutesNextPage');
    print(hasDynamicRoutesNextPage);
    notifyListeners();
  }

  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final ConnectivityService _connectivityService =
      locator<ConnectivityService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryWebsiteStatement statement =
      locator<RepositoryWebsiteStatement>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  bool isLoaderBusy = false;
  bool staticRouteBusy = false;
  bool dynamicRouteBusy = false;
  bool staticZoneBusy = false;
  int statementCardNumber = 0;

  /// today route list, example for show example
  /// ```

  TodayRouteListData get todayRouteList =>
      _repositoryWholesaler.todayRouteList.value;

  bool rFinStatLoadMoreButton = false;

  bool hasDynamicRoutesNextPage = false;

  List<SubgroupData> rFinStatdata = [];

  List<RoutesModelData> get dynamicRoutes =>
      _repositoryWholesaler.dynamicRoutes.value;

  List<RoutesModelData> get staticRoutes =>
      _repositoryWholesaler.staticRoutes.value;

  List<SaleZonesData> get saleZones => _repositoryWholesaler.saleZones.value;

  List<SettlementsListData> settlementList = [];

  int get currentTabIndex => _repositoryComponents.currentFourthTabIndex.value;

  bool get connection => _repositoryComponents.internetConnection.value;

  List<ApproveCreditlineRequestData> get approveCreditlineRequestData =>
      _repositoryRetailer.approveCreditlineRequestData.value;

  Widget get connectivityWidget => _connectivityService.connectionStream();

  bool noInternet = false;
  bool isVisitTutorialOne = true;
  GlobalKey one = GlobalKey();
  String creditlinesSortedItem = AppLocalizations.of(activeContext)!.status;

  String settlementsSortedItem = AppLocalizations.of(activeContext)!.status;

  int get logisticTab => _repositoryComponents.logisticTab;

  String get language => _authService.selectedLanguageCode;

  List<TodayDeclineReasonsData> _todayDeclineReasons = [];

  List<TodayDeclineReasonsData> get todayDeclineReasons => _todayDeclineReasons;

  List<RetailerSaleFinancialStatementsData>
      retailerSaleFinancialStatementsList = [];

  Future<void> clear() async {
    bool confirm =
        await _navigationService.displayDialog(const ConfirmationDialog(
      title: "Clear todo list",
      content: "Do you really want to clear the todo list?",
      submitButtonText: "Confirm",
    ));
    if (confirm) {
      setBusy(true);
      notifyListeners();
      await _repositoryWholesaler.clearToDo();
      Utils.toast("Your todo list has cleared!");
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> gotoStatementSalesDetails(String saleId, String invoice) async {
    if (saleId.isNotEmpty) {
      bool isConfirm = (await _navigationService.pushNamed(
              Routes.statementSalesDetails,
              arguments: StatementListToDetailsArguments(
                  saleId: saleId, invoice: invoice))) ??
          false;
      if (isConfirm) {
        await getFinancialStatement(date);
      }
    }
  }

  Future<void> changeTab(int i) async {
    _repositoryComponents.changeTabFourth(i);
    notifyListeners();
  }

  Future<void> changeStatementCardNumber(int i) async {
    if (statementCardNumber == i) {
      statementCardNumber = 0;
    } else {
      statementCardNumber = i;
    }
    print(statementCardNumber);
    notifyListeners();
  }

  Future<void> callDynamicApi() async {
    makePageBusy(true);
    notifyListeners();
    await _repositoryWholesaler.getDynamicRoutesList();
    hasDynamicRoutesNextPage = _repositoryWholesaler.hasDynamicRoutesNextPage;
    makePageBusy(false);
    notifyListeners();
  }

  Future loadMoreDynamicRoutes() async {
    makePageBusy(true);
    notifyListeners();
    await _repositoryWholesaler.loadMoreDynamicRoutesList();
    hasDynamicRoutesNextPage = _repositoryWholesaler.hasDynamicRoutesNextPage;
    makePageBusy(false);
    notifyListeners();
  }

  int settlementPage = 1;
  bool settlementPageAvailable = false;
  Future getRetailerSettlementList() async {
    settlementPage = 1;
    setBusyForObject(settlementList, true);
    notifyListeners();
    SettlementsListModel? d = await _repositoryRetailer
        .getRetailerSettlementList(settlementPage.toString());
    settlementPageAvailable = d!.data!.nextPageUrl!.isNotEmpty ? true : false;
    settlementList = _repositoryRetailer.settlementList.value;
    setBusyForObject(settlementList, false);
    notifyListeners();
  }

  Future loadMoreRetailerSettlementList() async {
    settlementPage += 1;
    setBusyForObject(settlementList, true);
    notifyListeners();
    SettlementsListModel? d = await _repositoryRetailer
        .getRetailerSettlementList(settlementPage.toString());
    settlementPageAvailable = d!.data!.nextPageUrl!.isNotEmpty ? true : false;
    settlementList = _repositoryRetailer.settlementList.value;
    setBusyForObject(settlementList, false);
    notifyListeners();
  }

  Future pullToRefreshDynamicRoutes() async {
    dynamicRouteBusy = true;
    notifyListeners();
    await _repositoryWholesaler.pullToRefreshDynamicRoutes();
    dynamicRouteBusy = false;
    notifyListeners();
  }

  Future pullToRefreshStaticRoutes() async {
    staticRouteBusy = true;
    notifyListeners();
    await _repositoryWholesaler.pullToRefreshStaticRoutes();
    staticRouteBusy = false;
    notifyListeners();
  }

  Future pullToRefreshSalesZone() async {
    staticZoneBusy = true;
    notifyListeners();
    await _repositoryWholesaler.pullToRefreshSalesZone();
    staticZoneBusy = false;
    notifyListeners();
  }

  Future checkInternet() async {
    bool connection = await checkConnectivity();
    noInternet = !connection;
    print(connection);
    if (connection) {
      if (enrollment == UserTypeForWeb.retailer) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          getCreditline();
          await getFinancialStatement(date);
          getRetailerSettlementList();
        });
      }
    }
    notifyListeners();
  }

  gotoCreditlineDetails(int index) {
    _navigationService.pushNamed(Routes.retailerCreditlineListView,
        arguments: approveCreditlineRequestData[index]);
  }

  Future<void> gotoRoutesDetails(
      String? uniqueId, String? routeId, bool isDynamic) async {
    _navigationService.pushNamed(Routes.routeDetails,
        arguments:
            RoutesZoneArgumentModel(uniqueId!, routeId!, isDynamic, false));
    // print("cbalhcgaihdfkjalhdkja");
    // bool d = todayRouteList.pendingToAttendStores!
    //     .where((e) => e.routeId == uniqueId)
    //     .isNotEmpty;
    //
    // bool response =
    //     await _navigationService.animatedDialog(BoolReturnAlertDialog(
    //           d
    //               ? AppLocalizations.of(activeContext)!
    //                   .routeLoaderAlertDialogMessageRemove
    //               : AppLocalizations.of(activeContext)!
    //                   .routeLoaderAlertDialogMessageAdd,
    //           yesButton: AppLocalizations.of(activeContext)!.yesText,
    //           noButton: AppLocalizations.of(activeContext)!.noText,
    //         )) ??
    //         false;
    // if (response) {
    //   setBusy(true);
    //   notifyListeners();
    //   print('uniqueId');
    //   print(uniqueId);
    //   _repositoryWholesaler
    //       .addStaticRouteToTodoList(
    //     uniqueId!,
    //     isRoute: true,
    //   )
    //       .then((value) {
    //     setBusy(false);
    //     notifyListeners();
    //     changeTab(0);
    //   }).catchError((_) {
    //     setBusy(false);
    //     notifyListeners();
    //   });
    // }
    // else {
    //   _navigationService.pushNamed(Routes.routeDetails,
    //       arguments:
    //           RoutesZoneArgumentModel(uniqueId!, routeId!, isDynamic, false));
    // }
  }

  Future<void> gotoSalesZoneDetails(
      String? uniqueId, String? saleId, bool isDynamic) async {
    _navigationService.pushNamed(Routes.routeDetails,
        arguments:
            RoutesZoneArgumentModel(uniqueId!, saleId!, isDynamic, true));
    // bool d = todayRouteList.pendingToAttendStores!
    //     .where((e) => e.routeId == uniqueId)
    //     .isNotEmpty;
    //
    // bool response =
    //     await _navigationService.animatedDialog(BoolReturnAlertDialog(
    //           d
    //               ? AppLocalizations.of(activeContext)!
    //                   .zoneLoaderAlertDialogMessageRemove
    //               : AppLocalizations.of(activeContext)!
    //                   .zoneLoaderAlertDialogMessageAdd,
    //           yesButton: AppLocalizations.of(activeContext)!.yesText,
    //           noButton: AppLocalizations.of(activeContext)!.noText,
    //         )) ??
    //         false;
    // if (response) {
    //   setBusy(true);
    //   notifyListeners();
    //   await _repositoryWholesaler
    //       .addStaticRouteToTodoList(
    //     uniqueId!,
    //     isRoute: false,
    //   )
    //       .then((value) {
    //     setBusy(false);
    //     notifyListeners();
    //     changeTab(0);
    //   }).catchError((_) {
    //     setBusy(false);
    //     notifyListeners();
    //   });
    // }
    // else {
    //   _navigationService.pushNamed(Routes.routeDetails,
    //       arguments:
    //           RoutesZoneArgumentModel(uniqueId!, saleId!, isDynamic, true));
    // }
  }

  void settlementsSortList(String e) {
    _repositoryRetailer.sortSettlementsList(e);
    settlementsSortedItem = e;
    notifyListeners();
  }

  void creditlineSortList(String e) {
    _repositoryRetailer.sortCreditlineList(e);
    // getCreditlinesSortedItem(v: e);
    creditlinesSortedItem = e;
    notifyListeners();
  }

  double progressBarCreditLine(int i) {
    return double.parse(approveCreditlineRequestData[i]
            .amountAvailable!
            .replaceAll(",", "")) /
        double.parse(approveCreditlineRequestData[i]
            .approvedAmount!
            .replaceAll(",", ""));
  }

  void readQrScanner(BuildContext context) async {
    _repositorySales.startBarcodeScanner2(context,
        enrollment == UserTypeForWeb.retailer, _authService.user.value);
  }

  void setTabIndex(int v) {
    _repositoryComponents.setFourthTabIndex(v);
  }

  List<DateTime> date = [
    DateTime.now().subtract(const Duration(days: 10)),
    DateTime.now()
  ];

  List<DateTime> get dateDynamicRoutes =>
      _repositoryWholesaler.dateDynamicRoutes;

  String contractAccount(String v) {
    List<String> data = v.replaceAll(")", "").split("(");
    print(v);
    print(data);
    if (data.length == 3) {
      return "${data[0]} (${data[1]}) (${data[2].lastChars(10)})";
    } else if (data.length == 1) {
      return data[0];
    } else {
      return "${data[0]} (${data[1].lastChars(10)})";
    }
  }

  openDateTime(context) async {
    date = await showDialog(
      context: activeContext,
      builder: (activeContext) => AlertDialog(
        backgroundColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        content: SizedBox(
          height: 300,
          width: 80.0.wp,
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
                selectedDayHighlightColor: AppColors.bingoGreen,
                todayTextStyle: const TextStyle(color: AppColors.redColor),
                selectedRangeHighlightColor: AppColors.bingoGreen,
                calendarType: CalendarDatePicker2Type.range,
                controlsHeight: 50),
            // initialValue: const [],
            onValueChanged: (values) async {
              if (values.length == 2) {
                List<DateTime> d = [];
                d.add(values[0]!);
                d.add(values[1]!);

                _navigationService.pop(d);
                await getDynamicRoutes(d);
              }
              notifyListeners();
            },
            value: const [],
          ),
        ),
      ),
    );
    print(date.toString());
  }

  String grandTotalFinancialStatements = "";
  int finStatPageNumber = 1;
  int finStatDocPageNumber = 1;
  List<SubgroupsWithData> selectedStrategySubgroups = [];
  List<SubgroupData> startPaymentList = [];
  void addForStartPayment(SubgroupData data) {
    statement.addForStartPayment(data);
    startPaymentList = statement.startPaymentList.value;

    notifyListeners();
  }

  goForStartPayment(String? from, String? to, String? page) {
    // if (startPaymentList.isEmpty) {
    //   startPaymentValidation = "Need to select minimum one sales documents!";
    // } else {
    //   startPaymentValidation = "";
    //   _navigationService.animatedDialog(StartPaymentDialog(from, to, page, enrollment));
    // }

    notifyListeners();
  }

  Future getFinancialStatement(List<DateTime> dates) async {
    int index = 0;
    selectedStrategySubgroups.clear();
    List<String> d = dates
        .map((e) => DateFormat("yyyy-MM-dd").format(e).toString())
        .toList();
    finStatPageNumber = 1;

    setBusyForObject(rFinStatdata, true);
    notifyListeners();
    await statement.getRetailerWholesalerFinancialStatements(
        finStatPageNumber, d, '0:00:00.000000');
    StatementWebModel getData = statement.financialStatementsData;
    grandTotalFinancialStatements = getData.data!.grandTotal!;
    notifyListeners();
    selectedStrategySubgroups = getData.data!.info!.selectedStrategySubgroups!
        .map((e) =>
            SubgroupsWithData(groupName: e, subgroupData: [], groupId: index++))
        .toList();


    for (Subgroups v in getData.data!.financialStatements!.subgroups!) {
      String groupTitle = v.subgroupMetadata!.groupTitle!;
      int index = selectedStrategySubgroups
          .indexWhere((e) => e.groupName == groupTitle);
      selectedStrategySubgroups[index].subgroupData!.addAll(v.subgroupData!);
    }
    if (getData.data!.nextPageUrl!.isNotEmpty) {
      rFinStatLoadMoreButton = true;
    } else {
      rFinStatLoadMoreButton = false;
    }
    setBusyForObject(rFinStatdata, false);
    notifyListeners();
  }

  Future loadMoreFinancialStatement() async {
    List<String> d =
        date.map((e) => DateFormat("yyyy-MM-dd").format(e).toString()).toList();
    finStatPageNumber = finStatPageNumber + 1;
    makePageBusy(true);

    await statement.getRetailerWholesalerFinancialStatements(
        finStatPageNumber, d, '0:00:00.000000');
    StatementWebModel getData = statement.financialStatementsData;

    for (Subgroups v in getData.data!.financialStatements!.subgroups!) {
      String groupTitle = v.subgroupMetadata!.groupTitle!;
      int index = selectedStrategySubgroups
          .indexWhere((e) => e.groupName == groupTitle);
      selectedStrategySubgroups[index].subgroupData!.addAll(v.subgroupData!);
    }
    if (getData.data!.nextPageUrl!.isNotEmpty) {
      rFinStatLoadMoreButton = true;
    } else {
      rFinStatLoadMoreButton = false;
    }
    makePageBusy(false);
    notifyListeners();
  }

  Future<void> createPayment(BuildContext context) async {
    setBusyForObject(rFinStatdata, true);
    String ids = startPaymentList
        .map((e) => e.saleUniqueId)
        .toList()
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(" ", "");
    ResponseMessages? responseBody =
        await statement.createPaymentOnWebsite(ids);

    if (responseBody!.success!) {
      if (context.mounted) {
        await getFinancialStatement(date);
        startPaymentList.clear();
        setBusyForObject(rFinStatdata, false);
        Utils.toast(responseBody.message!);
      }
    }
    setBusyForObject(rFinStatdata, false);
  }

  bool get isDay => statement.isDay;
  Future<void> changeWeekOrDay(
      bool v, String? page, BuildContext context) async {
    statement.changeWeekOrDay(v);

    await getFinancialStatement(date);

    notifyListeners();
  }

  Future getCreditline() async {
    finStatPageNumber = 1;
    setBusyForObject(approveCreditlineRequestData, true);
    notifyListeners();
    await _repositoryRetailer.getRetailerCreditlineList();

    setBusyForObject(approveCreditlineRequestData, false);
    notifyListeners();
  }

  Future getDynamicRoutes(List<DateTime> dates) async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.changeDate(dates);
    setBusy(false);
    notifyListeners();
  }

  makePageBusy(bool b) {
    isLoaderBusy = b;
    notifyListeners();
  }

  Future pullToRefreshCreditline() async {
    setBusyForObject(approveCreditlineRequestData, true);
    notifyListeners();
    await _repositoryRetailer.getRetailerCreditlineList();

    setBusyForObject(approveCreditlineRequestData, false);
    notifyListeners();
  }

  gotoSettlementsDetails(String s, BuildContext context) {
    if (connection) {
      _navigationService.pushNamed(Routes.settlementDetailsScreenView,
          arguments: s);
    } else {
      Utils.toast(AppLocalizations.of(context)!.noInternet, isBottom: true);
    }
  }

  ////today functionalities
  void isTutorialOneVisit() {
    isVisitTutorialOne = _storage.getBool(DataBase.isVisitTutorialOne);
    notifyListeners();
  }

  void setTutorialOneVisited() {
    _storage.setBool(DataBase.isVisitTutorialOne, true);
    isVisitTutorialOne = true;
    notifyListeners();
  }

  BuildContext? ctx;

  void stageReady(context) {
    ctx = context;
    ShowCaseWidget.of(context).startShowCase([one]);
    notifyListeners();
  }

  openMoreOption(int k, {required isPending, String saleId = ""}) async {
    print('todayRouteList.pendingToAttendStores![k]');
    print(jsonEncode(todayRouteList.pendingToAttendStores![k]));
    String latDir = todayRouteList.pendingToAttendStores![k].lattitude!;
    String longDir = todayRouteList.pendingToAttendStores![k].longitude!;
    var locationData = {
      "latDir": latDir,
      "longDir": longDir,
    };
    print('locationData');
    print(locationData);
    _navigationService.displayBottomSheet(TodaySaleMoreDisplay(
        k, FourthTabViewModel(),
        isPending: isPending, saleId: saleId, locationData: locationData));
  }

  reOpenClosedTask(
      {String? routeId, required String storeId, String saleId = ""}) async {
    bool connection = await checkConnectivity();
    if (!connection) {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(
            AlertDialogMessage(AppLocalizations.of(activeContext)!.noInternet));
      }
    } else {
      bool isConfirm = await _navigationService.animatedDialog(
              BoolReturnAlertDialog(
                  AppLocalizations.of(activeContext)!.reopenSaleRoute)) ??
          false;
      if (isConfirm) {
        var body = saleId.isEmpty
            ? {"w_route_zone_id": routeId, "store_id": storeId, "status": "3"}
            : {
                "w_route_zone_id": routeId,
                "store_id": storeId,
                "sale_unique_id": saleId,
                "status": "3"
              };
        print(jsonEncode(body));
        setBusy(true);
        notifyListeners();
        await _repositoryWholesaler.markAsDone(body);

        setBusy(false);
        notifyListeners();
      }
    }
  }

  Future<void> markAsDone(int k, {String saleId = ""}) async {
    bool connection = await checkConnectivity();
    if (!connection) {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(
            AlertDialogMessage(AppLocalizations.of(activeContext)!.noInternet));
      }
    } else {
      setBusy(true);
      notifyListeners();
      bool isConfirm = await _navigationService.animatedDialog(
              BoolReturnAlertDialog(
                  AppLocalizations.of(activeContext)!.completeSale)) ??
          false;
      if (isConfirm) {
        var body = saleId.isEmpty
            ? {
                "w_route_zone_id":
                    todayRouteList.pendingToAttendStores![k].routeId,
                "store_id":
                    todayRouteList.pendingToAttendStores![k].retailerStoreId,
                "status": "1"
              }
            : {
                "w_route_zone_id":
                    todayRouteList.pendingToAttendStores![k].routeId,
                "store_id":
                    todayRouteList.pendingToAttendStores![k].retailerStoreId,
                "status": "1",
                "sale_unique_id": saleId
              };
        print(jsonEncode(body));
        await _repositoryWholesaler.markAsDone(body);

        setBusy(false);
        notifyListeners();
      } else {
        setBusy(false);
        notifyListeners();
      }
    }
  }

  Future<void> getTodayStoreDeclineReasonList() async {
    bool connection = await checkConnectivity();
    if (connection) {
      if (enrollment == UserTypeForWeb.wholesaler) {
        await _repositoryWholesaler.getTodayStoreDeclineReasonList();
        _todayDeclineReasons = _repositoryWholesaler.todayDeclineReasons;
        notifyListeners();
      }
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      }
    }
  }

  Future<void> declineSale(int k, {String saleId = ""}) async {
    bool connection = await checkConnectivity();
    if (!connection) {
      if (activeContext.mounted) {
        _navigationService.animatedDialog(
            AlertDialogMessage(AppLocalizations.of(activeContext)!.noInternet));
      }
    } else {
      Map<String, String>? data = await _navigationService
          .animatedDialog(TodaySaleDecline(todayDeclineReasons));

      if (data != null) {
        Map<String, String> body = saleId.isEmpty
            ? {
                "w_route_zone_id":
                    todayRouteList.pendingToAttendStores![k].routeId!,
                "store_id":
                    todayRouteList.pendingToAttendStores![k].retailerStoreId!,
                "status": "2"
              }
            : {
                "w_route_zone_id":
                    todayRouteList.pendingToAttendStores![k].routeId!,
                "store_id":
                    todayRouteList.pendingToAttendStores![k].retailerStoreId!,
                "sale_unique_id": saleId,
                "status": "2"
              };
        body.addAll(data);
        setBusy(true);
        notifyListeners();
        await _repositoryWholesaler.markAsDone(body);
        await pullTodoForRefresh();
        setBusy(false);
        notifyListeners();
      }
    }
  }

  void salesExecution(AllSalesData allSalesData, String routeId) {
    print('allSalesData');
    print(jsonEncode(allSalesData));
    _navigationService.pushNamed(Routes.salesDetailsScreen,
        arguments: SaleEditData(
            allSalesData: allSalesData,
            saleEditScreens: SaleEditScreens.today,
            routeZoneId: routeId));
  }

  void saleAddition(PendingToAttendStores pendingToAttendStores, bool isPending,
      {String saleId = ""}) {
    print(isPending);
    if (isPending) {
      _navigationService.pushNamed(Routes.addSales,
          arguments: RouteToSaleModel(
            routeId: pendingToAttendStores.routeId,
            retailerId: pendingToAttendStores.bpIdR,
            storeId: pendingToAttendStores.retailerStoreId!,
            salesType: pendingToAttendStores.salesStep ?? "",
          ));
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        reOpenClosedTask(
            routeId: pendingToAttendStores.routeId,
            storeId: pendingToAttendStores.retailerStoreId!,
            saleId: saleId);
      });
    }
  }

  Future pullTodoForRefresh() async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.getTodayRouteList();
    await getTodayStoreDeclineReasonList();
    setBusy(false);
    notifyListeners();
  }

  getTodayRouteList() async {
    setBusyForObject(todayRouteList, true);
    notifyListeners();
    try {
      await getTodayStoreDeclineReasonList();
      await _repositoryWholesaler.getTodayRouteList();
    } catch (e) {
      setBusyForObject(todayRouteList, false);
      // setBusy(false);
      Utils.toast("error occurred");
    }
    setBusyForObject(todayRouteList, false);
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryRetailer, _repositoryComponents, _repositoryWholesaler];
}
