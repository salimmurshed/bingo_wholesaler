import 'dart:convert';
import 'package:universal_html/html.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../app/app_config.dart';
import '../../../../../../app/app_secrets.dart';
import '../../../../../../const/special_key.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../../repository/repository_components.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class AddEditPricingGroupViewModel extends BaseViewModel {
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
  String? uid;
  bool isEdit = false;
  update() async {
    Utils.fPrint('hasoijfhasjdhajshd');
    if (typeIdController.text.isEmpty) {
      typeIdError = "Need to file the type Id";
    } else {
      typeIdError = "";
    }
    if (typeNameController.text.isEmpty) {
      typeNameError = "Need to file the type name";
    } else {
      typeNameError = "";
    }
    notifyListeners();
    if (typeIdController.text.isNotEmpty &&
        typeNameController.text.isNotEmpty) {
      var body = {
        "pricing_group_id": typeIdController.text,
        "pricing_group_name": typeNameController.text,
      };
      // if (isEdit) {
      //   body.addAll({
      //     "unique_id": uid!,
      //   });
      // }
      setBusyForObject(typeIdController, true);
      notifyListeners();
      ResponseMessageModel response =
          await _components.addPricingGroup(body, isEdit, uid);
      setBusyForObject(typeIdController, false);
      Utils.toast(response.message!, isSuccess: response.success!);
      if (response.success!) {
        window.history.replaceState('', '',
            '${ConstantEnvironment.redirectBaseURL}/${Routes.pricingGroupView}');

        window.history.back();
      }
      notifyListeners();
    }
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.pricingGroupView);
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
