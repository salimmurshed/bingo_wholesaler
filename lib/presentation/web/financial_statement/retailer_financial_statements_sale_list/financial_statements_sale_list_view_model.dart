import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/app_localization.dart';
import 'package:bingo/presentation/widgets/alert/confirmation_dialog.dart';
import 'package:bingo/repository/repository_website_statements.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:universal_html/html.dart' as html;
import 'package:go_router/go_router.dart';

import '../../../../app/app_secrets.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/component_models/response_model.dart';
import '../../../../data_models/models/retailer_sale_financial_statements /retailer_sale_financial_statements.dart';
import '../../../../data_models/models/statement_list_doc_model/statement_list_doc_model.dart';
import '../../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../../data_models/models/user_model/user_model.dart';
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

class RetailerFinancialStatementSaleListViewModel extends ReactiveViewModel {
  final NavigationService _nav = locator<NavigationService>();
  Future<void> getParams(String? id) async {
    String saleId = id!;
    await getSalesFinancialStatement(saleId, 1);
  }

  var myGroup = AutoSizeGroup();
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

  List<FinancialStatementsDetails> allData = [];
  FinancialStatementsDetailsGroupMetadata?
      financialStatementsDetailsGroupMetadata;
  int TotalData = 0;
  // String itemID = '';

  // void setSaleId(String saleId) {
  //   itemID = saleId;
  // }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> changePageForSale(itemID, number) async {
    finStatPageNumber = number;

    await getSalesFinancialStatement(itemID, finStatPageNumber);
    notifyListeners();
  }

  void goBack(
      BuildContext context, String? statePage, String? from, String? to) {
    context.goNamed(Routes.financialStatementView,
        queryParameters: {'from': from, 'to': to, 'page': statePage});
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

  Future getSalesFinancialStatement(
      String saleID, int finStatPageNumber) async {
    setBusy(true);
    await _repositoryStatement.getRetailerWholesalerFinancialDocuments(
        finStatPageNumber, saleID);
    allData = _repositoryStatement.retailerSaleFinancialStatementsList;
    financialStatementsDetailsGroupMetadata =
        _repositoryStatement.financialStatementsDetailsGroupMetadata;
    StatParPage = 10;
    totalPage = _repositoryStatement.rSaleFinStatPage;
    setBusy(false);
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

  Future<void> createPayment(BuildContext context, String? id) async {
    bool confirm = await _nav.animatedDialog(ConfirmationDialog(
      title: "Do you really want do start payment?",
      submitButtonText: AppLocalizations.of(context)!.startPayment,
    ));

    if (confirm) {
      setBusy(true);
      ResponseMessages? responseBody =
          await _repositoryStatement.createPaymentOnWebsite(id!);
      if (!responseBody!.success!) {
        if (context.mounted) {
          _repositoryStatement.clear();
          html.window.location.reload();
          Utils.toast(responseBody.message!);
        }
      }
      setBusy(false);
    }
  }
}
