import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import '../../../../app/locator.dart';
import '../../../../data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';

class CreditlineViewModel extends BaseViewModel {
  CreditlineViewModel() {
    getCreditlines();
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  UserTypeForWeb get enrollment => _authService.enrollment.value;

  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  List<ApproveCreditlineRequestData> creditlineRequest = [];

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  double getPercentage(int i) {
    double amount = double.parse(
        (creditlineRequest[i].approvedAmount ?? '0.0').replaceAll(",", ""));
    double balance = double.parse(
        (creditlineRequest[i].currentBalance ?? '0.0').replaceAll(",", ""));
    double percentage = balance / amount;

    return percentage;
  }

  getCreditlines() async {
    setBusy(true);
    notifyListeners();
    RetailerApproveCreditlineRequest? data =
        await _repositoryRetailer.getRetailerCreditlineList();
    creditlineRequest = data!.data!;
    setBusy(false);
    notifyListeners();
  }

  action(int v, BuildContext context, String uid) {
    if (enrollment == UserTypeForWeb.retailer) {
      if (v == 0) {
        context.goNamed(Routes.retailersCreditlineView,
            queryParameters: {"uid": uid, "type": "view"});
      } else if (v == 1) {
        context.goNamed(Routes.retailersCreditlineView,
            queryParameters: {"uid": uid, "type": "edit"});
      }
    } else {
      context.goNamed(Routes.retailersCreditlineView,
          queryParameters: {"uid": uid, "type": "view"});
    }
  }

  void changePage(BuildContext context, int v) {}
}
