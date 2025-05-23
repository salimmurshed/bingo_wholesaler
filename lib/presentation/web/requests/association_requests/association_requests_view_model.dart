import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/main.dart';
import 'package:bingo/presentation/widgets/alert/confirmation_dialog.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app_config.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/status_name.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/association_request_model/association_request_model.dart';
import '../../../../data_models/models/association_request_wholesaler_model/association_request_wholesaler_model.dart';
import '../../../../data_models/models/update_response_model/update_response_model.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../../widgets/alert/activation_dialog.dart';
import '../association_actions.dart';

class AssociationRequestViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  UserTypeForWeb get enrollment => _authService.enrollment.value;

  callApi(BuildContext context) async {
    p();
    setBusy(true);
    notifyListeners();
    if (enrollment == UserTypeForWeb.wholesaler) {
      await _wholesaler.getWholesalersAssociationData();
      wholesalerAssociationRequest =
          _wholesaler.wholesalerAssociationRequest.value;
      searchedWholesalerAssociationRequest = wholesalerAssociationRequest;
    } else {
      retailerAssociationRequest =
          await _retailer.getRetailersAssociationDataWeb(
              ModalRoute.of(context)!.settings.name!);
      searchedRetailerAssociationRequest = retailerAssociationRequest;
    }
    setBusy(false);
    notifyListeners();
  }

  searchList(String v) {
    if (enrollment == UserTypeForWeb.wholesaler) {
      if (v.isNotEmpty) {
        searchedWholesalerAssociationRequest = wholesalerAssociationRequest
            .where((i) =>
                i.retailerName!.toLowerCase().contains(v.toLowerCase()) ||
                i.email!.toLowerCase().contains(v.toLowerCase()))
            .toList();
      } else {
        searchedWholesalerAssociationRequest = wholesalerAssociationRequest;
      }
    } else {
      if (v.isNotEmpty) {
        searchedRetailerAssociationRequest = retailerAssociationRequest
            .where((i) =>
                i.wholesalerName!.toLowerCase().contains(v.toLowerCase()))
            .toList();
      } else {
        searchedRetailerAssociationRequest = retailerAssociationRequest;
      }
    }

    notifyListeners();
  }

  List<AssociationRequestWholesalerData> wholesalerAssociationRequest = [];
  List<AssociationRequestData> retailerAssociationRequest = [];
  List<AssociationRequestWholesalerData> searchedWholesalerAssociationRequest =
      [];
  List<AssociationRequestData> searchedRetailerAssociationRequest = [];

  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.addRequestView,
        queryParameters: {'type': ModalRoute.of(context)!.settings.name!});
  }

  Future<void> action(
      BuildContext context, int v, String id, int i, String? uri) async {
    if (v == 0) {
      context.goNamed(Routes.associationRequestDetailsView,
          queryParameters: {'q': id, 'u': uri});
    } else if (v == 1) {
      if (currentStatus(searchedWholesalerAssociationRequest[i].status!) ==
          StatusNames.accepted) {
        UpdateResponseModel? d =
            await _wholesaler.associationActionForActivationCode(
                id, AssociationActions.verified);
        _navigationService.displayDialog(ActivationDialog(
            activationCode: d!.data!.activationCode!,
            isRetailer: enrollment == UserTypeForWeb.retailer));
        // changeAction(id, AssociationActions.verified, context);
      } else if (currentStatus(
              searchedWholesalerAssociationRequest[i].status!) ==
          StatusNames.verified) {
        UpdateResponseModel? d =
            await _wholesaler.associationActionForActivationCode(
                id, AssociationActions.verified);
        _navigationService.displayDialog(ActivationDialog(
            activationCode: d!.data!.activationCode!,
            isRetailer: enrollment == UserTypeForWeb.retailer));
        // changeAction(id, AssociationActions.verified);
      } else if (currentStatus(
              searchedWholesalerAssociationRequest[i].status!) ==
          StatusNames.pending) {
        changeAction(id, AssociationActions.accepted, context);
      } else if (currentStatus(
              searchedWholesalerAssociationRequest[i].status!) ==
          StatusNames.completed) {
        changeAction(id, AssociationActions.approve, context);
      } else {}
    } else {
      changeAction(id, AssociationActions.rejected, context);
    }
  }

  Future<void> changeAction(
      String id, AssociationActions action, BuildContext context) async {
    bool confirmation =
        await _navigationService.animatedDialog(ConfirmationDialog(
      submitButtonText: action.value == 1
          ? "accept"
          : action.value == 2
              ? "reject"
              : action.value == 3
                  ? "verify"
                  : "approve",
      title:
          "Do you really want to ${action.value == 1 ? "accept" : action.value == 2 ? "reject" : action.value == 3 ? "verify" : "approve"} the request?",
      ifYesNo: true,
    ));
    if (confirmation) {
      setBusy(true);
      notifyListeners();
      await _wholesaler.associationActionForActivationCode(id, action);
      await Future.delayed(const Duration(seconds: 5));
      if (context.mounted) {
        await callApi(context);
      }
    }
    setBusy(false);
    notifyListeners();
  }

  // StatusNames currentStatus = StatusNames.rejected;
  StatusNames currentStatus(String status) {
    if (status.replaceAll(' ', '').toLowerCase() ==
        describeEnum(StatusNames.inProcess).toLowerCase()) {
      return StatusNames.inProcess;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        describeEnum(StatusNames.pending).toLowerCase()) {
      return StatusNames.pending;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        describeEnum(StatusNames.accepted).toLowerCase()) {
      return StatusNames.accepted;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        describeEnum(StatusNames.verified).toLowerCase()) {
      return StatusNames.verified;
    } else if (status.replaceAll(' ', '').toLowerCase() ==
        describeEnum(StatusNames.completed).toLowerCase()) {
      return StatusNames.completed;
    } else {
      return StatusNames.rejected;
    }
  }

  changeScreen(BuildContext context, String screen) {
    if (screen == Routes.wholesalerRequest ||
        screen == Routes.fieRequest ||
        screen == Routes.retailerRequest) {
      context.goNamed(screen);
    } else {
      context.goNamed(screen, pathParameters: {"page": "1"});
    }
  }
}
