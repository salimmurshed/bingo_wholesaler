import 'package:bingo/app/locator.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailersOrderListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }
}
