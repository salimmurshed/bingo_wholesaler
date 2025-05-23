import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/app_secrets.dart';
import '../../../../../../const/special_key.dart';
import '../../../../../../const/utils.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../data_models/models/component_models/customer_type_model.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class CustomerTypesViewModel extends BaseViewModel {
  CustomerTypesViewModel() {
    getCustomerType();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  CustomerTypeModel? customerType;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.addCustomerTypeView);
  }

  getCustomerType() async {
    setBusy(true);
    notifyListeners();
    await _components.getCustomerType();
    customerType = _components.customerType;
    Utils.fPrint('customerTypecustomerType');
    Utils.fPrint(customerType!.toJson().toString());
    setBusy(false);
    notifyListeners();
  }

  void action(BuildContext context, int i) {
    var body = {
      "uid": customerType!.data![i].uniqueId,
      "id": customerType!.data![i].typeId,
      "name": customerType!.data![i].customerType
    };
    String b =
        Utils.encrypter.encrypt(jsonEncode(body), iv: SpecialKeys.iv).base64;
    String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");
    context.goNamed(Routes.editCustomerTypeView,
        pathParameters: {"data": bReplaced});
  }
}
