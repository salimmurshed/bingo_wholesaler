import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data_models/enums/user_type_for_web.dart';
import '/app/web_route.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../main.dart';
import '../navigation/navigation_service.dart';
import '../storage/db.dart';

@lazySingleton
class WebBasicService with ListenableServiceMixin {
  final NavigationService _navigationService = locator<NavigationService>();

  WebBasicService() {
    listenToReactiveValues([tabNumber]);
  }

  ReactiveValue<String> tabNumber = ReactiveValue(Routes.dashboardScreen);

  void changeTab(BuildContext context, String v) {
    if (v != Routes.elses) {
      // prefs.setString(DataBase.tabNumber, v);
      tabNumber.value = v;
      context.goNamed(v);
      // _navigationService.pushNamed(v);
      debugPrint(v);

      notifyListeners();
    }
  }
}
