import '../../../data_models/enums/user_type_for_web.dart';
import '/const/special_key.dart';
import '/presentation/widgets/alert/confirmation_dialog.dart';
import '/repository/repository_components.dart';
import '/repository/repository_retailer.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/locator.dart';
import '../../../data/data_source/visit_frequently_list.dart';
import '../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../data_models/enums/data_source.dart';
import '../../../data_models/enums/status_name.dart';
import '../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../data_models/models/component_models/sales_zone_model.dart';
import '../../../data_models/models/component_models/tax_id_type_model.dart';
import '../../../data_models/models/retailer_wholesaler_association_request_model/retailer_wholesaler_association_request_model.dart';
import '../../../data_models/models/update_response_model/update_response_model.dart';
import '../../../main.dart';
import '../../../repository/repository_wholesaler.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../widgets/alert/activation_dialog.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/date_picker.dart';
import '../home_screen/home_screen_view_model.dart';
import 'dart:io' show Platform;

class AssociationRequestDetailsScreenModel extends ReactiveViewModel {
  // AssociationRequestDetailsScreenModel() {}

  //locator service
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();

  //get methods
  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  bool get setScreenBusy => enrollment == UserTypeForWeb.retailer
      ? _repositoryRetailer.setScreenBusy.value
      : _repositoryWholesaler.setScreenBusy.value;

  String get language => _authService.selectedLanguageCode;

  Future refreshFieDetail() async {
    setBusy(true);
    notifyListeners();
    print(uniqueId);
    await _repositoryRetailer.refreshRetailerFieAssociationDetails(uniqueId);
    await _repositoryRetailer.getRetailersFieAssociationData();
    _associationRequestRetailerDetails =
        _repositoryRetailer.associationRequestRetailerDetails.value;
    _companyInformationRetails =
        associationRequestRetailerDetails.data![0].companyInformation![0];
    _contactInformationRetails =
        associationRequestRetailerDetails.data![0].contactInformation![0];

    setBusy(false);
    notifyListeners();
  }

  Future refreshWholesalerDetail() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.refreshRetailerAssociationDetails(uniqueId);
    await _repositoryRetailer.getRetailersAssociationData();
    _associationRequestRetailerDetails =
        _repositoryRetailer.associationRequestRetailerDetails.value;
    _companyInformationRetails =
        associationRequestRetailerDetails.data![0].companyInformation![0];
    _contactInformationRetails =
        associationRequestRetailerDetails.data![0].contactInformation![0];
    setBusy(false);
    notifyListeners();
  }

  void callDetails(GetId arguments) async {
    uniqueId = arguments.id;
    type = arguments.type;
    isFie = arguments.isFie;
    notifyListeners();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (enrollment == UserTypeForWeb.retailer) {
        setBusy(true);
        notifyListeners();
        if (arguments.type == RetailerTypeAssociationRequest.wholesaler) {
          _repositoryRetailer
              .getRetailerAssociationDetails(arguments.id)
              .then((value) {
            _associationRequestRetailerDetails =
                _repositoryRetailer.associationRequestRetailerDetails.value;
            _companyInformationRetails = associationRequestRetailerDetails
                .data![0].companyInformation![0];
            _contactInformationRetails = associationRequestRetailerDetails
                .data![0].contactInformation![0];
            customerType = _repositoryComponents.customerType.data!
                .map((e) => e.customerType!)
                .toList();
            gracePeriodGroup = _repositoryComponents.gracePeriodGroup.data!
                .map((e) => e.gracePeriodGroup!)
                .toList();
            pricingGroup = _repositoryComponents.pricingGroup.data!
                .map((e) => e.pricingGroups!)
                .toList();
            salesZone = _repositoryComponents.salesZone.data!;
            setBusy(false);
            notifyListeners();
          });
        } else {
          _repositoryRetailer
              .getRetailerFieAssociationDetails(arguments.id)
              .then((value) {
            _associationRequestRetailerDetails =
                _repositoryRetailer.associationRequestRetailerDetails.value;
            _companyInformationRetails = associationRequestRetailerDetails
                .data![0].companyInformation![0];
            _contactInformationRetails = associationRequestRetailerDetails
                .data![0].contactInformation![0];
            setBusy(false);
            notifyListeners();
          });
        }

        setBusy(false);
        notifyListeners();
      } else {
        // SchedulerBinding.instance.addPostFrameCallback((_) {
        callWholesalersAssociationDetails(arguments);
        // });
      }
    });
  }

  callWholesalersAssociationDetails(arguments) async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.getWholesalersAssociationDetails(arguments.id);
    _associationRequestWholesalerDetails =
        _repositoryWholesaler.wholesalerAssociationRequestDetails.value;
    creditlineInformation =
        associationRequestWholesalerDetails.data![0].creditlineInformation![0];
    companyInformation =
        associationRequestWholesalerDetails.data![0].companyInformation![0];
    internalInformation =
        associationRequestWholesalerDetails.data![0].internalInformation![0];
    contactInformation =
        associationRequestWholesalerDetails.data![0].contactInformation![0];
    setBusy(false);
    notifyListeners();
  }

  AssociationWholesalerRequestDetailsModel
      _associationRequestWholesalerDetails =
      AssociationWholesalerRequestDetailsModel();
  RetailerAssociationRequestDetailsModel _associationRequestRetailerDetails =
      RetailerAssociationRequestDetailsModel();

  AssociationWholesalerRequestDetailsModel
      get associationRequestWholesalerDetails =>
          _associationRequestWholesalerDetails;

  RetailerAssociationRequestDetailsModel
      get associationRequestRetailerDetails =>
          _associationRequestRetailerDetails;
  CompanyInformationRetails _companyInformationRetails =
      CompanyInformationRetails();
  ContactInformationRetails _contactInformationRetails =
      ContactInformationRetails();

  CompanyInformationRetails get companyInformationRetails =>
      _companyInformationRetails;

  ContactInformationRetails get contactInformationRetails =>
      _contactInformationRetails;

  ContactInformation? contactInformation;

  InternalInformation? internalInformation;

  CreditlineInformation? creditlineInformation;

  CompanyInformation? companyInformation;

  //local variables
  String? selectedCustomerType;
  String? selectedGracePeriodGroups;
  String? selectedPricingGroups;
  SalesZoneModelData? selectedSalesZoneString;
  String? selectedAllowOrders;
  String selectedCustomerSinceDate =
      "${AppLocalizations.of(activeContext)!.selectText} ${AppLocalizations.of(activeContext)!.customerSinceDate}";
  VisitFrequentListModel? selectedVisitFrequency;
  int status = 0;
  String uniqueId = "";
  RetailerTypeAssociationRequest type =
      RetailerTypeAssociationRequest.wholesaler;
  bool isFie = false;
  bool isViewDocumentOpen = false;

  //local text controllers
  TextEditingController internalIdController = TextEditingController();
  TextEditingController monthlySalesController = TextEditingController();
  TextEditingController averageSalesTicketController = TextEditingController();
  TextEditingController suggestedCreditLineController = TextEditingController();
  TextEditingController selectDate = TextEditingController();
  TextEditingController setVerificationCoded = TextEditingController();

  //get service data list
  TaxIdType get taxIdType => _repositoryComponents.taxIdType;

  List<String> customerType = [];

  List<String> gracePeriodGroup = [];

  List<String> pricingGroup = [];

  List<SalesZoneModelData> salesZone = [];

  List<String> allowOrdersList = [
    AppLocalizations.of(activeContext)!.yesText,
    AppLocalizations.of(activeContext)!.noText
  ];
  List<VisitFrequentListModel> visitFrequentlyList =
      AppList.visitFrequentlyList;

  int getStatus(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return 1;
      case "rejected":
        return 2;
      case "verified":
        return 3;
      case "active":
        return 4;
      case "completed":
        return 5;
      default:
        return 0;
    }
  }

  void openCalender() async {
    selectDate.text = (DateFormat(SpecialKeys.dateDDMMYYYY)
            .format(await _navigationService.animatedDialog(DatePicker())))
        .toString();
    notifyListeners();
  }

  void gotoBackScreen() {
    _navigationService.pop();
  }

  void changeCustomerType(String data) {
    selectedCustomerType = data;
    notifyListeners();
  }

  void changeGracePeriodGroups(String data) {
    selectedGracePeriodGroups = data;
    notifyListeners();
  }

  void changePricingGroups(String data) {
    selectedPricingGroups = data;
    notifyListeners();
  }

  void changeSalesZone(SalesZoneModelData data) {
    selectedSalesZoneString = data;
    notifyListeners();
  }

  void changeAllowOrders(String data) {
    selectedAllowOrders = data;
    notifyListeners();
  }

  void changeCustomerSinceDate(String data) {
    selectedCustomerSinceDate = data;
    notifyListeners();
  }

  void changeVisitFrequency(VisitFrequentListModel data) {
    selectedVisitFrequency = data;
    notifyListeners();
  }

  void cancelButton() {
    _navigationService.pop();
  }

  String internalIdValidation = "";
  String monthlySalesValidation = "";
  String selectDateValidation = "";
  String averageSalesTicketValidation = "";
  String suggestedCreditLineValidation = "";
  String selectedCustomerTypeValidation = "";
  String selectedGracePeriodGroupsValidation = "";
  String selectedPricingGroupsValidation = "";
  String selectedSalesZoneStringValidation = "";
  String selectedAllowOrdersValidation = "";
  String selectedVisitFrequencyValidation = "";

  void updateWholesalerRetailerAssociationStatus() async {
    if (internalIdController.text == "") {
      internalIdValidation =
          AppLocalizations.of(activeContext)!.internalIdValidationMessage;
    } else {
      internalIdValidation = "";
    }
    if (monthlySalesController.text == "") {
      monthlySalesValidation =
          AppLocalizations.of(activeContext)!.monthlySalesValidationMessage;
    } else {
      monthlySalesValidation = "";
    }
    if (selectDate.text == "") {
      selectDateValidation =
          AppLocalizations.of(activeContext)!.selectDateValidationMessage;
    } else {
      selectDateValidation = "";
    }
    if (averageSalesTicketController.text == "") {
      averageSalesTicketValidation = AppLocalizations.of(activeContext)!
          .averageSalesTicketValidationMessage;
    } else {
      averageSalesTicketValidation = "";
    }
    if (suggestedCreditLineController.text == "") {
      suggestedCreditLineValidation = AppLocalizations.of(activeContext)!
          .suggestedCreditLineValidationMessage;
    } else {
      suggestedCreditLineValidation = "";
    }
    if (selectedCustomerType == null) {
      selectedCustomerTypeValidation = AppLocalizations.of(activeContext)!
          .selectedCustomerTypeValidationMessage;
    } else {
      selectedCustomerTypeValidation = "";
    }
    if (selectedGracePeriodGroups == null) {
      selectedGracePeriodGroupsValidation = AppLocalizations.of(activeContext)!
          .selectedGracePeriodGroupsValidationMessage;
    } else {
      selectedGracePeriodGroupsValidation = "";
    }
    if (selectedPricingGroups == null) {
      selectedPricingGroupsValidation = AppLocalizations.of(activeContext)!
          .selectedPricingGroupsValidationMessage;
    } else {
      selectedPricingGroupsValidation = "";
    }
    if (selectedSalesZoneString == null) {
      selectedSalesZoneStringValidation = AppLocalizations.of(activeContext)!
          .selectedSalesZoneStringValidationMessage;
    } else {
      selectedSalesZoneStringValidation = "";
    }
    if (selectedAllowOrders == null) {
      selectedAllowOrdersValidation = AppLocalizations.of(activeContext)!
          .selectedAllowOrdersValidationMessage;
    } else {
      selectedAllowOrdersValidation = "";
    }
    if (selectedVisitFrequency == null) {
      selectedVisitFrequencyValidation = AppLocalizations.of(activeContext)!
          .selectedVisitFrequencyValidationMessage;
    } else {
      selectedVisitFrequencyValidation = "";
    }
    notifyListeners();
    bool isItemPostAble() {
      return internalIdController.text != "" &&
          monthlySalesController.text != "" &&
          selectDate.text != "" &&
          averageSalesTicketController.text != "" &&
          suggestedCreditLineController.text != "" &&
          selectedCustomerType != null &&
          selectedGracePeriodGroups != null &&
          selectedPricingGroups != null &&
          selectedSalesZoneString != null &&
          selectedAllowOrders != null &&
          selectedVisitFrequency != null;
    }

    if (isItemPostAble()) {
      var sendData = {
        "unique_id": uniqueId,
        "action": "4",
        "internal_id": internalIdController.text,
        "customer_type": selectedCustomerType.toString(),
        "grace_period_group": selectedGracePeriodGroups.toString(),
        "pricing_group": selectedPricingGroups.toString(),
        "sales_zone_unique_id": selectedSalesZoneString!.saleZone!.toString(),
        "allow_orders": selectedAllowOrders == "Yes" ? '1' : '0',
        "customer_since_date": selectDate.text,
        "monthly_sales": monthlySalesController.text,
        "average_sales_ticket": averageSalesTicketController.text,
        "visit_frequency": selectedVisitFrequency!.id!.toString(),
        "suggested_creditline_amount": suggestedCreditLineController.text
      };
      try {
        setBusy(true);
        notifyListeners();
        await _repositoryWholesaler.updateWholesalerRetailerAssociationStatus(
            sendData, uniqueId, 4);

        setBusy(false);
        notifyListeners();
        _navigationService.pop();
      } on Exception catch (e) {
        setBusy(false);
        notifyListeners();
        _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      }
    }
  }

  void openActivationCodeDialog(int statusID) async {
    var sendData = {
      "unique_id": uniqueId,
      "action": statusID.toString(),
    };
    try {
      setBusy(true);
      notifyListeners();
      UpdateResponseModel data =
          await _repositoryWholesaler.updateWholesalerRetailerAssociationStatus(
              sendData, uniqueId, statusID);
      if (companyInformation!.status!.toLowerCase() ==
          describeEnum(StatusNames.verified)) {
        _navigationService.displayDialog(ActivationDialog(
            activationCode: data.data!.activationCode!,
            isRetailer: enrollment == UserTypeForWeb.retailer));
      }
      setBusy(false);
      notifyListeners();
    } on Exception catch (e) {
      setBusy(false);
      notifyListeners();
      _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
  }

  void openActivationCodeSubmitForRetailerDialog(int statusID) async {
    var code = await _navigationService.animatedDialog(
        ActivationDialog(isRetailer: enrollment == UserTypeForWeb.retailer));

    var sendData = {
      "unique_id": uniqueId,
      "action": statusID.toString(),
      "activation_code": code,
    };

    try {
      if (code.isEmpty) {
        if (activeContext.mounted) {
          _navigationService.displayDialog(AlertDialogMessage(
              AppLocalizations.of(activeContext)!.activationRequirement));
        }
      } else if (code.toString().length != 6) {
        if (activeContext.mounted) {
          _navigationService.animatedDialog(AlertDialogMessage(
              AppLocalizations.of(activeContext)!.put6DigitCode));
        }
      } else {
        setBusy(true);
        notifyListeners();

        UpdateResponseModel data = isFie
            ? await _repositoryRetailer.updateRetailerFieAssociationStatus(
                sendData, uniqueId, statusID)
            : await _repositoryRetailer
                .updateRetailerWholesalerAssociationStatus(
                    sendData, uniqueId, statusID);
        _navigationService.animatedDialog(AlertDialogMessage(data.message!));

        setBusy(false);
        notifyListeners();
      }
      await Future.delayed(const Duration(seconds: 1));
      setBusy(false);
      notifyListeners();
    } on Exception catch (e) {
      _navigationService.displayDialog(AlertDialogMessage(e.toString()));
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> deleteRequest(String statusID) async {
    bool confirmation = await _navigationService.animatedDialog(
          ConfirmationDialog(
            submitButtonText: AppLocalizations.of(activeContext)!.reject,
            title: AppLocalizations.of(activeContext)!.wantToRejectTitle,
            content: AppLocalizations.of(activeContext)!.wantToRejectContent,
          ),
        ) ??
        false;
    try {
      var data = {
        "unique_id": uniqueId,
        "action": statusID.toString(),
      };
      if (confirmation == true) {
        if (enrollment == UserTypeForWeb.retailer) {
          if (type == RetailerTypeAssociationRequest.wholesaler) {
            setBusy(true);
            notifyListeners();
            await _repositoryRetailer.rejectRequest(data, uniqueId);
            setBusy(false);
            notifyListeners();
          } else {
            setBusy(true);
            notifyListeners();
            await _repositoryRetailer.rejectRequestFie(data, uniqueId);
            setBusy(false);
            notifyListeners();
          }
        } else {
          await _repositoryWholesaler.rejectRequest(data, uniqueId);
          setBusy(false);
          notifyListeners();
        }
      }
      setBusy(false);
      notifyListeners();
    } catch (_) {}
  }

  void changeViewDocumentOpen() {
    isViewDocumentOpen = !isViewDocumentOpen;
    notifyListeners();
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void navigateTo(double lat, double lng) async {
    try {
      if (Platform.isAndroid) {
        Uri uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch ${uri.toString()}';
        }
      } else {
        Uri uriIos = Uri.parse('http://maps.apple.com/?q=$lat,$lng&mode=d');
        if (await canLaunchUrl(uriIos)) {
          await launchUrl(uriIos);
        } else {
          throw 'Could not launch ${uriIos.toString()}';
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryWholesaler, _repositoryRetailer, _repositoryComponents];
}
