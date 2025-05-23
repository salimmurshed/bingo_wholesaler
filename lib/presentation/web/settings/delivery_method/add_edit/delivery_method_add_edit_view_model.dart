import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/app_config.dart';
import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/delivery_method_model.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../repository/repository_wholesaler.dart';
import 'package:universal_html/html.dart';

import '../../../../../services/auth_service/auth_service.dart';

class DeliveryMethodAddEditViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  TextEditingController deliveryMethodIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isEdit = false;
  String? selectedCurrency;
  String id = '';
  String errorMessageMethodId = '';
  String saleZoneErrorMessage = '';
  String currencyErrorMessage = '';
  String amountErrorMessage = '';
  String descriptionErrorMessage = '';

  List<String> currencies = [];
  List<SaleZonesForDelivery> saleZones = [];

  List<SaleZonesForDelivery> selectedSaleZone = [];
  List preSaleZone = [];
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getDeliveryMethods({String? id}) async {
    setBusy(true);
    notifyListeners();
    DeliveryMethodModel deliveryMethodModel =
        await _wholesaler.getDeleveryMethods(id: id);
    saleZones = deliveryMethodModel.data!.saleZones!;
    currencies = deliveryMethodModel.data!.currencies!;
    if (id != null) {
      deliveryMethodIdController.text =
          deliveryMethodModel.data!.deliveryMethods!.deliveryMethodId!;
      descriptionController.text =
          deliveryMethodModel.data!.deliveryMethods!.description!;
      amountController.text = deliveryMethodModel
          .data!.deliveryMethods!.shippingAndHandlingCost!
          .toStringAsFixed(2);
      selectedCurrency = deliveryMethodModel.data!.deliveryMethods!.currency!;
      selectedSaleZone = deliveryMethodModel.data!.deliveryMethods!.saleZone!;
      for (int i = 0;
          i < deliveryMethodModel.data!.deliveryMethods!.saleZone!.length;
          i++) {
        preSaleZone.add({
          'parameter': 'zone_name',
          'value':
              deliveryMethodModel.data!.deliveryMethods!.saleZone![i].zoneName
        });
      }
      Utils.fPrint('preSaleZone');
      Utils.fPrint(preSaleZone.toString());
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> setData(String? getId) async {
    if (getId == null) {
      isEdit = false;
      await getDeliveryMethods();
    } else {
      isEdit = true;
      id = getId;
      await getDeliveryMethods(id: getId);
    }
    notifyListeners();
  }

  editDeliveryMethod() async {
    if (deliveryMethodIdController.text.isEmpty) {
      errorMessageMethodId = 'Need to enter payment method name';
    } else {
      errorMessageMethodId = '';
    }
    if (selectedSaleZone.isEmpty) {
      saleZoneErrorMessage = 'Need to select sale zone';
    } else {
      saleZoneErrorMessage = '';
    }
    if (selectedCurrency == null) {
      currencyErrorMessage = 'Need to select currency';
    } else {
      currencyErrorMessage = '';
    }
    if (amountController.text.isEmpty) {
      amountErrorMessage = 'Need to enter amount';
    } else {
      amountErrorMessage = '';
    }
    if (descriptionController.text.isEmpty) {
      descriptionErrorMessage = 'Need to enter description';
    } else {
      descriptionErrorMessage = '';
    }
    notifyListeners();

    if (errorMessageMethodId.isEmpty &&
        saleZoneErrorMessage.isEmpty &&
        currencyErrorMessage.isEmpty &&
        amountErrorMessage.isEmpty &&
        descriptionErrorMessage.isEmpty) {
      String saleZone = selectedSaleZone.map((e) => e.uniqueId).toString();

      var body = ({
        "delivery_method_id": deliveryMethodIdController.text,
        "description": descriptionController.text,
        "sale_zone": saleZone
            .replaceAll("(", "")
            .replaceAll(")", "")
            .replaceAll(" ", ""),
        "shipping_and_handling_cost": amountController.text,
        "currency": selectedCurrency,
        "status": "1"
      });
      setBusyForObject(deliveryMethodIdController, true);
      notifyListeners();
      ResponseMessageModel response =
          await _wholesaler.editDeleveryMethods(body, id);
      Utils.toast(response.message!, isSuccess: response.success!);
      if (response.success!) {
        window.history.replaceState(
            '', '', '${ConstantEnvironment.redirectBaseURL}/delivery_method');

        window.history.back();
      }
      setBusyForObject(deliveryMethodIdController, false);
      notifyListeners();
    }
  }

  void removeStoreItem(String item) {
    Utils.fPrint(item);
    // int index = saleZones
    //     .indexWhere((element) => element.name == item.split('-')[0]);
    // saleZones.removeAt(index);

    notifyListeners();
  }

  putSelectedSaleZoneList(List v) {
    selectedSaleZone = List<SaleZonesForDelivery>.from(jsonDecode(jsonEncode(v))
        .map((model) => SaleZonesForDelivery.fromJson(model)));
    notifyListeners();
  }

  changeCurrency(String value) {
    selectedCurrency = value;
    notifyListeners();
  }
}
