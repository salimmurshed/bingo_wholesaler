import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/customer_store_list/customer_store_list.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailersLocationListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customer = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  List<TextEditingController> wholesalerStoreIdControllers = [];
  List<TextEditingController> saleZoneControllers = [];

  ScrollController scrollController = ScrollController();
  List<CustomerStoreData> locationData = [];
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getData(String? ttx, String? uid) async {
    setBusy(true);
    notifyListeners();
    await _customer.getCustomerStore(ttx!, false);
    locationData = _customer.customerStore;
    for (int i = 0; i < locationData.length; i++) {
      wholesalerStoreIdControllers
          .add(TextEditingController(text: locationData[i].wStoreId!));
      saleZoneControllers
          .add(TextEditingController(text: locationData[i].salesZoneName!));
    }
    setBusy(false);
    notifyListeners();
  }

  void gotoDetails(BuildContext context, String? ttx, String? uid, String sid) {
    context.goNamed(Routes.locationDetailsView,
        queryParameters: {"ttx": ttx, "uid": uid, "sid": sid});
  }
}
