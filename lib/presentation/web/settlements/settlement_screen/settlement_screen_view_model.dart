import 'dart:convert';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/data_models/models/settlement_web_model/settlement_web_model.dart';
import 'package:bingo/services/storage/device_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../app/locator.dart';
import '../../../../const/special_key.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/fie_account_model/fie_account_model.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../data_models/models/settlement_details_model/settlement_details_model_fie.dart';
import '../../../../repository/settlement_repository.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import '../../../widgets/web_widgets/text_fields/calender.dart';

class SettlementScreenViewModel extends BaseViewModel {
  SettlementScreenViewModel() {
    // getUserType();
  }
  final AuthService _auth = locator<AuthService>();
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositorySettlement _settlement = locator<RepositorySettlement>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();
  TextEditingController dateController = TextEditingController(
      text: DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()));

  // UserTypeForWeb get clientType => _settlement.clientType();
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;
  String get tabNumber => _webBasicService.tabNumber.value;
  SettlementDetailsModelFie? settlementDetailsModelFie;
  List<SettlementDetailsModelFieData> settlementListFie = [];
  List<SettlementWebModelData> settlementList = [];
  List<FieAccountModelData> fieAccountList = [];

  String screen = 'settlements';
  // int fiePage = 0;
  void setPage(String c, String? p) {
    Utils.fPrint('pagepage');
    Utils.fPrint(screen);
    screen = c;
    pageNumber = int.parse(p!);
    notifyListeners();
    screen == 'settlements'
        ? getSettlementList(page: p)
        : getAccountList(dateController.text);
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeSettlementTab(BuildContext context, String v) {
    context.goNamed(Routes.retailerSettlement,
        pathParameters: {'page': v, "p": pageNumber.toString()});

    screen = v;
    v == 'settlements'
        ? getSettlementList(page: (pageNumber).toString())
        : getAccountList(dateController.text);
  }

  openDateTime(context) async {
    dateController.text =
        (DateFormat(SpecialKeys.dateFormatYDM).format(await showDialog(
                  context: context,
                  builder: (activeContext) => const Calender(),
                )) ??
                DateFormat(SpecialKeys.dateFormatYDM).format(DateTime.now()))
            .toString();
    notifyListeners();
  }

  UserTypeForWeb get enrollment => _auth.enrollment.value;

  Future getSettlementList({String? page}) async {
    if (enrollment == UserTypeForWeb.fie) {
      setBusyForObject(settlementListFie, true);
      notifyListeners();
      await _settlement.getRetailerSettlementList(enrollment, page: page);
      settlementDetailsModelFie = _settlement.settlementListFie.value;
      settlementListFie = settlementDetailsModelFie!.data!.data!;

      pageNumber = int.parse(page!);
      totalPage = settlementDetailsModelFie!.data!.lastPage!;
      pageTo = settlementDetailsModelFie!.data!.to!;
      pageFrom = settlementDetailsModelFie!.data!.from!;
      dataTotal = settlementDetailsModelFie!.data!.total!;
      setBusyForObject(settlementListFie, false);
      notifyListeners();
    } else {
      setBusyForObject(settlementList, true);
      notifyListeners();
      await _settlement.getRetailerSettlementList(enrollment, page: page);

      SettlementWebModel settlementFieModel = _settlement.settlementFieModel!;
      settlementList = settlementFieModel.data!.data!;

      Utils.fPrint('settlementDetailsModelFie!.data!');
      Utils.fPrint(jsonEncode(settlementFieModel.data!));
      pageNumber = int.parse(page!);
      totalPage = settlementFieModel.data!.lastPage!;
      pageTo = settlementFieModel.data!.to!;
      pageFrom = settlementFieModel.data!.from!;
      dataTotal = settlementFieModel.data!.total!;
      setBusyForObject(settlementList, false);
      notifyListeners();
    }
  }

  Future searchBasedOnDate() async {
    // String formattedDate=DateFormat(SpecialKeys.dateFormat).format();
    await getAccountList(dateController.text);
  }

  Future getAccountList(String date) async {
    setBusyForObject(fieAccountList, true);
    notifyListeners();
    await _settlement.getAccountList(date);
    fieAccountList = _settlement.fieAccountList;

    setBusyForObject(fieAccountList, false);
    notifyListeners();
  }

  bool isAddButtonBusy = false;

  Future addPaymentCollectionLot({required bool isPayment}) async {
    isAddButtonBusy = true;
    notifyListeners();
    ResponseMessageModel responseData =
        await _settlement.addPaymentCollectionLot(isPayment);
    isAddButtonBusy = false;
    notifyListeners();
    Utils.toast(responseData.message!, isSuccess: responseData.success!);

    if (responseData.success!) {
      html.window.location.reload();
    }
  }

  gotoDetails(BuildContext context, String lotId, int type) {
    context.goNamed(Routes.paymentLotDetailsView,
        pathParameters: {'id': lotId, 'type': type.toString()});
  }

  bool isButtonBusy = false;

  void changeButtonStatus(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  Future<void> downloadAccount(bool isCSV) async {
    changeButtonStatus(true);
    await _settlement.downloadSettlement(isCSV, dateController.text);
    changeButtonStatus(false);
  }

  void changePage(BuildContext context, int v) {
    pageNumber = v;
    context.goNamed(
      Routes.retailerSettlement,
      pathParameters: {'page': 'settlements', 'p': '$pageNumber'},
    );
    getSettlementList(page: "$v");
    notifyListeners();
  }
}
