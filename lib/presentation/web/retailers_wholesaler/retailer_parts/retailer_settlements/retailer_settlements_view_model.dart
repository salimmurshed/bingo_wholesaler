import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/settlement_web_model/settlement_web_model.dart';
import '../../../../../repository/repository_customer.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailerSettlementsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  List<SettlementWebModelData> settlementList = [];
  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getData(String? t) async {
    setBusy(true);
    notifyListeners();
    settlementList =
        await _customerRepository.getCustomerSettlementsWeb(t!, false);
    // customerCreditline = cl!.data!.data!;
    // totalPage = cl!.data!.lastPage ?? 0;
    // pageTo = cl!.data!.to ?? 0;
    // pageFrom = cl!.data!.from ?? 0;
    // dataTotal = cl!.data!.total ?? 0;
    setBusy(false);
    notifyListeners();
  }

  void gotoDetails(BuildContext context, String? lotId, int? type) {
    context.goNamed(Routes.paymentLotDetailsViewfromretailer,
        pathParameters: {'id': lotId!, 'type': type.toString()});
  }
}
