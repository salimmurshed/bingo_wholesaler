import 'dart:convert';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/locator.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/fie_lot_details_model/fie_lot_details_model.dart';
import '../../../../repository/settlement_repository.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/storage/db.dart';
import '../../../../services/storage/device_storage.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';

class PaymentLotDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositorySettlement _settlement = locator<RepositorySettlement>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  FieLotDetailsModel? fieLotList;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Map<String, List<PaymentDetails>>? groupData;
  List<PaymentPartners> dataList = [];
  List<PaymentPartners> searchList = [];
  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  String doubleValueMaker(String v) {
    double d = double.parse(v.replaceAll(',', ''));
    String s = formatter.format(d);
    return s;
  }

  void searchData(String v) {
    if (v.isEmpty) {
      searchList = dataList;
    } else {
      searchList = dataList
          .where((PaymentPartners e) =>
              e.partner!.toLowerCase().contains(v.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> callDetails(String? id, String? type) async {
    setBusyForObject(fieLotList, true);
    notifyListeners();
    Utils.fPrint('fieLotList 1');
    fieLotList = await _settlement.getFieLotList(id, type);
    Utils.fPrint('fieLotList 2');
    if (!fieLotList!.success!) {
      notifyListeners();
      groupData = groupBy(fieLotList!.data![0].paymentDetails!,
          (PaymentDetails obj) => obj.businessPartnerId!);

      groupData!.forEach((k, value) {
        dataList.add(PaymentPartners(
          partner: k,
          balance: value.fold(
              0.0, (prev, element) => prev! + (element.openBalance ?? 0.0)),
          amount: value.fold(
              0.0, (prev, element) => prev! + (element.amountApplied ?? 0.0)),
          paymentDetails: value,
        ));
      });
      searchList = dataList;

      setBusyForObject(fieLotList, false);
      notifyListeners();
    }
  }

  String formattedDocID(String value) {
    if (value.isEmpty) {
      return value;
    } else if (value.contains('Bingo (*****)')) {
      return value;
    } else {
      List<String> v = value.replaceAll(')', '').split("(");
      return "${v[0]}(${v[1].lastChars(10)})";
    }
    // return 'value';
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.retailerSettlement, pathParameters: {'page': '1'});
  }
}
