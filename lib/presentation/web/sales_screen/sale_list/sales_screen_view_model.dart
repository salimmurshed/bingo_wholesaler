import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/main.dart';
import 'package:bingo/repository/repository_sales.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/storage/db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/locator.dart';
import '../../../../const/database_helper.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/alert/confirmation_dialog.dart';
import 'package:universal_html/html.dart' as html;

class SalesScreenViewModel extends BaseViewModel {
  SalesScreenViewModel() {
    Utils.fPrint(prefs.getString(DataBase.userToken));
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositorySales _sales = locator<RepositorySales>();
  final AuthService _auth = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController = ScrollController();

  // bool get isRetailer => _auth.isRetailer.value;
  UserTypeForWeb get enrollment => _auth.enrollment.value;

  List<AllSalesData> get allSalesData => _sales.allSalesData;
  // List<AllSalesData> allSalesData = [];

  int get totalPage => _sales.totalPage;
  int saleNumber = 1;
  int salePage = 0;

  int get saleTo => _sales.saleTo;

  int get saleFrom => _sales.saleFrom;

  int get saleTotal => _sales.saleTotal;

  String get tabNumber => _webBasicService.tabNumber.value;

  TextEditingController searchController = TextEditingController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getAllSale(int page, String? query) async {
    // if (allSalesData.isEmpty) {
    setBusy(true);
    notifyListeners();
    // }
    saleNumber = page;
    searchController.text = query ?? "";
    await _sales.getWholesalersSalesDataForWeb(page, query);
    // allSalesData = [];
    salePage = _sales.totalPage < 6 ? _sales.totalPage : 5;
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page, String? query) {
    saleNumber = page;
    searchController.text = query ?? "";
    context.goNamed(Routes.saleScreen,
        pathParameters: {'page': page.toString()},
        queryParameters: {'query': query});
    getAllSale(page, query);
    notifyListeners();
  }

  gotoDetails(int v, BuildContext context, String id) async {
    if (enrollment == UserTypeForWeb.wholesaler) {
      if (v == 0 || v == 1) {
        context.goNamed(Routes.saleDetails,
            pathParameters: {'id': id, 'type': v == 0 ? 'view' : 'edit'});
      } else {
        await cancelSale(id);
      }
    } else if (enrollment == UserTypeForWeb.retailer) {
      if (v == 0) {
        context.goNamed(Routes.saleDetails,
            pathParameters: {'id': id, 'type': 'view'});
      } else if (v == 1) {
        bool isConfirmed = await _navigationService.animatedDialog(
            ConfirmationDialog(
                ifYesNo: true,
                title:
                    AppLocalizations.of(activeContext)!.confirmationDialogTitle,
                content: AppLocalizations.of(activeContext)!
                    .confirmationApproveContent));
        if (isConfirmed) {
          setBusy(true);
          notifyListeners();
          var body = {"unique_id": id, "action": '1'};
          ResponseMessageModel? saleDate =
              await _sales.statusChangeSalesWeb(body);
          if (saleDate != null) {
            Utils.toast(saleDate.message ?? "", isSuccess: saleDate.success!);

            if (saleDate.success!) {
              html.window.location.reload();
            } else {
              setBusy(false);
              notifyListeners();
            }
          }
        }
      } else if (v == 2) {
        bool isConfirmed = await _navigationService.animatedDialog(
            ConfirmationDialog(
                ifYesNo: true,
                title:
                    AppLocalizations.of(activeContext)!.confirmationDialogTitle,
                content: AppLocalizations.of(activeContext)!
                    .confirmationRejectContent));
        if (isConfirmed) {
          setBusy(true);
          notifyListeners();
          var body = {"unique_id": id, "action": '2'};
          ResponseMessageModel? saleDate =
              await _sales.statusChangeSalesWeb(body);
          if (saleDate != null) {
            Utils.toast(saleDate.message ?? "", isSuccess: saleDate.success!);

            if (saleDate.success!) {
              html.window.location.reload();
            } else {
              setBusy(false);
              notifyListeners();
            }
          }
        }
      } else if (v == 4) {
        bool isConfirmed = await _navigationService.animatedDialog(
            ConfirmationDialog(
                ifYesNo: true,
                title:
                    AppLocalizations.of(activeContext)!.confirmationDialogTitle,
                content: AppLocalizations.of(activeContext)!
                    .confirmationDeliverContent));
        if (isConfirmed) {
          setBusy(true);
          notifyListeners();
          var body = {"unique_id": id, "action": '3'};
          ResponseMessageModel? saleDate =
              await _sales.statusChangeSalesWeb(body);
          if (saleDate != null) {
            Utils.toast(saleDate.message ?? "", isSuccess: saleDate.success!);

            if (saleDate.success!) {
              html.window.location.reload();
            } else {
              setBusy(false);
              notifyListeners();
            }
          }
        }
      }
    }
  }

  void gotoAddSale(BuildContext context) {
    context.goNamed(Routes.addSales);
  }

  Future cancelSale(String id) async {
    bool isConfirmed =
        await _navigationService.animatedDialog(ConfirmationDialog(
      title: AppLocalizations.of(activeContext)!.cancelTheSale,
      content: AppLocalizations.of(activeContext)!.cancelTheSaleContent,
    ));
    if (isConfirmed) {
      setBusy(true);
      notifyListeners();
      ResponseMessageModel? data = await _sales.cancelSalesWeb(id);

      if (data!.success!) {
        html.window.location.reload();
      }
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.saleCancellMessage,
            isSuccess: data.success!);
      }
      setBusy(false);
      notifyListeners();
    }
  }
}
