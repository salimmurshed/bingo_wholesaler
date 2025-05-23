import 'dart:convert';
import '/const/utils.dart';
import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/const/special_key.dart';
import '/data_models/active_creditline_model/active_creditline_model.dart';
import '/main.dart';
import '/repository/repository_retailer.dart';
import '/services/navigation/navigation_service.dart';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../data_models/models/term_condition_model/term_condition_model.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../services/network/network_urls.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../term_screen/term_screen_view.dart';

class SplitCreditlineViewModel extends BaseViewModel {
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  bool isChecked = false;
  TextEditingController minimumCommittedDateController =
      TextEditingController();
  TextEditingController approveAmountController = TextEditingController();
  TextEditingController remainAmountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  ActiveCreditlineModel? data;

  List<TermConditionData> get termConditions => _authService.termConditions;
  List<RetailerBankListData> bankList = [];

  RetailerBankListData? selectedBankName;

  String termErrorMessage = "";
  String bankSelectionErrorMessage = "";
  String amountErrorMessage = "";

  void goBack() {
    isBusy
        ? () {
            print("i m busy");
          }
        : _navigationService.pop();
  }

  void unFocusAll(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void changeChecked() {
    isChecked = !isChecked;
    checkTermAcceptance();
    notifyListeners();
    print(isChecked);
  }

  void checkTermAcceptance() {
    if (isChecked) {
      termErrorMessage = "";
    } else {
      termErrorMessage = AppLocalizations.of(activeContext)!
          .activationCreditLineAmountTermCondition;
    }
    notifyListeners();
  }

  List<Stores> get stores => _authService.user.value.data!.stores!;
  List<TextEditingController> controller = [];
  List<FocusNode> focusNodes = [];
  bool isEmptyStore = true;

  clearValue(i) {
    focusNodes[i].addListener(() {
      if (focusNodes[i].hasFocus) {
        if (controller[i].text == "0.00" || controller[i].text == "0.0") {
          controller[i].clear();
        }
      } else if (!focusNodes[i].hasFocus) {
        if (controller[i].text == "") {
          controller[i].text = "0.00";
        }
      }
    });
  }

  setData(ActiveCreditlineModel arguments) {
    setBusyForObject(bankList, true);
    bankList = _repositoryRetailer.retailsBankAccounts.value;
    notifyListeners();
    setBusy(true);
    notifyListeners();
    isEmptyStore = arguments.isEmptyStore;
    if (arguments.stores!.isEmpty) {
      for (int i = 0; i < stores.length; i++) {
        controller.add(TextEditingController(text: "0.00"));
        focusNodes.add(FocusNode());
      }
    } else {
      for (int i = 0; i < arguments.stores!.length; i++) {
        controller.add(TextEditingController(
            text: Utils.stringTo2Decimal(arguments.stores![i].amount!)));
        focusNodes.add(FocusNode());
      }
    }
    if (!isEmptyStore) {
      selectedBankName = bankList.firstWhere(
          (element) =>
              element.fieName!.toLowerCase() == arguments.bank!.toLowerCase(),
          orElse: () => RetailerBankListData());
    }
    setBusyForObject(bankList, false);
    notifyListeners();
    data = arguments;
    if (arguments.minimumCommitmentDate.isEmpty) {
      minimumCommittedDateController.text = "";
    } else {
      minimumCommittedDateController.text = DateFormat(SpecialKeys.dateFormat)
          .format(DateTime.parse(arguments.minimumCommitmentDate));
    }

    approveAmountController.text =
        "${arguments.currency} ${arguments.approveAmount}";
    remainAmountController.text =
        "${arguments.currency} ${arguments.remainingAmount}";
    setBusy(false);
    notifyListeners();
  }

  void changeRetailerBankList(RetailerBankListData value) {
    selectedBankName = value;
    notifyListeners();
  }

  Future activeCreditLineFull() async {
    if (!isEmptyStore) {
      // activateCreditLineEdit();
    } else {
      activateCreditLineAdd();
    }
  }

  double getSum() {
    return controller
        .map((item) => double.parse(item.text))
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  Future<void> activateCreditLineAdd() async {
    checkTermAcceptance();
    if (selectedBankName == null) {
      bankSelectionErrorMessage =
          AppLocalizations.of(activeContext)!.bankSelectionErrorMessage;
    } else {
      bankSelectionErrorMessage = "";
    }
    if (getSum() != double.parse(data!.remainingAmount.replaceAll(",", ""))) {
      _navigationService.animatedDialog(AlertDialogMessage(
          AppLocalizations.of(activeContext)!.accumulateAmountAlertMessage));
    }

    if (isChecked &&
        selectedBankName != null &&
        getSum() == double.parse(data!.remainingAmount.replaceAll(",", ""))) {
      setBusy(true);
      String url = isEmptyStore
          ? NetworkUrls.activeCreditlineRequests
          : NetworkUrls.updateCreditlineStoreAssignment;
      MultipartRequest request = _repositoryRetailer.createRequest(url);

      request.fields["creditline_unique_id"] = data!.uniqueId;
      request.fields["bank_account_unique_id"] = selectedBankName!.uniqueId!;

      for (int i = 0; i < stores.length; i++) {
        request.fields["amount[$i]"] =
            controller[i].text.isEmpty ? "0.00" : controller[i].text;
      }
      for (int i = 0; i < stores.length; i++) {
        print(jsonEncode(stores[i]));
        request.fields["store_unique_id[$i]"] = stores[i].uniqueId ?? "";
      }
      Response? response =
          await _repositoryRetailer.activeCreditlineRequests(request, []);
      ResponseMessages body =
          ResponseMessages.fromJson(jsonDecode(response.body));
      if (response.statusCode == 500) {
        if (activeContext.mounted) {
          _navigationService.animatedDialog(AlertDialogMessage(
              AppLocalizations.of(activeContext)!.serverError));
        }
        setBusy(false);
      } else if (!body.success!) {
        setBusy(false);
        _navigationService.animatedDialog(AlertDialogMessage(body.message!));
      } else {
        await _repositoryRetailer.getRetailerCreditlineList();
        setBusy(false);
        notifyListeners();
        Utils.toast(body.message!, isSuccess: true);
        _navigationService
          ..pop()
          ..pop();
      }
    } else {}
  }

  bool isButtonBusy = false;

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
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
}
