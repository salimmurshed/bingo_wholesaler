import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../../data_models/enums/user_roles_files.dart';
import '/app/locator.dart';
import '/app/router.dart';
import '/const/utils.dart';
import '/data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import '/repository/repository_components.dart';
import '/repository/repository_retailer.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../data/data_source/visit_frequently_list.dart';
import '../../../data_models/active_creditline_model/active_creditline_model.dart';
import '../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_models/models/term_condition_model/term_condition_model.dart';
import '../../../services/network/network_urls.dart';
import '../../widgets/alert/bool_return_alert_dialog.dart';
import 'package:http/http.dart' as http;

import '../term_screen/term_screen_view.dart';

class RetailerCreditlineListViewModel extends ReactiveViewModel {
  @override
  List<ListenableServiceMixin> get listenableServices => [_repositoryRetailer];
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  ApproveCreditlineRequestData? data;

  List<RetailerBankListData> get retailsBankAccounts =>
      _repositoryRetailer.retailsBankAccounts.value;

  List<TermConditionData> get termConditions => _authService.termConditions;

  String get language => _authService.selectedLanguageCode;
  List<VisitFrequentListModel> visitFrequentlyList =
      AppList.visitFrequentlyList;
  VisitFrequentListModel? visitFrequency;
  bool isReviewScreen = false;
  TextEditingController crn1Controller = TextEditingController();
  TextEditingController crn2Controller = TextEditingController();
  TextEditingController crn3Controller = TextEditingController();
  TextEditingController crp1Controller = TextEditingController();
  TextEditingController crp2Controller = TextEditingController();
  TextEditingController crp3Controller = TextEditingController();
  TextEditingController monthlyPurchaseController = TextEditingController();
  TextEditingController averageTicketController = TextEditingController();
  TextEditingController requestAmountController = TextEditingController();
  String creditLineInformationErrorMessage = "";
  String crn1ErrorMessage = "";
  String crp1ErrorMessage = "";
  String acceptTermConditionErrorMessage = "";
  String fileListErrorMessage = "";
  String filesErrorMessage = "";
  String monthlyPurchaseErrorMessage = "";
  String averageTicketErrorMessage = "";
  String requestAmountErrorMessage = "";
  String visitFrequencyErrorMessage = "";
  bool acceptTermCondition = false;

  List<File> files = [];

  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  // bool get isUserFinanceRole {
  //   return userRoles.contains(UserRoles.finance) ||
  //       userRoles.contains(UserRoles.master);
  // }

  void changeVisitFrequency(VisitFrequentListModel v) {
    visitFrequency = v;
    notifyListeners();
  }

  setDatas(ApproveCreditlineRequestData arguments) {
    data = arguments;
    notifyListeners();
  }

  Future pullToRefresh() async {
    String uid = data!.uniqueId!;
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerCreditlineList();
    data = _repositoryRetailer.approveCreditlineRequestData.value
        .firstWhere((element) => element.uniqueId == uid);
    setBusy(false);
    notifyListeners();
  }

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  gotoSplitCreditLineView() {
    print('retailsBankAccounts');
    print(retailsBankAccounts);
    if (retailsBankAccounts.isEmpty) {
      _navigationService.pushNamed(Routes.splitCreditlineDetailsView,
          arguments: data!.fieName);
    } else {
      ActiveCreditlineModel body = ActiveCreditlineModel(
        stores: [],
        uniqueId: data!.uniqueId!,
        minimumCommitmentDate: data!.minimumCommitmentDate!,
        activeDate: data!.effectiveDate!,
        approveAmount: data!.approvedAmount!,
        remainingAmount: data!.remainAmount!,
        currency: data!.currency!,
        bank: data!.bankName!,
        // bankList: _repositoryComponents.retailerBankList.value,
        isEmptyStore: true,
      );
      _navigationService.pushNamed(Routes.splitCreditlineView, arguments: body);
    }
  }

  gotoSplitCreditLineEdit() {
    ActiveCreditlineModel body = ActiveCreditlineModel(
      uniqueId: data!.uniqueId!,
      stores: data!.retailerStoreDetails,
      activeDate: data!.effectiveDate!,
      minimumCommitmentDate: data!.minimumCommitmentDate!,
      approveAmount: data!.approvedAmount!,
      remainingAmount: data!.remainAmount!,
      currency: data!.currency!,
      bank: data!.bankName,
      // bankList: _repositoryComponents.retailerBankList.value,
      isEmptyStore: false,
    );
    _navigationService.pushNamed(Routes.splitCreditlineView, arguments: body);
  }

  void goBack() {
    isBusy
        ? () {
            print("i m busy");
          }
        : _navigationService.pop();
  }

  inactiveCreditline(context) async {
    print(data!.uniqueId!);
    bool confirmation = await _navigationService.animatedDialog(
            BoolReturnAlertDialog(AppLocalizations.of(context)!
                .creditLineInactiveDialogMessage)) ??
        false;
    if (confirmation) {
      setBusy(true);
      notifyListeners();
      await _repositoryRetailer
          .inactiveCreditline(data!.uniqueId!)
          .catchError((_) {
        setBusy(true);
        notifyListeners();
      });
      await _repositoryRetailer.getRetailerCreditlineList();
      setBusy(false);
      notifyListeners();
      _navigationService.pop();
    }
  }

  void changeAcceptTermCondition() {
    acceptTermCondition = !acceptTermCondition;
    notifyListeners();
  }

  void pickFiles() async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }

  void openTerm(String s, String termTitle) {
    int termNumber = termConditions.indexWhere((element) =>
        element.termsConditionFor!.toLowerCase() == s.toLowerCase());
    _navigationService.push(MaterialPageRoute(
        builder: (c) => TermScreenView(
            id: termTitle,
            des: termConditions[termNumber].termsCondition!,
            isRetailer: true)));
  }

  requestReview(context) async {
    if (!acceptTermCondition) {
      acceptTermConditionErrorMessage =
          (AppLocalizations.of(context)!.pleaseSelectTermConditions);
    } else {
      acceptTermConditionErrorMessage = "";
    }
    if (monthlyPurchaseController.text.isEmpty) {
      monthlyPurchaseErrorMessage =
          AppLocalizations.of(context)!.mPurchaseValidationText;
    } else {
      monthlyPurchaseErrorMessage = "";
    }
    if (averageTicketController.text.isEmpty) {
      averageTicketErrorMessage =
          AppLocalizations.of(context)!.aPurchaseValidationText;
    } else {
      averageTicketErrorMessage = "";
    }
    if (visitFrequency == null) {
      visitFrequencyErrorMessage =
          AppLocalizations.of(context)!.vFrequencyValidationText;
    } else {
      visitFrequencyErrorMessage = "";
    }
    if (requestAmountController.text.isEmpty) {
      requestAmountErrorMessage =
          AppLocalizations.of(context)!.rAmountValidationText;
    } else {
      requestAmountErrorMessage = "";
    }
    if (crn1Controller.text.isEmpty) {
      crn1ErrorMessage =
          AppLocalizations.of(context)!.fillOneCommercialReferenceName;
    } else {
      crn1ErrorMessage = "";
    }
    if (crp1Controller.text.isEmpty) {
      crp1ErrorMessage =
          (AppLocalizations.of(context)!.fillOneCommercialReferencePhone);
    } else {
      crp1ErrorMessage = "";
    }
    if (files.isEmpty) {
      filesErrorMessage = (AppLocalizations.of(context)!.provideRelevantDoc);
    } else {
      filesErrorMessage = "";
    }
    notifyListeners();
    //
    if (crn1Controller.text.isNotEmpty &&
        crp1Controller.text.isNotEmpty &&
        monthlyPurchaseController.text.isNotEmpty &&
        averageTicketController.text.isNotEmpty &&
        requestAmountController.text.isNotEmpty &&
        visitFrequency != null &&
        acceptTermCondition &&
        files.isNotEmpty)
    // if (true)
    {
      setBusy(true);
      notifyListeners();
      MultipartRequest request = _repositoryRetailer
          .createRequest(NetworkUrls.retailerRequestCreditlineReview);

      request.fields["creditline_unique_id"] = data!.uniqueId!;
      request.fields["monthly_purchase"] = monthlyPurchaseController.text;
      request.fields["average_purchase_tickets"] = averageTicketController.text;
      request.fields["visit_frequency"] = visitFrequency!.id!.toString();
      request.fields["requested_amount"] = requestAmountController.text;
      request.fields["commercial_name_one"] = crn1Controller.text;
      request.fields["commercial_phone_one"] = crp1Controller.text;
      request.fields["commercial_name_two"] = crn2Controller.text;
      request.fields["commercial_phone_two"] = crp2Controller.text;
      request.fields["commercial_name_three"] = crn3Controller.text;
      request.fields["commercial_phone_three"] = crp3Controller.text;
      request.fields["auth_check"] = "1";
      for (int i = 0; i < files.length; i++) {
        var img = await http.MultipartFile.fromPath("documents", files[i].path);
        request.files.add(img);
      }
      http.Response response =
          await _repositoryRetailer.submitRequest(request).catchError((_) {
        setBusy(false);
        notifyListeners();
      });
      ResponseMessages responseData =
          ResponseMessages.fromJson(jsonDecode(response.body));
      Utils.toast(responseData.message!, isSuccess: responseData.success!);
      setBusy(false);
      notifyListeners();
      if (responseData.success!) {
        clearForm();
        _navigationService.pop();
      }
    }
  }

  clearForm() {
    monthlyPurchaseController.clear();
    averageTicketController.clear();
    visitFrequency = null;
    requestAmountController.clear();
    crn1Controller.clear();
    crp1Controller.clear();
    crn2Controller.clear();
    crp2Controller.clear();
    crn3Controller.clear();
    crp3Controller.clear();
    acceptTermCondition = false;
  }

  turnReview() {
    isReviewScreen = !isReviewScreen;
    notifyListeners();
  }
}
