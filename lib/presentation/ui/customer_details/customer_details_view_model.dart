import '../../../const/server_status_file/server_status_file.dart';
import '/app/router.dart';
import '/repository/repository_components.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data_models/enums/static_page_enums.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../data_models/models/component_models/sales_zone_model.dart';
import '../../../data_models/models/customer_creditline_list/customer_creditline_list.dart';
import '../../../data_models/models/customer_sales/customer_sales.dart';
import '../../../data_models/models/customer_settlement_list/customer_settlement_list.dart';
import '../../../data_models/models/customer_store_list/customer_store_list.dart';
import '../../../main.dart';
import '../../../repository/repository_customer.dart';
import '../customer_documents/customer_documents.dart';

class CustomerDetailsViewModel extends ReactiveViewModel {
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  CustomersTabs get customerTab => _repositoryComponents.customerTab.value;

  List<CustomerCreditlineData> get customerCreditline =>
      _customerRepository.customerCreditline;

  String get language => _authService.user.value.data!.languageCode!;

  List<AllSalesData> get customerSales => _customerRepository.customerSales;

  List<CustomerSettlementData> get customerSettlements =>
      _customerRepository.customerSettlements;

  List<CustomerStoreData> get customerStore =>
      _customerRepository.customerStore;

  AssociationWholesalerRequestDetailsModel get customerProfile =>
      _customerRepository.customerProfile;

  List<SalesZoneModelData> get salesZone =>
      _repositoryComponents.salesZone.data!;

  String sortedItemCreditline = AppLocalizations.of(activeContext)!.status;
  String sortedItemSales = AppLocalizations.of(activeContext)!.status;
  String sortedItemSettlements = AppLocalizations.of(activeContext)!.status;
  String temId = "";
  String customerId = "";
  String retaileName = "";

  TextEditingController internalIdController = TextEditingController();
  TextEditingController customerTypeController = TextEditingController();
  TextEditingController gracePeriodGroupsController = TextEditingController();
  TextEditingController pricingGroupsController = TextEditingController();
  TextEditingController salesZoneController = TextEditingController();
  TextEditingController monthlySalesController = TextEditingController();
  TextEditingController averageSalesTicketController = TextEditingController();
  TextEditingController visitFreqController = TextEditingController();
  TextEditingController selectDate = TextEditingController();
  TextEditingController suggestedCreditLineAmountController =
      TextEditingController();

  setInternal() {
    if (customerProfile.data == null) {
      setBusy(true);
      notifyListeners();
      setBusy(false);
    } else {
      setBusy(true);
      internalIdController.text =
          customerProfile.data![0].internalInformation![0].internalId!;
      customerTypeController.text =
          customerProfile.data![0].internalInformation![0].customerType!;
      gracePeriodGroupsController.text =
          customerProfile.data![0].internalInformation![0].gracePeriodGroup!;
      pricingGroupsController.text =
          customerProfile.data![0].internalInformation![0].pricingGroup!;
      salesZoneController.text =
          customerProfile.data![0].internalInformation![0].salesZone!;
      monthlySalesController.text =
          customerProfile.data![0].creditlineInformation![0].monthlySales!;
      averageSalesTicketController.text = customerProfile
          .data![0].creditlineInformation![0].averageSalesTicket!;

      visitFreqController.text = StatusFile.visitFrequent(
          language,
          customerProfile.data![0].creditlineInformation![0].visitFrequency ??
              0);
      selectDate.text =
          customerProfile.data![0].creditlineInformation![0].customerSinceDate!;
      suggestedCreditLineAmountController.text = customerProfile
          .data![0].creditlineInformation![0].suggestedCreditlineAmount!;
      setBusy(false);
      notifyListeners();
    }
  }

  String getTwoDeci(String v) {
    // String d = double.parse(v.replaceAll(",", '')).toStringAsFixed(2);
    String d1 = "${v.split(".")[0]}.${v.split(".")[1][0]}${v.split(".")[1][1]}";
    return d1;
  }

  //load buttons
  bool get salesLoadMoreButton => _customerRepository.salesLoadMoreButton;

  bool isLoadingMore = false;

  //page numbers
  int salePageNumber = 1;

  void setLoadMore(v) {
    isLoadingMore = v;
    notifyListeners();
  }

  void setData(List<String> arguments) async {
    temId = arguments[0];
    retaileName = arguments[1];
    customerId = arguments[2];

    setBusy(true);
    notifyListeners();
    await getCustomerCreditlineOnline();
    await getCustomerSales();
    await getCustomerSettlements();
    await getCustomerStore();
    await getCustomerProfile();
    setInternal();
    setBusy(false);
    notifyListeners();
  }

  void gotoSalesDetails(AllSalesData storeList) {
    CustomerSalesData c = CustomerSalesData.fromJson(storeList.toJson());
    print(c.toJson());
    _navigationService.pushNamed(Routes.salesDetailsScreen,
        arguments: storeList);
  }

  void changeTab(int i, BuildContext context) {
    _repositoryComponents.changeTab(i, context);
  }

  void creditlineSortList(String e) {
    _customerRepository.creditlineSortList(e);
    sortedItemCreditline = e;
    notifyListeners();
  }

  void salesCustomerSortList(String e) {
    _customerRepository.salesCustomerSortList(e);
    sortedItemSales = e;
    notifyListeners();
  }

  Future getCustomerCreditlineOnline() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerCreditlineOnline(temId, false);
    setBusy(false);
    notifyListeners();
  }

  Future refreshCustomerCreditlineOnline() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerCreditlineOnline(temId, true);
    setBusy(false);
    notifyListeners();
  }

  Future getCustomerSales() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerSales(temId, 1);
    setBusy(false);
    notifyListeners();
  }

  Future getCustomerSettlements() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerSettlements(temId, false);
    setBusy(false);
    notifyListeners();
  }

  Future refreshCustomerSettlements() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerSettlements(temId, true);
    setBusy(false);
    notifyListeners();
  }

  Future getCustomerProfile() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerProfile(customerId, false);
    setBusy(false);
    notifyListeners();
  }

  Future refreshCustomerProfile() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerSettlements(temId, true);
    setBusy(false);
    notifyListeners();
  }

  Future getCustomerStore() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerStore(temId, false);
    setBusy(false);
    notifyListeners();
  }

  Future refreshCustomerStore() async {
    setBusy(true);
    notifyListeners();
    await _customerRepository.getCustomerStore(temId, true);
    setBusy(false);
    notifyListeners();
  }

  void settlementsCustomerSortList(String e) {
    _customerRepository.settlementsCustomerSortList(e);
    sortedItemSettlements = e;
    notifyListeners();
  }

  void loadMoreCustomerSales() async {
    salePageNumber += 1;
    setLoadMore(true);
    await _customerRepository.getCustomerSales(temId, salePageNumber);
    setLoadMore(false);
  }

  Future refreshCustomerSales() async {
    salePageNumber = 1;
    setBusy(true);
    notifyListeners();
    await _customerRepository.refreshSales(temId, 1);
    setBusy(false);
    notifyListeners();
  }

  double getFrictionOfAvailability(int i) {
    double friction = double.parse(
            customerCreditline[i].consumedAmount!.replaceAll(",", "")) /
        double.parse(customerCreditline[i]
            .approvedCreditLineAmount!
            .replaceAll(",", ""));
    return friction;
  }

  void gotoCreditlineDetails(int i) {
    _navigationService.pushNamed(Routes.customerCreditlineDetailsView,
        arguments: customerCreditline[i]);
  }

  void gotoLocationDetails(CustomerStoreData customerStore) {
    _navigationService.pushNamed(Routes.customerLocationDetails,
        arguments: customerStore);
  }

  void gotoDocumentsDetails(activeContext) {
    Navigator.push(
      activeContext,
      MaterialPageRoute(builder: (activeContext) => const CustomerDocuments()),
    );
  }

  void gotoSettlementDetails(int i) {
    _navigationService.pushNamed(Routes.customerSettlementDetails,
        arguments: customerSettlements[i]);
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryComponents, _customerRepository];
}
