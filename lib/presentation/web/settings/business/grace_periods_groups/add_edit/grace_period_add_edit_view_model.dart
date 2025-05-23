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

class GracePeriodAddEditViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  TextEditingController typeIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController daysController = TextEditingController();

  String typeIdError = "";
  String nameError = "";
  String daysError = "";
  String uid = "";
  bool isEdit = false;
  update() async {
    if (typeIdController.text.isEmpty) {
      typeIdError = "Need to file the Id type";
    } else {
      typeIdError = "";
    }
    if (nameController.text.isEmpty) {
      nameError = "Need to file the type name";
    } else {
      nameError = "";
    }
    if (daysController.text.isEmpty) {
      daysError = "Need to file the days";
    } else {
      daysError = "";
    }
    if (typeIdController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        daysController.text.isNotEmpty) {
      setBusyForObject(typeIdController, true);
      notifyListeners();
      var body = {
        "id_type": typeIdController.text,
        "grace_period_name": nameController.text,
        "grace_period_days": daysController.text
      };
      if (isEdit) {
        body.addAll({
          "unique_id": uid,
        });
      }
      await _components.addGracePeriod(body, isEdit);
      setBusyForObject(typeIdController, false);
      notifyListeners();
    }

    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.gracePeriodsGroupsView);
  }

  void prefill(String? data) {
    if (data != null) {
      isEdit = true;

      String b = data.replaceAll("()", "/").replaceAll(")(", "+");
      var bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
      uid = jsonDecode(bb)['uid'];
      typeIdController.text = jsonDecode(bb)['id'];
      nameController.text = jsonDecode(bb)['name'];
      daysController.text = jsonDecode(bb)['days'].toString();
      notifyListeners();
    }
  }
}
