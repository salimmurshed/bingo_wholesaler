import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/app_config.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../data_models/models/wholesaler_list_model/wholesaler_list_model.dart';
import '../../../../repository/repository_retailer.dart';
import '../../../../services/auth_service/auth_service.dart';

class AddRequestViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();

  String get tabNumber => _webBasicService.tabNumber.value;
  List<WholeSalerOrFiaListData> wholeSalerFieList = [];
  List<WholeSalerOrFiaListData> selectedWholeSalerFieList = [];

  ScrollController scrollController = ScrollController();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String errorMessage = "";
  bool loader = false;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getWholesalerList(String? type) async {
    setBusy(true);
    notifyListeners();
    wholeSalerFieList = await _retailer.getWholesalerFieForRequestWeb(type);
    setBusy(false);
    notifyListeners();
  }

  putSelectedUserList(List v) {
    print('selectedWholeSalerFieList');
    selectedWholeSalerFieList = List<WholeSalerOrFiaListData>.from(
        jsonDecode(jsonEncode(v))
            .map((model) => WholeSalerOrFiaListData.fromJson(model)));
    print('selectedWholeSalerFieList');
    print(selectedWholeSalerFieList);
    notifyListeners();
  }

  void goBack(BuildContext context, String? type) {
    String routeName = type == 'wholesaler_request'
        ? Routes.wholesalerRequest
        : Routes.fieRequest;
    context.goNamed(routeName);
  }

  Future<void> createRequest(String? type, BuildContext context) async {
    print(selectedWholeSalerFieList);
    if (selectedWholeSalerFieList.isEmpty) {
      errorMessage = type == 'wholesaler_request'
          ? AppLocalizations.of(context)!.needToSelectOneWholesaler
          : AppLocalizations.of(context)!.needToSelectFie;
    } else {
      errorMessage = "";
    }
    notifyListeners();
    if (selectedWholeSalerFieList.isNotEmpty) {
      List<String?> wholesalerFieUniqueIds =
          selectedWholeSalerFieList.map((e) => e.uniqueId).toList();
      setBusyForObject(loader, true);
      notifyListeners();
      ResponseMessageModel response = await _retailer
          .createWholesalerFieForRequestWeb(type, wholesalerFieUniqueIds);
      Utils.toast(response.message!, isSuccess: response.success!);
      setBusyForObject(loader, false);
      notifyListeners();
    }
  }

  void removeItem(String item) {
    int index = selectedWholeSalerFieList
        .indexWhere((element) => element.name == item.split('-')[0]);
    selectedWholeSalerFieList.removeAt((index));
  }
}
