import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../../../repository/repository_customer.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailersSalesListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  List<AllSalesData> allSales = [];
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getData(String? ttx, String? uid, String? page) async {
    setBusy(true);
    notifyListeners();
    AllSalesModel salesModel =
        await _customerRepository.getCustomerSalesWeb(ttx!, page!);
    allSales = salesModel.data!.data!;
    totalPage = salesModel.data!.lastPage ?? 0;
    pageTo = salesModel.data!.to ?? 0;
    pageFrom = salesModel.data!.from ?? 0;
    dataTotal = salesModel.data!.total ?? 0;
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, String? ttx, String? uid, int v) {
    totalPage = v;
    context.goNamed(Routes.retailerSales, queryParameters: {
      "ttx": ttx!,
      "uid": uid!,
      "page": totalPage.toString()
    });
    getData(ttx, uid, totalPage.toString());
  }
}
