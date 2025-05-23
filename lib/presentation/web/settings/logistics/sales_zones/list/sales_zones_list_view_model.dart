import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/models/sales_zones/sales_zones.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/app_secrets.dart';
import '../../../../../../const/special_key.dart';
import '../../../../../../const/utils.dart';
import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../../repository/repository_wholesaler.dart';
import '../../../../../../services/auth_service/auth_service.dart';

class SalesZoneListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  List<SaleZonesData> salesZones = [];
  Future<void> getData(String? page) async {
    pageNumber = int.parse(page!);
    setBusy(true);
    notifyListeners();
    SaleZones salesZoneModel =
        await _wholesaler.getSalesZonesListWeb(pageNumber);
    salesZones = salesZoneModel.data!.data!;
    totalPage = salesZoneModel.data!.lastPage!;
    pageTo = salesZoneModel.data!.to!;
    pageFrom = salesZoneModel.data!.from!;
    dataTotal = salesZoneModel.data!.total!;
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    context.goNamed(Routes.salesZoneListView,
        pathParameters: {'page': page.toString()});
    // getPromoCode(page.toString());
    notifyListeners();
  }

  void action(BuildContext context, int i) {
    var body = {
      "uid": salesZones[i].uniqueId,
      "id": salesZones[i].salesId,
      "name": salesZones[i].salesZoneName
    };
    String b =
        Utils.encrypter.encrypt(jsonEncode(body), iv: SpecialKeys.iv).base64;
    String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");
    context
        .goNamed(Routes.salesZoneEditView, pathParameters: {"data": bReplaced});
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.salesZoneAddView);
  }
}
