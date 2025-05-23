import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/presentation/widgets/alert/confirmation_dialog.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:universal_html/html.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/enums/zone_route.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../data_models/models/routes_model/routes_model.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../widgets/alert/date_picker.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../widgets/web_widgets/text_fields/calender.dart';

class DynamicRoutesListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  TextEditingController fromDateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController toDateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  ScrollController scrollController = ScrollController();
  String screenType = "";
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;
  int optionOne = 0;
  int optionTwo = 0;
  changeOptionOne(int i) {
    optionOne = i;
    notifyListeners();
  }

  Future<void> selectDateFormedCompanyProfile(
      TextEditingController controller) async {
    String date =
        ((await _navigationService.animatedDialog(const Calender())) ??
                DateTime.now())
            .toString();
    // isPreviousData: true,
    controller.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    notifyListeners();
  }

  changeOptionTwo(int i) {
    optionTwo = i;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  RoutesModel? routes;
  Future<void> prefill(
      String value, String? page, String? from, String? to) async {
    screenType = value;
    notifyListeners();
    if (value != (ZoneRoutes.option.name)) {
      setBusy(true);
      notifyListeners();
      if (value == (ZoneRoutes.dynamic.name)) {
        fromDateController.text = from!;
        toDateController.text = to!;
        List dateDynamicRoutes = [
          fromDateController.text,
          toDateController.text
        ];
        notifyListeners();
        routes = await _wholesaler.getRouteZone(int.parse(page!), value,
            dateDynamicRoutes: dateDynamicRoutes);

        notifyListeners();
      } else {
        routes = await _wholesaler
            .getRouteZone(int.parse(page!), value, dateDynamicRoutes: []);
      }

      pageNumber = int.parse(page);
      totalPage = routes!.data!.lastPage!;
      pageTo = routes!.data!.to!;
      pageFrom = routes!.data!.from!;
      dataTotal = routes!.data!.total!;
      setBusy(false);
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future<void> callDynamic(
    BuildContext context,
    String value,
  ) async {
    context.goNamed(Routes.zoneRouteDynamic, queryParameters: {
      "page": "1",
      "from": fromDateController.text,
      "to": toDateController.text
    });

    await prefill(value, "1", fromDateController.text, toDateController.text);
    // html.window.location.reload();
  }

  Future<void> screenChange(BuildContext context, ZoneRoutes r) async {
    if (r == ZoneRoutes.option) {
      context.goNamed(r.name);
      screenType = r.name;
      notifyListeners();
    } else {
      setBusy(true);
      notifyListeners();
      if (r == ZoneRoutes.dynamic) {
        context.goNamed(r.name, queryParameters: {
          "page": "1",
          "from": (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString(),
          "to": (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString()
        });
      } else {
        context.goNamed(r.name, queryParameters: {"page": "1"});
      }
      routes = await _wholesaler.getRouteZone(int.parse("1"), r.name);
      pageNumber = int.parse('1');
      totalPage = routes!.data!.lastPage!;
      pageTo = routes!.data!.to!;
      pageFrom = routes!.data!.from!;
      dataTotal = routes!.data!.total!;
      screenType = r.name;
      setBusy(false);
      notifyListeners();
    }
  }

  void changePage(BuildContext context, int page, String from, String to) {
    pageNumber = page;
    if (screenType == Routes.zoneRouteDynamic) {
      context.goNamed(screenType, queryParameters: {
        'page': page.toString(),
        'from': from,
        'to': to,
      });
      prefill(screenType, page.toString(), from, to);
    } else {
      context.goNamed(screenType, queryParameters: {
        'page': page.toString(),
      });
      prefill(screenType, page.toString(), from, to);
    }
    // if (screenType == ZoneRoutes.dynamic.name) {
    //   prefill(screenType, page.toString(), from, to);
    // } else {
    //   prefill(screenType, page.toString(), from, to);
    // }
    notifyListeners();
  }

  String getSaleSteps(String value) {
    if (value.isEmpty || value == "-") {
      return "One Step Sale";
    } else if (value.toLowerCase() == "1s") {
      return "One Step Sale";
    } else {
      return "Two Step Sale";
    }
  }

  Future<void> changeStatus(String id, String status, int v, String? page,
      String? type, String? from, String? to) async {
    if (screenType == Routes.zoneRouteStatic) {
      if (v == 2) {
        bool confirm =
            await _navigationService.animatedDialog(ConfirmationDialog(
          title:
              "Do you really want to ${status == 'active' ? 'inactivate' : 'activate'}?",
          submitButtonText: status == 'active' ? 'inactivate' : 'activate',
        ));
        if (confirm) {
          String action = status == "active" ? "0" : "1";
          var body = {"unique_id": id, "action": action};
          ResponseMessageModel res =
              await _wholesaler.changeStaticRouteStatus(body, screenType);
          if (res.success!) {
            routes = await _wholesaler.getRouteZone(
                int.parse(page!), type ?? "static",
                dateDynamicRoutes: []);
            notifyListeners();
          }
          Utils.toast(res.message!, isSuccess: res.success!);
        }
      }
    } else if (screenType == Routes.zoneRouteDynamic) {
      List dateDynamicRoutes = [from, to];
      if (v == 2) {
        bool confirm =
            await _navigationService.animatedDialog(ConfirmationDialog(
          title:
              "Do you really want to ${status == 'active' ? 'inactivate' : 'activate'}?",
          submitButtonText: status == 'active' ? 'inactivate' : 'activate',
        ));
        if (confirm) {
          String action = status == "active" ? "0" : "1";
          var body = {"unique_id": id, "action": action};
          ResponseMessageModel res =
              await _wholesaler.changeStaticRouteStatus(body, screenType);

          if (res.success!) {
            routes = await _wholesaler.getRouteZone(
                int.parse(page!), type ?? "dynamic",
                dateDynamicRoutes: dateDynamicRoutes);
            notifyListeners();
          }
          Utils.toast(res.message!, isSuccess: res.success!);
        }
      }
    } else if (screenType == Routes.zoneRouteZone) {
      List dateDynamicRoutes = [from, to];
      if (v == 2) {
        bool confirm =
            await _navigationService.animatedDialog(ConfirmationDialog(
          title:
              "Do you really want to ${status == 'active' ? 'inactivate' : 'activate'}?",
          submitButtonText: status == 'active' ? 'inactivate' : 'activate',
        ));
        if (confirm) {
          String action = status == "active" ? "0" : "1";
          var body = {"unique_id": id, "action": action};
          ResponseMessageModel res =
              await _wholesaler.changeStaticRouteStatus(body, screenType);

          if (res.success!) {
            routes = await _wholesaler.getRouteZone(
                int.parse(page!), type ?? "dynamic",
                dateDynamicRoutes: dateDynamicRoutes);
            notifyListeners();
          }
          Utils.toast(res.message!, isSuccess: res.success!);
        }
      }
    }
  }
}
