import 'package:bingo/app/app_secrets.dart';
import 'package:encryptor/encryptor.dart';
import 'package:go_router/go_router.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '../../../../repository/repository_website_statements.dart';
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
// import '../../../../data_models/models/retailer_fiancial_statement_model/retailer_fiancial_statement_model.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import '../../../widgets/web_widgets/text_fields/calender.dart';

class FieFinancialStatementViewModel extends ReactiveViewModel {
  final NavigationService _nav = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authService, _webBasicService];
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

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  int finStatPageNumber = 1;

  List<Subgroups> get rFinStatdata => _repositoryStatement.rFinStatdata.value;

  int rFinStatParPage = 0;
  int rFinTotalData = 0;
  String grandTotalFinancialStatements = "0.00";
  String itemID = '';

  String get tabNumber => _webBasicService.tabNumber.value;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeFieClientsStatementScreen(BuildContext context, String v) {
    context.goNamed(Routes.fieFinancialStatementView,
        queryParameters: {'enroll': v, 'page': '1'});
    getFieFinancialDocuments(v);
  }

  void changePage(number, String? clientType) {
    finStatPageNumber = number;

    getFieFinancialDocuments(clientType);
    notifyListeners();
  }

  clear() async {
    dateOneController.text =
        DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString();
    dateTwoController.text =
        DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString();
  }

  TextEditingController dateOneController = TextEditingController(
      text:
          DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString());
  TextEditingController dateTwoController = TextEditingController(
      text:
          DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString());

  int get intNumber => _repositoryStatement.intNumber;

  int get rFinStatTo => _repositoryStatement.rFinStatTo;

  int get rFinStatFrom => _repositoryStatement.rFinStatFrom;

  int get rFinStatTotalData => _repositoryStatement.rFinStatPage;

  filterSearch(String? clientType, BuildContext context, int number,
      String? from, String? to) async {
    var body = {
      'enroll': clientType,
      'page': number.toString(),
      'from': dateOneController.text.isNotEmpty
          ? DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString()
          : dateOneController.text,
      'to': dateTwoController.text.isNotEmpty
          ? DateFormat(SpecialKeys.dateFormat).format(DateTime.now()).toString()
          : dateTwoController.text,
    };

    context.goNamed(Routes.fieFinancialStatementView, queryParameters: body);

    await getFieFinancialDocuments(clientType);
  }

  Future getFieFinancialDocuments(String? clientType) async {
    print('clientType');
    print(dateOneController.text);
    print(dateTwoController.text);
    List<String> dates = [
      if (dateOneController.text == '')
        ""
      else
        DateFormat(SpecialKeys.dateFormat)
            .format(DateTime.parse(dateOneController.text)),
      if (dateTwoController.text == '') "" else dateTwoController.text
    ];
    print("hahsdahgh");
    print(DateTime.parse(dateOneController.text));
    print(DateTime.parse(dateTwoController.text));
    print(dates);
    setBusy(true);
    notifyListeners();
    String dayDifference = "0:00:00.000000";
    if (dateTwoController.text == '' || dateOneController.text == '') {
      dayDifference = "0:00:00.000000";
    } else {
      dayDifference = DateTime.parse(dateOneController.text)
          .difference(DateTime.parse(dateTwoController.text))
          .toString();
    }
    setBusyForObject(rFinStatdata, true);
    notifyListeners();
    await _repositoryStatement.getFieFinancialStatements(
        finStatPageNumber, dates, dayDifference, clientType!.toLowerCase());

    grandTotalFinancialStatements = _repositoryStatement
        .financialStatementsData.data!.grandTotal!
        .toString();
    rFinTotalData = _repositoryStatement.financialStatementsData.data!.total!;
    rFinStatParPage = _repositoryStatement.financialStatementsData.data!
                .financialStatements!.subgroups!.length <
            6
        ? _repositoryStatement.financialStatementsData.data!
            .financialStatements!.subgroups!.length
        : 5;

    setBusy(false);
    notifyListeners();
  }

  openDateTime(context, TextEditingController controller) async {
    controller.text =
        (DateFormat(SpecialKeys.dateFormat).format(await showDialog(
      context: context,
      builder: (activeContext) => const Calender(),
    )))
            .toString();
    notifyListeners();
  }

  gotoDetails(BuildContext context, String clientType, String saleId) {
    String id = Encryptor.encrypt(AppSecrets.qrKey, saleId);
    context.goNamed(Routes.fieStatementSaleListViewWeb,
        pathParameters: {'enroll': clientType, 'id': id});
  }

  Future<void> callApi(
      String clientType, int? page, String? from, String? to) async {
    print("fromto");
    print(from);
    print(to);
    dateOneController.text = from ?? "";
    dateTwoController.text = to ?? "";
    await getFieFinancialDocuments(clientType);
  }
}
