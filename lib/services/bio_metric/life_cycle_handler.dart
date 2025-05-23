import '/main.dart';
import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../app/locator.dart';
import '../../repository/repository_notification.dart';
import '../storage/db.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // debugPrint(state);
    bool status = prefs.getBool(DataBase.accountStatus) ?? false;
    switch (state) {
      case AppLifecycleState.resumed:
        if (!status) {
          locator<AuthService>().checkLockForResume();
        }
        locator<RepositoryNotification>().getNotificationCounter();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!status) {
          await prefs.setInt(
              DataBase.lastActiveTime, DateTime.now().millisecondsSinceEpoch);
        }
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
