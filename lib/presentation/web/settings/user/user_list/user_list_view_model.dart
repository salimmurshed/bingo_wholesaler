import 'dart:convert';

import 'package:bingo/app/web_route.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_roles_files.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../data_models/models/retailer_users_model/retailer_users_model.dart';
import '../../../../../repository/repository_retailer.dart';
import '../../../../../repository/repository_website_settings.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../../services/web_basic_service/WebBasicService.dart';

class UserListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();

  final AuthService _auth = locator<AuthService>();
  final RepositoryWebsiteSettings _settings =
      locator<RepositoryWebsiteSettings>();

  String get tabNumber => _webBasicService.tabNumber.value;

  // bool get isRetailer => _auth.isRetailer.value;
  UserTypeForWeb get enrollment => _auth.enrollment.value;

  bool get isMaster => _auth.user.value.data!.isMaster!;
  bool haveAccess(UserRolesFiles userRolesFiles) {
    return _auth.isUserHaveAccess(userRolesFiles);
  }

  // isUserHaveAccess(UserRolesFiles.addEditEditUser)
  ScrollController scrollController = ScrollController();

  RetailerUsersModel? retailerUsersModel = RetailerUsersModel();

  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getRetailerUserList(String page) async {
    setBusy(true);
    notifyListeners();
    retailerUsersModel = (await _settings.getRetailerUserList(page));
    Utils.fPrint('retailerUsersModel');
    Utils.fPrint(jsonEncode(retailerUsersModel));
    totalPage = retailerUsersModel!.data!.lastPage!;
    pageTo = retailerUsersModel!.data!.to!;
    pageFrom = retailerUsersModel!.data!.from!;
    dataTotal = retailerUsersModel!.data!.total!;
    pageNumber = int.parse(page);
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    context.goNamed(Routes.userList, pathParameters: {'page': page.toString()});
    getRetailerUserList(page.toString());
    notifyListeners();
  }

  String statusCheckUser(status) {
    switch (status) {
      case 1:
        return "Active";
      case 2:
        return "Inactive";
    }
    return "";
  }

  void gotoAddUser(BuildContext context) {
    context.goNamed(Routes.addUser);
  }

  void action(int v, BuildContext context, String id, int status) {
    if (v == 0) {
      context.goNamed(Routes.editUser, pathParameters: {'id': id});
    } else if (v == 2) {
      callApi(context, id, status);
    } else {}
  }

  Future<void> callApi(BuildContext context, String id, int status) async {
    setBusy(true);
    notifyListeners();
    var body = {
      "unique_id": id,
      "status": status == 0 ? "1" : "0",
    };
    Response response = await _repositoryRetailer.inactiveUser(body);
    ResponseMessageModel responseMessageModel =
        ResponseMessageModel.fromJson(jsonDecode(response.body));

    Utils.toast(responseMessageModel.message!,
        isSuccess: responseMessageModel.success!);
    if (responseMessageModel.success!) {
      retailerUsersModel =
          (await _settings.getRetailerUserList(pageNumber.toString()));
    }
    setBusy(false);
    notifyListeners();
  }
}
