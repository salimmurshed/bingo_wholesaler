import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/order_repository.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../const/utils.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/all_order_model/all_order_model.dart';

class OrderListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryOrder _order = locator<RepositoryOrder>();
  final AuthService _authService = locator<AuthService>();
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;
  String get tabNumber => _webBasicService.tabNumber.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get userId => _authService.user.value.data!.tempTxAddress!;
  List<AllOrderModelData> orders = [];
  ScrollController scrollController = ScrollController();
  Future<void> getOrderList(String? page) async {
    if (orders.isEmpty) {
      setBusy(true);
      notifyListeners();
    }
    pageNumber = int.parse(page!);
    AllOrderModel ordersModel = await _order.getAllOrderWeb(
        pageNumber.toString(), enrollment == UserTypeForWeb.retailer);
    totalPage = ordersModel.data!.lastPage!;
    pageTo = ordersModel.data!.to!;
    pageFrom = ordersModel.data!.from!;
    dataTotal = ordersModel.data!.total!;
    orders = ordersModel.data!.data!;
    setBusy(false);
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changePage(BuildContext context, int v) {
    context
        .goNamed(Routes.orderListView, pathParameters: {"page": v.toString()});
    getOrderList(v.toString());
  }

  void action(BuildContext context, int v, String wholesaleId, String storeId,
      int orderType, String u, String orderId) {
    Utils.fPrint('wholesaleId');
    Utils.fPrint(enrollment.name);
    if (enrollment == UserTypeForWeb.retailer) {
      if (v == 0) {
        context.goNamed(
          Routes.orderDetailsView,
          pathParameters: {},
          queryParameters: {
            "type": "edit",
            "w": wholesaleId,
            "s": storeId,
            "u": u,
            "ot": orderType.toString(),
          },
        );
      } else {
        context.goNamed(
          Routes.orderDetailsView,
          pathParameters: {},
          queryParameters: {
            "type": "view",
            "w": wholesaleId,
            "s": storeId,
            "u": u,
            "ot": orderType.toString(),
          },
        );
      }
    } else {
      if (v == 0) {
        context.goNamed(
          Routes.orderDetailsView,
          pathParameters: {},
          queryParameters: {
            "type": "edit",
            "id": orderId,
          },
        );
      } else {
        context.goNamed(
          Routes.orderDetailsView,
          pathParameters: {},
          queryParameters: {
            "type": "view",
            "id": orderId,
          },
        );
      }
    }
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.orderAddView);
  }
}
