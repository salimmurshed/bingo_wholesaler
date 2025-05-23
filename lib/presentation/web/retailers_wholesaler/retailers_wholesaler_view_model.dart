import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/customer_list/customer_list.dart';
import '../../../services/auth_service/auth_service.dart';

class RetailerWholeSalerViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  String get tabNumber => _webBasicService.tabNumber.value;
  CustomerList? retailer;
  List<CustomerData> customers = [];

  UserTypeForWeb get enrollment => _authService.enrollment.value;
  ScrollController scrollController = ScrollController();

  Future<void> getRetailersWholesalers(String page) async {
    setBusy(true);
    notifyListeners();
    pageNumber = int.parse(page);
    if (enrollment == UserTypeForWeb.wholesaler) {
      retailer = (await _customerRepository
          .getCustomerOnlineWebWholesaler(pageNumber.toString()));
      customers = retailer!.data!.data!;
      totalPage = retailer!.data!.lastPage ?? 0;
      pageTo = retailer!.data!.to ?? 0;
      pageFrom = retailer!.data!.from ?? 0;
      dataTotal = retailer!.data!.total ?? 0;
    } else {
      customers = await _customerRepository.getCustomerOnlineWebRetailer();
    }
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    context.goNamed(Routes.retailer, pathParameters: {'page': page.toString()});
    getRetailersWholesalers(page.toString());
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void action(BuildContext context, String ttx, String uid) {
    if (enrollment == UserTypeForWeb.wholesaler) {
      context.goNamed(Routes.retailerCreditLineView,
          queryParameters: {"ttx": ttx, "uid": uid});
    } else if (enrollment == UserTypeForWeb.retailer) {
      context.goNamed(Routes.wholesalerDetailsView,
          queryParameters: {"ttx": ttx, "uid": uid});
    } else {}
  }
}
