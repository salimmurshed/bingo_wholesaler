import '/const/app_sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // GlobalKey<NavigatorState> get navigatorKey => navigatorKey;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  BuildContext get activeContext => navigatorKey.currentState!.context;

  Future<T?> pushFile<T extends Object>(Route<T> route) {
    return navigatorKey.currentState!.push(route);
  }

  Future<T?> push<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState!.push(route);
  }

  Future<dynamic> pushNamed<T extends Object>(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  Future displayDialog<T>(Widget dialog, {bool barrierDismissible = true}) {
    return showDialog(
      barrierLabel: '',
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }

  Future fullScreenDialog<T>(Widget dialog, {bool barrierDismissible = true}) {
    return showDialog(
      barrierColor: Colors.transparent,
      barrierLabel: '',
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }

  Future animatedDialog<T>(Widget dialog, {bool barrierDismissible = true}) {
    return showGeneralDialog(
      // barrierColor: Colors.black54,,
      context: navigatorKey.currentState!.overlay!.context,
      // barrierDismissible: barrierDismissible,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: dialog,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) => dialog,
    );
  }

  Future displayBottomSheet<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    bool enableDrag = false,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        enableDrag: enableDrag,
        shape: RoundedRectangleBorder(
            borderRadius: AppRadius.displayBottomSheetRadius),
        context: navigatorKey.currentState!.overlay!.context,
        isScrollControlled: true,
        builder: (context) => dialog);
  }

  Future<dynamic> pushReplacementNamed<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState?.popUntil(predicate);
  }

  Future<Object?> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName, bool Function(Route<dynamic>) predicate,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(navigatorKey.currentState!.overlay!.context)
        .showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

// void openDrawer() {
//   if (_endDrawerKey.currentState != null && _endDrawerOpened.value)
//     _endDrawerKey.currentState!.close();
//   _drawerKey.currentState?.open();
// }
}
