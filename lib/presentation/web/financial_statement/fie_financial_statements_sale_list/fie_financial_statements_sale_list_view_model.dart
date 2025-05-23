import 'package:bingo/app/web_route.dart';
import 'package:encryptor/encryptor.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_secrets.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/retailer_sale_financial_statements /retailer_sale_financial_statements.dart';
import '../../../../data_models/models/retailer_sale_financial_statements /v2.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '../../../../repository/repository_website_statements.dart';
import '/app/locator.dart';

import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../const/special_key.dart';
import '../../../../data/data_source/cards_properties_list.dart';
import '../../../../data/data_source/date_filters.dart';
import '../../../../data_models/construction_model/dashboard_card_properties_model/dashboard_card_properties_model.dart';
import '../../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import '../../../widgets/web_widgets/text_fields/calender.dart';

class FieFinancialStatementSaleListViewModel extends ReactiveViewModel {
  Future<void> getParams(String? id, String? enroll) async {
    String saleId = Encryptor.decrypt(AppSecrets.qrKey, id!);
    getSalesFinancialStatement(saleId, enroll);
    print('saleIdsaleId');
    print(saleId);
  }

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

  String get tabNumber => _webBasicService.tabNumber.value;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  int finStatPageNumber = 1;

  List<RetailerSaleFinancialStatementsV2Data> get StatdataAllSale => [];
  // _repositoryStatement.retailerSaleFinancialStatementsList;

  int TotalData = 0;
  String itemID = '';

  void setSaleId(String saleId) {
    itemID = saleId;
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context, String? enroll) {
    context.goNamed(Routes.fieFinancialStatementView,
        queryParameters: {'enroll': enroll!, 'page': "1"});
  }

  void changePage(number, String? enroll) {
    finStatPageNumber = number;

    getSalesFinancialStatement(itemID, enroll);
    notifyListeners();
  }

  clear() {
    dateOneController.text =
        DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()).toString();
    dateTwoController.text =
        DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()).toString();
  }

  TextEditingController dateOneController = TextEditingController(
      text: DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.now())
          .toString());
  TextEditingController dateTwoController = TextEditingController(
      text: DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.now())
          .toString());

  int get intNumber => _repositoryStatement.intNumber;

  int get StatTo => _repositoryStatement.rSaleFinStatTo;

  int get StatFrom => _repositoryStatement.rSaleFinStatFrom;

  int get StatTotalData => _repositoryStatement.rSaleFinStatTotal;
  int StatParPage = 0;
  int totalPage = 0;

  void changeFieClientsStatementScreen(
      String id, BuildContext context, String enroll) {
    context.goNamed(Routes.fieFinancialStatementView,
        queryParameters: {'enroll': enroll});
  }

  Future getSalesFinancialStatement(String saleID, String? enroll) async {
    List<String> dates = [
      DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.parse(dateOneController.text)),
      DateFormat(SpecialKeys.dateFormatYDM)
          .format(DateTime.parse(dateTwoController.text))
    ];
    Duration dayDifference = DateTime.parse(dateOneController.text)
        .difference(DateTime.parse(dateTwoController.text));
    setBusyForObject(StatdataAllSale, true);
    notifyListeners();
    await _repositoryStatement.getFieFinancialDocuments(
        finStatPageNumber, saleID, dates, dayDifference, enroll!);

    StatParPage = _repositoryStatement.rSaleFinStatPage < 6
        ? _repositoryStatement.rSaleFinStatPage
        : 5;
    totalPage = _repositoryStatement.rSaleFinStatPage;
    setBusyForObject(StatdataAllSale, false);
    notifyListeners();
  }

  openDateTime(context, TextEditingController controller) async {
    controller.text =
        (DateFormat(SpecialKeys.dateFormatYDM).format(await showDialog(
                  context: context,
                  builder: (context) => const Calender(),
                )) ??
                DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()))
            .toString();
    notifyListeners();
  }
}
