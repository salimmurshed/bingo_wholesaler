import 'package:bingo/app/web_route.dart';
import 'package:bingo/presentation/widgets/alert/confirmation_dialog.dart';
import 'package:universal_html/html.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/presentation/web/requests/association_actions.dart';
import 'package:bingo/presentation/widgets/web_widgets/alert_dialod.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:go_router/go_router.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../../app/app_config.dart';
import '../../../../const/special_key.dart';
import '../../../../data/data_source/visit_frequently_list.dart';
import '../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../data_models/enums/status_name.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../../data_models/models/internal_configuration_list_model.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../data_models/models/retailer_wholesaler_association_request_model/retailer_wholesaler_association_request_model.dart';
import '../../../../data_models/models/update_response_model/update_response_model.dart';
import '../../../widgets/alert/activation_dialog.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/web_widgets/text_fields/calender.dart';

class AssociationRequestDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  InternalConfigurationListModel? configure;

  String get tabNumber => _webBasicService.tabNumber.value;

  UserTypeForWeb get enrollment => _authService.enrollment.value;
  int item = 0;
  ScrollController scrollController = ScrollController();
  List<String> category = [];
  List<String> taxIdType = [];
  List<String> idType = [];
  List<String> country = [];
  List<String> city = [];
  List<CustomerType> customerType = [];
  List<GracePeriod> gracePeriod = [];
  List<PricingGroups> pricingGroup = [];
  List<SaleZones> salesZone = [];
  List<String> allowOrders = [];
  List<VisitFrequentListModel> visitFrequency = [];
  List<TextEditingController> storeIdListController = [];
  List<SaleZones?> storeSaleZoneList = [];
  List<String> storeWholesalerIdValidations = [];
  List<String> storeSaleZoneValidations = [];
  String selectedCategory = "";
  String selectedTaxIdType = "";
  String selectedIdType = "";
  String selectedCountry = "";
  String selectedCity = "";
  CustomerType? selectedCustomerType;
  GracePeriod? selectedGracePeriod;
  PricingGroups? selectedPricingGroup;
  SaleZones? selectedSalesZone;
  String selectedAllowOrders = "";
  VisitFrequentListModel? selectedVisitFrequency;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController associationDateController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController retailerNameController = TextEditingController();
  TextEditingController internalIdController = TextEditingController();
  TextEditingController customerSinceDateController = TextEditingController();
  TextEditingController monthlySaleController = TextEditingController();
  TextEditingController averageTicketController = TextEditingController();
  TextEditingController suggestedCreditLineAmountController =
      TextEditingController();

  void viewDocuments() {
    if (enrollment == UserTypeForWeb.retailer) {
      String status = dataRetailer!.data![0].companyInformation![0].status!;
      if (status.toLowerCase() != "approved") {
        _navigationService.animatedDialog(const AlertDialogWeb(
          header: "Bussiness Partner Approval",
          body:
              "Your account activation is under process. Wait till it been activated",
        ));
      }
    } else {
      String status = data!.data![0].companyInformation![0].status!;
      if (status.toLowerCase() != "approved") {
        _navigationService.animatedDialog(const AlertDialogWeb(
          header: "Business Partner Approval",
          body:
              "Your account activation is under process. Wait till it been activated",
        ));
      }
    }
  }

  goToList(BuildContext context, String uri) {
    enrollment == UserTypeForWeb.wholesaler
        ? context.goNamed(Routes.retailerRequest)
        : uri == "wholesaler_request"
            ? context.goNamed(Routes.wholesalerRequest)
            : context.goNamed(Routes.fieRequest);
  }

  changeItem(int v) {
    item = v;
    notifyListeners();
  }

  String internalIdValidation = "";
  String customerTypeValidation = "";
  String gracePeriodValidation = "";
  String pricingGroupValidation = "";
  String salesZoneValidation = "";
  String customerSinceDateValidation = "";
  String monthlySalesValidation = "";
  String averageSalesValidation = "";
  String visitFrequencyValidation = "";
  String suggestCreditLineValidation = "";
  String bpIdR = "";
  changeInternalInformationCustomerType(CustomerType v2) {
    selectedCustomerType = v2;
    notifyListeners();
  }

  changeInternalInformationGracePeriod(GracePeriod? v2) {
    selectedGracePeriod = v2;
    notifyListeners();
  }

  changeInternalInformationPricingGroup(PricingGroups? v2) {
    selectedPricingGroup = v2;
    notifyListeners();
  }

  changeInternalInformationSaleZones(SaleZones? v2) {
    selectedSalesZone = v2;
    notifyListeners();
  }

  changeInternalInformationAllowOrder(String? v2) {
    selectedAllowOrders = v2!;
    notifyListeners();
  }

  nextItem() {
    Utils.fPrint(item.toString());
    if (item == 2) {
      for (var i = 0; i < storeIdListController.length; i++) {
        if (storeIdListController[i].text.isEmpty) {
          storeWholesalerIdValidations[i] = "Need to fill wholesaler id";
        } else {
          storeWholesalerIdValidations[i] = "";
        }
      }
      for (var i = 0; i < storeSaleZoneList.length; i++) {
        if (storeSaleZoneList[i] == null) {
          storeSaleZoneValidations[i] = "Need to fill sales zone";
        } else {
          storeSaleZoneValidations[i] = "";
        }
      }
      if (internalIdController.text.isEmpty) {
        internalIdValidation = "Need to fill internal ID";
      } else {
        internalIdValidation = "";
      }
      if (selectedCustomerType == null) {
        customerTypeValidation = "Need to fill customer type";
      } else {
        customerTypeValidation = "";
      }
      if (selectedGracePeriod == null) {
        gracePeriodValidation = "Need to fill grace period group";
      } else {
        gracePeriodValidation = "";
      }
      if (selectedPricingGroup == null) {
        pricingGroupValidation = "Need to fill Pricing group";
      } else {
        pricingGroupValidation = "";
      }
      if (selectedSalesZone == null) {
        salesZoneValidation = "Need to fill sales zone";
      } else {
        salesZoneValidation = "";
      }
      notifyListeners();

      if (internalIdValidation.isEmpty &&
          customerTypeValidation.isEmpty &&
          gracePeriodValidation.isEmpty &&
          pricingGroupValidation.isEmpty &&
          salesZoneValidation.isEmpty) {
        item += 1;
        notifyListeners();
      }
    } else {
      item += 1;
      notifyListeners();
    }
  }

  previousItem() {
    item -= 1;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  AssociationWholesalerRequestDetailsModel? data;
  RetailerAssociationRequestDetailsModel? dataRetailer;
  String uniqueId = "";

  prefill(String? id, BuildContext context, String? uri) {
    enrollment == UserTypeForWeb.retailer
        ? prefillRetailer(id, context, uri)
        : prefillWholesaler(id);
  }

  Future<void> prefillRetailer(
      String? id, BuildContext context, String? uri) async {
    setBusy(true);
    notifyListeners();
    uniqueId = id!;
    bool forRetailer = uri == "wholesaler_request";
    dataRetailer =
        await _retailer.getRetailerAssociationDetailsWeb(id, forRetailer);

    firstNameController.text =
        dataRetailer!.data![0].contactInformation![0].firstName ?? "";
    lastNameController.text =
        dataRetailer!.data![0].contactInformation![0].lastName ?? "";
    idController.text = dataRetailer!.data![0].contactInformation![0].id ?? "";
    phoneController.text =
        dataRetailer!.data![0].contactInformation![0].phoneNumber ?? "";
    positionController.text =
        dataRetailer!.data![0].contactInformation![0].position ?? "";
    companyNameController.text =
        dataRetailer!.data![0].companyInformation![0].companyName ?? "";
    associationDateController.text =
        dataRetailer!.data![0].companyInformation![0].associationDate ?? "";
    taxIdController.text =
        dataRetailer!.data![0].companyInformation![0].taxId ?? "";
    addressController.text =
        dataRetailer!.data![0].companyInformation![0].companyAddress ?? "";
    setBusy(false);
    notifyListeners();
  }

  changeStoreSaleZone(int i, SaleZones v) {
    storeSaleZoneList[i] = v;
    notifyListeners();
  }

  changeSelectedVisitFrequency(VisitFrequentListModel? v) {
    selectedVisitFrequency = v;
    notifyListeners();
  }

  changeCustomerSinceDate() async {
    customerSinceDateController.text = (DateFormat(SpecialKeys.dateDDMMYYYY)
        .format(await _navigationService.animatedDialog(Calender())));
    notifyListeners();
  }

  Future<void> prefillWholesaler(String? id) async {
    uniqueId = id!;
    setBusy(true);
    notifyListeners();

    await _wholesaler.getWholesalersAssociationDetails(id);
    data = _wholesaler.wholesalerAssociationRequestDetails.value;
    configure = await _customerRepository.getInternalConfigurationList();

    InternalInformation ii = data!.data![0].internalInformation![0];
    CreditlineInformation ci = data!.data![0].creditlineInformation![0];
    bpIdR = data!.data![0].companyInformation![0].bpIdR ?? "";
    storeIdListController = List.generate(
        ii.retailerStoreDetails!.length, (i) => TextEditingController());
    storeSaleZoneList =
        List.generate(ii.retailerStoreDetails!.length, (i) => null);
    storeWholesalerIdValidations =
        List.generate(ii.retailerStoreDetails!.length, (i) => "");
    storeSaleZoneValidations =
        List.generate(ii.retailerStoreDetails!.length, (i) => "");
    customerType = configure!.data!.customerType ?? [];
    gracePeriod = configure!.data!.gracePeriod ?? [];
    pricingGroup = configure!.data!.pricingGroups ?? [];
    salesZone = configure!.data!.saleZones ?? [];
    allowOrders = ["Yes", "No"];

    retailerNameController.text =
        data!.data![0].companyInformation![0].retailerName!;

    taxIdController.text = data!.data![0].companyInformation![0].taxId!;
    addressController.text =
        data!.data![0].companyInformation![0].companyAddress!;

    firstNameController.text = data!.data![0].contactInformation![0].firstName!;
    lastNameController.text = data!.data![0].contactInformation![0].lastName!;
    emailController.text = data!.data![0].contactInformation![0].email!;
    idController.text = data!.data![0].contactInformation![0].id!;
    phoneController.text = data!.data![0].contactInformation![0].phoneNumber!;
    positionController.text = data!.data![0].contactInformation![0].position!;

    internalIdController.text =
        data!.data![0].internalInformation![0].internalId!;

    customerSinceDateController.text =
        data!.data![0].creditlineInformation![0].customerSinceDate!;
    monthlySaleController.text =
        data!.data![0].creditlineInformation![0].monthlySales!;
    averageTicketController.text =
        data!.data![0].creditlineInformation![0].averageSalesTicket!;
    suggestedCreditLineAmountController.text =
        data!.data![0].creditlineInformation![0].suggestedCreditlineAmount!;
    getStatus(data!.data![0].companyInformation![0].status!);
    taxIdType.add(data!.data![0].companyInformation![0].taxIdType!);
    category.add(data!.data![0].companyInformation![0].category!);
    idType.add(data!.data![0].contactInformation![0].idType!);
    country.add(data!.data![0].contactInformation![0].country!);
    city.add(data!.data![0].contactInformation![0].city!);
    selectedCustomerType =
        customerType.map((item) => item.customerType).contains(ii.customerType!)
            ? customerType.firstWhere((e) => e.customerType == ii.customerType)
            : null;

    selectedGracePeriod = gracePeriod
            .map((item) => item.gracePeriodGroup)
            .contains(ii.gracePeriodGroup!)
        ? gracePeriod
            .firstWhere((e) => e.gracePeriodGroup == ii.gracePeriodGroup)
        : null;

    selectedPricingGroup = pricingGroup
            .map((item) => item.pricingGroups)
            .contains(ii.pricingGroup!)
        ? pricingGroup.firstWhere((e) => e.pricingGroups == ii.pricingGroup)
        : null;

    selectedSalesZone =
        salesZone.map((item) => item.saleZone).contains(ii.salesZone!)
            ? salesZone.firstWhere((e) => e.saleZone == ii.salesZone)
            : null;
    selectedVisitFrequency =
        visitFrequency.map((item) => item.id).contains(ci.visitFrequency!)
            ? visitFrequency.firstWhere((e) => e.id == ci.visitFrequency)
            : null;
    selectedAllowOrders = ii.allowOrders == 1 ? "Yes" : "No";

    visitFrequency = AppList.visitFrequentlyList;

    selectedTaxIdType = taxIdType.first;
    selectedCategory = category.first;
    selectedIdType = idType.first;
    selectedCountry = country.first;
    selectedCity = city.first;

    if (data!.data![0].creditlineInformation![0].visitFrequency != 0) {
      selectedVisitFrequency = visitFrequency
          .where((element) =>
              element.id ==
              data!.data![0].creditlineInformation![0].visitFrequency!)
          .first;
    }

    setBusy(false);
    notifyListeners();
  }

  bool isButtonBusy = false;

  void setButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void openActivationCodeDialog(
      int statusID, BuildContext context, String uri) async {
    var sendData = {
      "unique_id": uniqueId,
      "action": statusID.toString(),
    };
    try {
      setButtonBusy(true);
      UpdateResponseModel d =
          await _wholesaler.updateWholesalerRetailerAssociationStatus(
              sendData, uniqueId, statusID);
      if (data!.data![0].companyInformation![0].status!.toLowerCase() ==
          (StatusNames.verified.name)) {
        _navigationService.displayDialog(ActivationDialog(
            activationCode: d.data!.activationCode!,
            isRetailer: enrollment == UserTypeForWeb.retailer));
      }
      if (context.mounted) {
        await resetData(context, uri);
      }
      setButtonBusy(false);
      notifyListeners();
    } on Exception catch (e) {
      setBusy(false);
      notifyListeners();
      _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
  }

  StatusNames currentStatus = StatusNames.rejected;

  void getStatus(String status) {
    if (status.replaceAll(' ', '').toLowerCase() ==
        (StatusNames.inProcess.name).toLowerCase()) {
      currentStatus = StatusNames.inProcess;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        (StatusNames.pending.name).toLowerCase()) {
      currentStatus = StatusNames.pending;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        (StatusNames.accepted.name).toLowerCase()) {
      currentStatus = StatusNames.accepted;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        (StatusNames.verified.name).toLowerCase()) {
      currentStatus = StatusNames.verified;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        (StatusNames.completed.name).toLowerCase()) {
      currentStatus = StatusNames.completed;
    } else {
      currentStatus = StatusNames.rejected;
    }
  }

  Future<void> changeAction(
      BuildContext context, AssociationActions action, String uri) async {
    print('actionaction');
    print(action);
    if (action == AssociationActions.rejected) {
      bool confirm =
          await _navigationService.animatedDialog(const ConfirmationDialog(
        title: "Do you really want to reject the request?",
        ifYesNo: true,
      ));
      if (confirm) {
        setButtonBusy(true);
        await _wholesaler.associationActionForActivationCode(uniqueId, action);
        await resetData(context, uri);
        setButtonBusy(false);
      }
    }
  }

  Future<void> resetData(BuildContext context, uri) async {
    category = [];
    taxIdType = [];
    idType = [];
    country = [];
    city = [];
    customerType = [];
    gracePeriod = [];
    pricingGroup = [];
    salesZone = [];
    allowOrders = [];
    visitFrequency = [];
    await prefill(uniqueId, context, uri);
  }

  setPricing() async {
    if (customerSinceDateController.text.isEmpty) {
      customerSinceDateValidation = "Need to fill Customer Since date";
    } else {
      customerSinceDateValidation = "";
    }
    if (monthlySaleController.text.isEmpty) {
      monthlySalesValidation = "Need to fill monthly sales";
    } else {
      monthlySalesValidation = "";
    }
    if (averageTicketController.text.isEmpty) {
      averageSalesValidation = "Need to fill average sales ticket";
    } else {
      averageSalesValidation = "";
    }
    if (selectedVisitFrequency == null) {
      visitFrequencyValidation = "Need to select frequency date ";
    } else {
      visitFrequencyValidation = "";
    }
    if (suggestedCreditLineAmountController.text.isEmpty) {
      suggestCreditLineValidation = "Need to fill suggested creditline amount";
    } else {
      suggestCreditLineValidation = "";
    }

    if (customerSinceDateValidation.isEmpty &&
        monthlySalesValidation.isEmpty &&
        averageSalesValidation.isEmpty &&
        suggestCreditLineValidation.isEmpty &&
        visitFrequencyValidation.isEmpty) {
      var body = {
        "unique_id": uniqueId,
        "action": "4",
        "internal_id": internalIdController.text,
        "customer_type": selectedCustomerType!.customerType!,
        "grace_period_group": selectedGracePeriod!.gracePeriodGroup!,
        "pricing_group": selectedPricingGroup!.pricingGroups!,
        "sales_zone_unique_id": selectedSalesZone!.saleZone!.toString(),
        "allow_orders": selectedAllowOrders == "Yes" ? '1' : '0',
        "customer_since_date": customerSinceDateController.text,
        "monthly_sales": monthlySaleController.text,
        "average_sales_ticket": averageTicketController.text,
        "visit_frequency": selectedVisitFrequency!.id!.toString(),
        "suggested_creditline_amount": suggestedCreditLineAmountController.text
      };
      List body2List = [];
      for (int i = 0;
          i <
              data!.data![0].internalInformation![0].retailerStoreDetails!
                  .length;
          i++) {
        var body2 = {
          "bp_id_r": bpIdR,
          "store_id": data!.data![0].internalInformation![0]
              .retailerStoreDetails![i].storeId,
          "wholesaler_store_id": data!.data![0].internalInformation![0]
              .retailerStoreDetails![i].wholesalerStoreId,
          "sales_zone_unique_id": data!.data![0].internalInformation![0]
              .retailerStoreDetails![i].salesZone
        };
        body2List.add(body2);
      }
      Utils.fPrint('bodybodybody');
      Utils.fPrint(body.toString());
      setButtonBusy(true);
      ResponseMessageModel response = await _repositoryWholesaler
          .webWholesaler_RequsetSetPricing(body, body2List);
      Utils.fPrint(response.toJson().toString());
      Utils.toast(response.message!, isSuccess: response.success!);
      if (response.success!) {
        window.history.replaceState('', '',
            '${ConstantEnvironment.redirectBaseURL}/${Routes.retailerRequest}');

        window.history.back();
      }
      setButtonBusy(false);
    }

    notifyListeners();
  }
}
