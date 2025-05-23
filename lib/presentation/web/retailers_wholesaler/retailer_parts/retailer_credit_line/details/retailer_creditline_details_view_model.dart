import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../data_models/models/retailer_wholesaler_creditline_summery_details_model.dart';
import '../../../../../../repository/repository_customer.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class RetailerCreditlineDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customer = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  RetailerWholesalerCreditlineSummaryDetailsModel? creditlineSummeryDetails;
  List<RetailerStores> retailerStores = [];
  List<ApprovedCreditlines> approvedCreditlines = [];
  List<DetailsData> detailsData = [];

  ScrollController scrollController = ScrollController();
  int internalTabNumber = 0;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeSelectedTerms(int i) {
    internalTabNumber = i;
    notifyListeners();
  }

  Future<void> getData(String? id) async {
    setBusy(true);
    notifyListeners();
    RetailerWholesalerCreditlineSummaryDetailsModel creditlineSummeryDetails =
        await _customer.getRetailersCreditlineViewDetails(id);
    if (creditlineSummeryDetails.retailerWholesalerCreditlineSummaryModel !=
        null) {
      retailerStores = creditlineSummeryDetails
          .retailerWholesalerCreditlineSummaryModel!.data!.retailerStores!;
      approvedCreditlines = creditlineSummeryDetails
          .retailerWholesalerCreditlineSummaryModel!
          .data!
          .creditlineHeader!
          .approvedCreditlines!;
    }
    if (creditlineSummeryDetails.retailerWholesalerCreditlineDetailsModel !=
        null) {
      detailsData = creditlineSummeryDetails
          .retailerWholesalerCreditlineDetailsModel!.data!;
    }
    setBusy(false);
    notifyListeners();
  }
}
