import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/app_secrets.dart';
import '../../../../const/special_key.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/retailer_credit_line_req_model/retailer_credit_line_req_model.dart';
import '../../../../data_models/models/wholesaler_credit_line_model/wholesaler_credit_line_model.dart';

class CreditLineRequestWebViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();

  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  UserTypeForWeb get enrollment => _authService.enrollment.value;
  WholesalerCreditLineModel? creditLineModel;
  List<WholesalerCreditLineData> creditLineRequests = [];
  RetailerCreditLineRequestModel? creditLineModelRetailer;
  List<RetailerCreditLineRequestData> creditLineRequestsRetailer = [];

  int totalPage = 1;
  int pageTo = 1;
  int pageFrom = 1;
  int pageNumber = 1;
  int dataTotal = 1;

  getCreditLinesListWeb(String? page) async {
    setBusy(true);
    notifyListeners();
    if (enrollment == UserTypeForWeb.retailer) {
      creditLineModelRetailer =
          await _retailer.getCreditLinesListWeb(int.parse(page ?? "0"));
      creditLineRequestsRetailer = creditLineModelRetailer!.data!.data!;
    } else if (enrollment == UserTypeForWeb.wholesaler) {
      creditLineModel =
          await _wholesaler.getCreditLinesListWeb(int.parse(page ?? "0"));
      creditLineRequests = creditLineModel!.data!.data!;
    }

    totalPage = enrollment == UserTypeForWeb.retailer
        ? creditLineModelRetailer!.data!.lastPage!
        : creditLineModel!.data!.lastPage!;
    pageTo = enrollment == UserTypeForWeb.retailer
        ? creditLineModelRetailer!.data!.to!
        : creditLineModel!.data!.to!;
    pageFrom = enrollment == UserTypeForWeb.retailer
        ? creditLineModelRetailer!.data!.from!
        : creditLineModel!.data!.from!;
    pageNumber = int.parse(page ?? "0");
    dataTotal = enrollment == UserTypeForWeb.retailer
        ? creditLineModelRetailer!.data!.total!
        : creditLineModel!.data!.total!;
    setBusy(false);
    notifyListeners();
  }

  changePage(
    BuildContext context,
    int page,
  ) {
    pageNumber = page;
    context.goNamed(Routes.creditLineRequestWebView,
        pathParameters: {'page': page.toString()});
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  // changeScreen(BuildContext context, String screen) {
  //   context.goNamed(screen);
  // }
  changeScreen(BuildContext context, String screen) {
    if (screen == Routes.wholesalerRequest ||
        screen == Routes.fieRequest ||
        screen == Routes.retailerRequest) {
      context.goNamed(screen);
    } else {
      context.goNamed(screen, pathParameters: {"page": "1"});
    }
  }

  void action(BuildContext context, int v, String? uid) {
    if (enrollment == UserTypeForWeb.wholesaler) {
      WholesalerCreditLineData creditLineRequest =
          creditLineRequests.firstWhere((element) => element.uniqueId == uid);
      WholesalerCreditLineData data = WholesalerCreditLineData(
        uniqueId: uid,
        customerSinceDate: creditLineRequest.customerSinceDate,
        monthlySales: creditLineRequest.monthlySales,
        averageSalesTicket: creditLineRequest.averageSalesTicket,
        visitFrequency: creditLineRequest.visitFrequency,
        rcCrlineAmt: creditLineRequest.rcCrlineAmt,
        currency: creditLineRequest.currency,
        monthlyPurchase: creditLineRequest.monthlyPurchase,
        averagePurchaseTickets: creditLineRequest.averagePurchaseTickets,
        requestedAmount: creditLineRequest.requestedAmount,
      );
      // String encodedJson = jsonEncode(data);
      var encrypted =
          Utils.encrypter.encrypt(jsonEncode(data), iv: SpecialKeys.iv).base64;
      String bReplaced = encrypted.replaceAll("/", "()").replaceAll("+", ")(");
      context.goNamed(Routes.creditLineRequestDetailsView,
          queryParameters: {"q": uid, "data": bReplaced});
    } else {
      context.goNamed(Routes.creditLineRequestDetailsView,
          queryParameters: {"q": uid});
    }
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.addNewCreditlineView);
  }
}
