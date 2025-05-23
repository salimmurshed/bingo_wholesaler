import 'dart:convert';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../app/web_route.dart';
import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../data_models/models/store_model/store_model.dart';
import '../../../../../repository/repository_website_settings.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../../services/web_basic_service/WebBasicService.dart';

class StoreListViewModel extends BaseViewModel {
  StoreListViewModel() {
    getRetailerUserList();
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryWebsiteSettings _settings =
      locator<RepositoryWebsiteSettings>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  List<StoreData> storeList = [];

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getRetailerUserList() async {
    setBusy(true);
    notifyListeners();
    storeList = (await _settings.getStoreList());

    setBusy(false);
    notifyListeners();
  }

  void gotoAddStore(BuildContext context) {
    context.goNamed(Routes.addStore);
  }

  void action(int v, BuildContext context, String id, StoreData storeData) {
    if (v == 0) {
      gotoEditStore(context, id);
    } else if (v == 2) {
      callApi(context, id, storeData.status);
    } else {}
  }

  void gotoEditStore(
    BuildContext context,
    String id,
  ) {
    context.goNamed(Routes.editStore, pathParameters: {'id': id});
  }

  Future<void> callApi(BuildContext context, String id, String? status) async {
    setBusy(true);
    notifyListeners();
    var body = {
      "unique_id": id,
    };
    Response response =
        await _repositoryRetailer.changeRetailerStoreStatus(body);
    ResponseMessageModel responseMessageModel =
        ResponseMessageModel.fromJson(jsonDecode(response.body));
//after api correction
    Utils.toast(
        status == "Active"
            ? "Store has been deactivated"
            : "Store has been activated",
        isSuccess: responseMessageModel.success!);
    await Future.delayed(const Duration(seconds: 2));
    if (responseMessageModel.success!) {
      storeList = (await _settings.getStoreList());
    }
    setBusy(false);
    notifyListeners();
  }
}
