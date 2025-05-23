import '/data_models/construction_model/wholesaler_data.dart';
import '/repository/repository_components.dart';
import '/repository/repository_retailer.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data/data_source/visit_frequently_list.dart';
import '../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../data_models/models/component_models/partner_with_currency_list.dart';
import '../../../main.dart';

class AddWholesalerViewModel extends ReactiveViewModel {
  AddWholesalerViewModel() {
    getSortedWholsaler();
  }

  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  String submitButton = AppLocalizations.of(activeContext)!.submitButton;
  WholesalerData? selectWholesaler;
  String? selectCurrency;
  List<String> allCurrency = [];
  VisitFrequentListModel? visitFrequency;

  TextEditingController purchaseController = TextEditingController();
  TextEditingController averageTicketController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<WholesalerData> creditLineInformation = [];

  PartnerWithCurrencyList get allWholesalers => //1st
      _repositoryComponents.wholesalerWithCurrency.value;

  List<WholesalerData> sortedWholsaler = [];

  String get language => _authService.selectedLanguageCode;

  void getSortedWholsaler() {
    for (WholesalersData i in _repositoryRetailer.creditLineInformation.value) {
      creditLineInformation.add(i.wholesaler!);
    }
    sortedWholsaler = allWholesalers.data![0].wholesalerData!
        .where((element) => !(creditLineInformation
            .any((e) => e.wholesalerName == element.wholesalerName)))
        .toList();
    notifyListeners();
  }

  List<VisitFrequentListModel> visitFrequentlyList =
      AppList.visitFrequentlyList;
  WholesalersData wholesalerData = WholesalersData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool isNew = true;

  void setDetails(WholesalersData arguments) {
    print(arguments.monthlyPurchase);
    wholesalerData = arguments;
    submitButton = AppLocalizations.of(activeContext)!.update;
    isNew = false;
    preFix(arguments);
    notifyListeners();
  }

  void changeSelectWholesaler(WholesalerData v) {
    allCurrency.clear();
    selectWholesaler = v;
    selectCurrency = null;

    // notifyListeners();
    int index = allWholesalers.data![0].wholesalerData!
        .indexWhere((element) => element.bpIdW == v.bpIdW);
    // allCurrency.add(AppLocalizations.of(context)!.selectCurrency);
    allCurrency.addAll(allWholesalers
        .data![0].wholesalerData![index].wholesalerCurrency!
        .map((e) => e.currency!)
        .toList());
    notifyListeners();
  }

  WholesalerData? wholesaler;

  preFix(WholesalersData data) {
    wholesaler = data.wholesaler!;
    allCurrency.add(data.currency!);
    selectCurrency = data.currency;
    visitFrequency = data.visitFrequency;
    purchaseController.text = data.monthlyPurchase!;
    averageTicketController.text = data.averageTicket!;
    amountController.text = data.amount!;
    notifyListeners();
  }

  void changeSelectCurrency(String v) {
    selectCurrency = v;
    notifyListeners();
  }

  void changeVisitFrequency(VisitFrequentListModel v) {
    visitFrequency = v;
    notifyListeners();
  }

  bool canSubmitData() {
    if (selectWholesaler != null &&
        selectCurrency != null &&
        purchaseController.text.isNotEmpty &&
        averageTicketController.text.isNotEmpty &&
        visitFrequency != null &&
        amountController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void sendErrorMessage() {
    print('selectCurrency');
    print(selectCurrency);
    if (selectWholesaler == null) {
      _wValidationText =
          AppLocalizations.of(activeContext)!.wholesalerValidationText;
      notifyListeners();
    } else {
      _wValidationText = "";
      notifyListeners();
    }
    if (selectCurrency == null) {
      _cValidationText =
          AppLocalizations.of(activeContext)!.cWholesalerValidationText;
      notifyListeners();
    } else {
      _cValidationText = "";
      notifyListeners();
    }
    if (selectCurrency == null) {
      _cValidationText =
          AppLocalizations.of(activeContext)!.currencyValidationText;
      notifyListeners();
    } else {
      _cValidationText = "";
      notifyListeners();
    }
    if (purchaseController.text.isEmpty) {
      _mPValidationText =
          AppLocalizations.of(activeContext)!.mPurchaseValidationText;
      notifyListeners();
    } else {
      _mPValidationText = "";
      notifyListeners();
    }
    if (averageTicketController.text.isEmpty) {
      _aPValidationText =
          AppLocalizations.of(activeContext)!.aPurchaseValidationText;
      notifyListeners();
    } else {
      _aPValidationText = "";
      notifyListeners();
    }
    if (visitFrequency == null) {
      _vFValidationText =
          AppLocalizations.of(activeContext)!.vFrequencyValidationText;
      notifyListeners();
    } else {
      _vFValidationText = "";
      notifyListeners();
    }
    if (amountController.text.isEmpty) {
      _rAValidationText =
          AppLocalizations.of(activeContext)!.rAmountValidationText;
      notifyListeners();
    } else {
      _rAValidationText = "";
      notifyListeners();
    }
    print(currencyValidationText);
  }

  Future<void> load() async {
    setBusy(true);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    setBusy(false);
    notifyListeners();
  }

  void addWholesaler(context) async {
    SnackBar snackBar;
    sendErrorMessage();
    if (canSubmitData()) {
      WholesalersData item = WholesalersData(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          wholesaler: selectWholesaler!,
          currency: selectCurrency,
          monthlyPurchase: purchaseController.text,
          averageTicket: averageTicketController.text,
          visitFrequency: visitFrequency,
          amount: amountController.text);

      _repositoryRetailer.addCreditLineInformation(item);
      snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.saveDataMessage),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await load();
      _navigationService.pop(true);
    }
  }

  Future<void> updateWholesaler(context) async {
    SnackBar snackBar;
    sendErrorMessage();
    selectWholesaler = wholesaler;
    if (canSubmitData()) {
      WholesalersData item = WholesalersData(
          id: wholesalerData.id!,
          wholesaler: selectWholesaler!,
          currency: selectCurrency,
          monthlyPurchase: purchaseController.text,
          averageTicket: averageTicketController.text,
          visitFrequency: visitFrequency,
          amount: amountController.text);
      _repositoryRetailer.updateWholesaler(wholesalerData.id!, item);
      snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.updateDataMessage),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await load();
      _navigationService.pop();
    }
  }

  void removeCreditLineInformation(context) {
    SnackBar snackBar;
    _repositoryRetailer.removeCreditLineInformation(wholesalerData.id!);
    snackBar = SnackBar(
      content: Text(AppLocalizations.of(context)!.removeWholeSalerText),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _navigationService.pop();
  }

  String _wValidationText = "";
  String _cValidationText = "";
  String _mPValidationText = "";
  String _aPValidationText = "";
  String _vFValidationText = "";
  String _rAValidationText = "";

  String get wholesalerValidationText => _wValidationText;

  String get currencyValidationText => _cValidationText;

  String get mPValidationText => _mPValidationText;

  String get aPValidationText => _aPValidationText;

  String get vFValidationText => _vFValidationText;

  String get rAValidationText => _rAValidationText;
  bool isTextFieldValidate = false;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryRetailer, _repositoryComponents];
}
