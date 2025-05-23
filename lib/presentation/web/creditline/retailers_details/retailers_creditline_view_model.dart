import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../../../../app/app_secrets.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';

class RetailersCreditlineViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  String get tabNumber => _webBasicService.tabNumber.value;
  String location = '';
  ScrollController scrollController = ScrollController();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  ApproveCreditlineRequestData? data;
  int tab = 0;
  changeScreenTab(int v) {
    tab = v;
    notifyListeners();
  }

  List<Map<String, dynamic>> controller = [];

  //
  // Future<String> getLocation(String lat, String lng) async {
  //   var red =
  //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${AppSecrets.kGoogleApiKey}";
  //
  //   final response = await http.get(Uri.parse(red));
  //
  //   location =
  //       (jsonDecode(response.body))["results"][0]['formatted_address'] ?? "";
  //   notifyListeners();
  //   Utils.fPrint('location');
  //   Utils.fPrint(location);
  //   return location;
  // }
  bool isEdit = false;
  Future<void> getRetailerApprovedCreditLines(String? id, String? type) async {
    isEdit = type!.toLowerCase() == "edit" ? true : false;
    setBusy(true);
    notifyListeners();
    data = await _retailer.getRetailerApprovedCreditLines(id!);

    if (isEdit) {
      for (int i = 0; i < data!.retailerStoreDetails!.length; i++) {
        controller.add({
          "id": data!.retailerStoreDetails![i].uniqueId!,
          "controllers": TextEditingController()
        });
      }
    }
    setBusy(false);
    notifyListeners();
  }
}
