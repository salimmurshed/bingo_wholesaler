import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/repository/repository_website_statements.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/component_models/response_model.dart';
import '../../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '/app/locator.dart';

import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import '../../../../const/special_key.dart';
import '../../../../data/data_source/cards_properties_list.dart';
import '../../../../data/data_source/date_filters.dart';
import '../../../../data_models/construction_model/dashboard_card_properties_model/dashboard_card_properties_model.dart';
import '../../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import '../../../widgets/web_widgets/text_fields/calender.dart';
import 'start_payment_dialog.dart';

class RetailerFinancialStatementViewModel extends ReactiveViewModel {
  final NavigationService _nav = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authService, _webBasicService, _repositoryStatement];
  List<DashboardCardPropertiesModel> retailerCardsPropertiesList =
      retailerCardsPropertiesListData;

  UserModel get user => _authService.user.value;

  List<DateFilterModel> get dateFilters => dateFilterList;
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWebsiteStatement _repositoryStatement =
      locator<RepositoryWebsiteStatement>();

  final AuthService _authService = locator<AuthService>();

  DateFilterModel selectedDateFilter = dateFilterList[0];

  ScrollController scrollController = ScrollController();
  var myGroup = AutoSizeGroup();
  String get tabNumber => _webBasicService.tabNumber.value;

  UserTypeForWeb get enrollment => _authService.enrollment.value;

  int rFinTotalData = 0;
  String grandTotalFinancialStatements = "0.00";
  String itemID = '';

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> changePage(
      int number, String? from, String? to, BuildContext context) async {
    if (from == null && to == null) {
      context.goNamed(Routes.financialStatementView,
          queryParameters: {'page': number.toString()});
    } else {
      context.goNamed(Routes.financialStatementView,
          queryParameters: {'from': from, 'to': to, 'page': number.toString()});
    }
    await getFinancialStatement(number);
    notifyListeners();
  }

  clear() {
    dateFromController.text =
        DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()).toString();
    dateToController.text =
        DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()).toString();
  }

  TextEditingController dateFromController = TextEditingController(
      text: DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.now())
          .toString());

  TextEditingController dateToController = TextEditingController(
      text: DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.now())
          .toString());

  int get intNumber => _repositoryStatement.intNumber;

  int get rFinStatTo => _repositoryStatement.rFinStatTo;

  int get rFinStatFrom => _repositoryStatement.rFinStatFrom;

  filterSearch(BuildContext context, int number) async {
    // if (dateFromController.text.isNotEmpty &&
    //     dateToController.text.isNotEmpty) {
    var param = {
      'from': dateFromController.text.isEmpty
          ? DateFormat(SpecialKeys.dateFormatYDM)
              .format(DateTime.now())
              .toString()
          : dateFromController.text,
      'to': dateToController.text.isEmpty
          ? DateFormat(SpecialKeys.dateFormatYDM)
              .format(DateTime.now())
              .toString()
          : dateToController.text,
      'page': number.toString()
    };
    print('paramparam');
    print(param);
    context.goNamed(Routes.financialStatementView, queryParameters: param);

    await getFinancialStatement(number);
    // }
  }

  Future getFinancialStatement(int page) async {
    setBusy(true);
    notifyListeners();
    List<String> dates = [
      if (dateFromController.text == '')
        ""
      else
        DateFormat(SpecialKeys.dateFormatYDM)
            .format(DateTime.parse(dateFromController.text)),
      if (dateToController.text == '')
        ""
      else
        DateFormat(SpecialKeys.dateFormatYDM)
            .format(DateTime.parse(dateToController.text))
    ];
    String dayDifference = "0:00:00.000000";
    if (dateFromController.text == '' || dateToController.text == '') {
      dayDifference = "0:00:00.000000";
    } else {
      dayDifference = DateTime.parse(dateFromController.text)
          .difference(DateTime.parse(dateToController.text))
          .toString();
    }
    notifyListeners();
    await _repositoryStatement.getRetailerWholesalerFinancialStatements(
        page, dates, dayDifference);
    itemNUmber = rFinStatFrom;
    rFinStat = _repositoryStatement.rFinStatdata.value;

    grandTotalFinancialStatements =
        "${_repositoryStatement.financialStatementsData.data!.grandTotal}";

    rFinTotalData =
        _repositoryStatement.financialStatementsData.data!.total ?? 0;

    setBusy(false);
    notifyListeners();
  }

  int itemNUmber = 0;
  int get rFinStatTotalData => _repositoryStatement.rFinStatPage;

  List<Subgroups> rFinStat = [];
  openDateTime(context, TextEditingController controller) async {
    controller.text =
        (DateFormat(SpecialKeys.dateFormatYDM).format(await showDialog(
                  context: context,
                  builder: (activeContext) => const Calender(),
                )) ??
                DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()))
            .toString();
    notifyListeners();
  }

  gotoDetails(BuildContext context, String saleId, String? page, String? from,
      String? to) {
    Map<String, dynamic> body = {};
    if (page != null) {
      body.addAll({'statePage': page});
    }
    if (from != null) {
      body.addAll({'from': from});
    }
    if (to != null) {
      body.addAll({'to': to});
    }
    context.goNamed(Routes.financialStatementSaleListViewWeb,
        pathParameters: {'id': saleId}, queryParameters: body);
  }

  Future<void> callApi(int? page, String? from, String? to) async {
    dateFromController.text = from ?? '';
    dateToController.text = to ?? '';
    await getFinancialStatement(page!);
    itemNUmber = rFinStatFrom;
    notifyListeners();
  }

  List<SubgroupData> startPaymentList = [];
  String startPaymentValidation = "";
  // List<String> dayRange = ["1", "2"];
  // String get selectedDayRange => _repositoryStatement.selectedDayRange;
  //
  // Future<void> changeRanges(String v, String? page, String? from, String? to,
  //     BuildContext context) async {
  //   _repositoryStatement.changeRanges(v);
  //   changePage(1, from, to, context);
  // }

  // bool isWeek = true;
  bool get isDay => _repositoryStatement.isDay;
  void changeWeekOrDay(
      bool v, String? page, String? from, String? to, BuildContext context) {
    _repositoryStatement.changeWeekOrDay(v);

    changePage(1, from, to, context);
    notifyListeners();
  }

  void addForStartPayment(SubgroupData data, {bool emptyToClose = false}) {
    _repositoryStatement.addForStartPayment(data);
    startPaymentList = _repositoryStatement.startPaymentList.value;
    if (startPaymentList.isEmpty) {
      if (emptyToClose) {
        _nav.pop();
      }
    }
    itemNUmber = rFinStatFrom;
    notifyListeners();
  }

  goForStartPayment(String? from, String? to, String? page) {
    if (startPaymentList.isEmpty) {
      startPaymentValidation = "Need to select minimum one sales documents!";
    } else {
      startPaymentValidation = "";
      _nav.animatedDialog(StartPaymentDialog(from, to, page, enrollment));
    }
    itemNUmber = rFinStatFrom;
    notifyListeners();
  }

  Future<void> createPayment(
      BuildContext context, String? from, String? to, String? page) async {
    setBusyForObject(startPaymentList, true);
    String ids = _repositoryStatement.startPaymentList.value
        .map((e) => e.saleUniqueId)
        .toList()
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(" ", "");
    ResponseMessages? responseBody =
        await _repositoryStatement.createPaymentOnWebsite(ids);

    if (responseBody!.success!) {
      Utils.toast(responseBody.message!, isSuccess: true, sec: 7);
      _repositoryStatement.clear();
      html.window.location.reload();
      setBusyForObject(startPaymentList, false);
    }
    setBusyForObject(startPaymentList, false);
  }

  Future<void> goBack() async {
    _nav.pop();
  }
}
