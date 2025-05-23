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
import '../../../../../../data_models/models/component_models/grace_period_group.dart';
import '../../../../../../repository/repository_components.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class GracePeriodsGroupsViewModel extends BaseViewModel {
  GracePeriodsGroupsViewModel() {
    getGracePeriodGroup();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  GracePeriodGroupModel? gracePeriodGroup;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void action(BuildContext context, int i) {
    var body = {
      "uid": gracePeriodGroup!.data![i].uniqueId,
      "id": gracePeriodGroup!.data![i].gracePeriodGroup,
      "name": gracePeriodGroup!.data![i].gracePeriodName,
      "days": gracePeriodGroup!.data![i].gracePeriodDays
    };
    String b =
        Utils.encrypter.encrypt(jsonEncode(body), iv: SpecialKeys.iv).base64;
    String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");
    context.goNamed(Routes.gracePeriodEditView,
        pathParameters: {"data": bReplaced});
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.gracePeriodAddView);
  }

  getGracePeriodGroup() async {
    setBusy(true);
    notifyListeners();
    await _components.getGracePeriodGroup();
    gracePeriodGroup = _components.gracePeriodGroup;
    setBusy(false);
    notifyListeners();
  }
}
