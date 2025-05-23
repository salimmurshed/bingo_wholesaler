import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/data_source/visit_frequently_list.dart';
import '../../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/enums/zones_and_routes_notification_types.dart';
import '../../../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../../../data_models/models/internal_configuration_list_model.dart';
import '../../../../../services/auth_service/auth_service.dart';

class RetailerInternalViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  InternalConfigurationListModel? configure;
  ScrollController scrollController = ScrollController();

  TextEditingController customerSinceController = TextEditingController();
  TextEditingController averageSaleTicketController = TextEditingController();
  TextEditingController internalIdController = TextEditingController();
  TextEditingController monthlySalesController = TextEditingController();
  TextEditingController suggestedClController = TextEditingController();

  String customerSinceError = "";
  String averageSaleTicketError = "";
  String internalIdError = "";
  String monthlySalesError = "";
  String suggestedClError = "";

  List<CustomerType>? customerTypes = [];
  List<GracePeriod>? gracePeriods = [];
  List<PricingGroups>? pricingGroups = [];
  List<SaleZones>? saleZones = [];
  List<String>? allowOrders = ["No", "Yes"];
  List<VisitFrequentListModel> visitFrequency = AppList.visitFrequentlyList;

  CustomerType? selectedCustomerType;
  GracePeriod? selectedGracePeriod;
  PricingGroups? selectedPricingGroups;
  SaleZones? selectedSaleZones;
  String? selectedAllowOrders;
  VisitFrequentListModel? selectedFrequency;
  bool isButtonBusy = false;

  void makeButtonBusy(v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  AssociationWholesalerRequestDetailsModel? customerProfile;

  Future<void> getInternalConfigurationList(String id) async {
    setBusy(true);
    notifyListeners();
    configure = await _customerRepository.getInternalConfigurationList();
    customerTypes = configure!.data!.customerType;
    gracePeriods = configure!.data!.gracePeriod;
    pricingGroups = configure!.data!.pricingGroups;
    saleZones = configure!.data!.saleZones;
    await _customerRepository.getCustomerProfile(id, false);
    customerProfile = _customerRepository.customerProfile;
    InternalInformation ii = customerProfile!.data![0].internalInformation![0];
    CreditlineInformation ci =
        customerProfile!.data![0].creditlineInformation![0];
    internalIdController.text = ii.internalId!;
    customerSinceController.text = ci.customerSinceDate!;
    monthlySalesController.text = ci.monthlySales!;
    averageSaleTicketController.text = ci.averageSalesTicket!;
    suggestedClController.text = ci.suggestedCreditlineAmount!;

    selectedCustomerType = customerTypes!
            .map((item) => item.customerType)
            .contains(ii.customerType!)
        ? customerTypes!.firstWhere((e) => e.customerType == ii.customerType)
        : null;

    selectedGracePeriod = gracePeriods!
            .map((item) => item.gracePeriodGroup)
            .contains(ii.gracePeriodGroup!)
        ? gracePeriods!
            .firstWhere((e) => e.gracePeriodGroup == ii.gracePeriodGroup)
        : null;

    selectedPricingGroups = pricingGroups!
            .map((item) => item.pricingGroups)
            .contains(ii.pricingGroup!)
        ? pricingGroups!.firstWhere((e) => e.pricingGroups == ii.pricingGroup)
        : null;
    selectedSaleZones =
        saleZones!.map((item) => item.saleZone).contains(ii.salesZone!)
            ? saleZones!.firstWhere((e) => e.saleZone == ii.salesZone)
            : null;
    selectedFrequency =
        visitFrequency.map((item) => item.id).contains(ci.visitFrequency!)
            ? visitFrequency.firstWhere((e) => e.id == ci.visitFrequency)
            : null;
    selectedAllowOrders = ii.allowOrders == 1 ? "Yes" : "No";

    setBusy(false);
    notifyListeners();
  }

  update(uniqueId) async {
    if (customerSinceController.text.isEmpty) {
      customerSinceError = "Need to fill customer since date";
    } else {
      customerSinceError = "";
    }
    if (averageSaleTicketController.text.isEmpty) {
      averageSaleTicketError = "Need to fill average sale ticket";
    } else {
      averageSaleTicketError = "";
    }

    if (monthlySalesController.text.isEmpty) {
      monthlySalesError = "Need to fill monthly sales number";
    } else {
      monthlySalesError = "";
    }
    if (suggestedClController.text.isEmpty) {
      suggestedClError = "Need to fill suggested creditline amount";
    } else {
      suggestedClError = "";
    }
    notifyListeners();
    if (customerSinceController.text.isNotEmpty &&
        averageSaleTicketController.text.isNotEmpty &&
        monthlySalesController.text.isNotEmpty &&
        suggestedClController.text.isNotEmpty) {
      var sendData = {
        "unique_id": uniqueId,
        "action": "4",
        "internal_id": internalIdController.text,
        "customer_type": selectedCustomerType!.customerType.toString(),
        "grace_period_group": selectedGracePeriod!.gracePeriodGroup.toString(),
        "pricing_group": selectedPricingGroups!.pricingGroups.toString(),
        "sales_zone_unique_id": selectedSaleZones!.saleZone!.toString(),
        "allow_orders": selectedAllowOrders == "Yes" ? '1' : '0',
        "customer_since_date": customerSinceController.text,
        "monthly_sales": monthlySalesController.text,
        "average_sales_ticket": averageSaleTicketController.text,
        "visit_frequency": selectedFrequency!.id!.toString(),
        "suggested_creditline_amount": suggestedClController.text
      };
      makeButtonBusy(true);
      Response d =
          await _wholesaler.updateWholesalerRetailerInternalProfile(sendData);
      Utils.fPrint((d.body));
      if (jsonDecode(d.body)['success']) {
        Utils.toast(jsonDecode(d.body)['message']);
      } else {
        Utils.toast(jsonDecode(d.body)['message']);
      }
      makeButtonBusy(false);
    }
  }
}
