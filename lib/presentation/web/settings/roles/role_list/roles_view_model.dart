import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../../../app/app_secrets.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/retailer_role_model.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../role_description/details.dart';

class RolesViewModel extends BaseViewModel {
  RolesViewModel() {
    getRetailerRolesList();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final NavigationService _nav = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  RetailerRolesModel? retailerRoles;
  List<RetailerRolesData> retailerRolesList = [];
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getRetailerRolesList() async {
    setBusy(true);
    notifyListeners();
    await _components.getRetailerRolesList();
    retailerRoles = _components.retailerRolesList.value;
    retailerRolesList = retailerRoles!.data!;
    setBusy(false);
    notifyListeners();
  }

  void action(BuildContext context, String des, String title) {
    String replacedText = des.replaceAll("<br>", ",");
    List<String> list = replacedText.split(",");
    _nav.animatedDialog(RoleDetails(list, title));
    // String replacedText = s.replaceAll("<br>", ",");
    // String b = Utils.encrypter.encrypt(replacedText, iv: SpecialKeys.iv).base64;
    // String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");
    // context.goNamed(Routes.roleDescription, pathParameters: {'d': bReplaced});
  }
}
