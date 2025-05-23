import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/customer_creditline_list/customer_creditline_list.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailerCreditLineViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  CustomerCreditlineList? cl;
  ScrollController scrollController = ScrollController();
  List<CustomerCreditlineData> customerCreditline = [];
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getData(String? uid) async {
    setBusy(true);
    notifyListeners();
    cl = await _customerRepository.getCustomerCreditlineOnlineWeb(uid!);
    customerCreditline = cl!.data!.data!;
    totalPage = cl!.data!.lastPage ?? 0;
    pageTo = cl!.data!.to ?? 0;
    pageFrom = cl!.data!.from ?? 0;
    dataTotal = cl!.data!.total ?? 0;
    setBusy(false);
    notifyListeners();
  }

  String availableAmount(String a, String b) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    );
    double ad = double.parse(a.replaceAll(",", ""));
    double bd = double.parse(b.replaceAll(",", ""));
    ad - bd;
    return formatter.format(ad - bd);
  }

  double getPercentage(int i) {
    double amount = double.parse(
        (customerCreditline[i].approvedCreditLineAmount ?? '0.0')
            .replaceAll(",", ""));
    double balance = double.parse(
        (customerCreditline[i].consumedAmount ?? '0.0').replaceAll(",", ""));
    double percentage = balance / amount;

    return percentage;
  }

  void action(BuildContext context, String id, String? uid, String? ttx) {
    Utils.fPrint('uiduiduid');
    Utils.fPrint(id);
    context.goNamed(Routes.retailerCreditlineDetailsView,
        queryParameters: {"id": id, "ttx": ttx!, "uid": uid!});
  }
}
