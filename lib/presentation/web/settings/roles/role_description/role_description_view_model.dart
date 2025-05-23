import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../../app/app_secrets.dart';
import '../../../../../const/special_key.dart';
import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RoleDescriptionViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getDescription(String? des) {
    String b = des!.replaceAll("()", "/").replaceAll(")(", "+");
    String bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
    Utils.fPrint(bb);
    list = bb.split(',');
    notifyListeners();
  }

  String mod = String.fromCharCode(9899);
  List<String> list = [];

  void goBack(BuildContext context) {
    context.goNamed(Routes.rolesView);
  }
}
