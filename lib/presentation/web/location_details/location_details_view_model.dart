import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../const/utils.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/customer_store_list/customer_store_list.dart';
import '../../../repository/repository_customer.dart';

class LocationDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customer = locator<CustomerRepository>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  CustomerStoreData? storeDate;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  TextEditingController bingoStoreIdController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController wholesalerStoreIdController = TextEditingController();
  TextEditingController selectSalesZoneController = TextEditingController();

  String businessPhoto = '';
  String signBoardPhoto = '';

  int tabRoute = 0;

  void changeTabRoute(int i) {
    if (tabRoute == i) {
      tabRoute = 0;
    } else {
      tabRoute = i;
    }
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> prefill(String? ttx, String? uid, String? sid) async {
    setBusy(true);
    notifyListeners();
    storeDate = await _customer.getCustomerStoreDetails(ttx!, sid!);
    Utils.fPrint('jsonEncode(storeDate)');
    Utils.fPrint(jsonEncode(storeDate));
    bingoStoreIdController.text = storeDate!.bingoStoreId!.toString();
    locationNameController.text = storeDate!.name!;
    addressController.text =
        storeDate!.address! + "ghgjhfjghjghgfgjgjgfjfjgjghffjg";
    cityController.text = storeDate!.city!;
    countryController.text = storeDate!.country!;
    wholesalerStoreIdController.text = storeDate!.wStoreId!;
    selectSalesZoneController.text = storeDate!.salesZoneName!;
    businessPhoto = storeDate!.storeLogo!;
    signBoardPhoto = storeDate!.signBoardPhoto!;
    setBusy(false);
    notifyListeners();
  }
}
