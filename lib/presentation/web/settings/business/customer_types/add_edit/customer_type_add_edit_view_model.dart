import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/app_secrets.dart';
import '../../../../../../const/special_key.dart';
import '../../../../../../const/utils.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../repository/repository_components.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class AddEditCustomerTypeViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController typeNameController = TextEditingController();
  String typeIdError = "";
  String typeNameError = "";
  String uid = "";
  bool isEdit = false;
  update() async {
    if (typeIdController.text.isEmpty) {
      typeIdError = "Need to fill the type Id";
    } else {
      typeIdError = "";
    }
    if (typeNameController.text.isEmpty) {
      typeNameError = "Need to fill the type name";
    } else {
      typeNameError = "";
    }
    notifyListeners();
    if (typeIdError.isEmpty && typeNameError.isEmpty) {
      var body = {
        "type_id": typeIdController.text,
        "customer_type": typeNameController.text,
      };
      if (isEdit) {
        body.addAll({
          "unique_id": uid,
        });
      }
      setBusyForObject(typeIdController, true);
      notifyListeners();
      await _components.addCustomerType(body, isEdit);
      setBusyForObject(typeIdController, false);
      notifyListeners();
    }
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.customerTypesView);
  }

  void prefill(String? data) {
    if (data != null) {
      isEdit = true;

      String b = data.replaceAll("()", "/").replaceAll(")(", "+");
      var bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
      uid = jsonDecode(bb)['uid'];
      typeIdController.text = jsonDecode(bb)['id'];
      typeNameController.text = jsonDecode(bb)['name'];
      notifyListeners();
    }
  }
}
