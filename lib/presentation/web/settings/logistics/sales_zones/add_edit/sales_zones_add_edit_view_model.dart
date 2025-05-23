import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/repository/repository_sales.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/app_secrets.dart';
import '../../../../../../const/special_key.dart';
import '../../../../../../const/utils.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class SalesZoneAddEditViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositorySales _sales = locator<RepositorySales>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  TextEditingController salesZoneIdController = TextEditingController();
  TextEditingController salesZoneNameController = TextEditingController();
  String saleZoneIdError = "";
  String salesZoneNameError = "";
  String uid = "";
  bool isEdit = false;

  update() async {
    if (salesZoneIdController.text.isEmpty) {
      saleZoneIdError = "Need to fill sales zone Id";
    } else {
      saleZoneIdError = "";
    }
    if (salesZoneNameController.text.isEmpty) {
      salesZoneNameError = "Need to fill sales zone name";
    } else {
      salesZoneNameError = "";
    }
    if (saleZoneIdError.isEmpty || salesZoneNameError.isEmpty) {
      var body = {
        "type_id": salesZoneIdController.text,
        "customer_type": salesZoneNameController.text,
      };
      if (isEdit) {
        body.addAll({
          "unique_id": uid,
        });
      }
      setBusyForObject(salesZoneIdController, true);
      notifyListeners();
      await _sales.addSaleZone(body, isEdit);
      setBusyForObject(salesZoneIdController, false);
      notifyListeners();
    }
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void prefill(String? data) {
    if (data != null) {
      isEdit = true;

      String b = data.replaceAll("()", "/").replaceAll(")(", "+");
      var bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
      uid = jsonDecode(bb)['uid'];
      salesZoneIdController.text = jsonDecode(bb)['id'];
      salesZoneNameController.text = jsonDecode(bb)['name'];
      notifyListeners();
    }
  }
}
