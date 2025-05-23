import 'dart:convert';
import 'dart:typed_data';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/network/web_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:bingo/app/locator.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../data/data_source/visit_frequently_list.dart';
import '../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/component_models/fie_list_creditline_request_model.dart';
import '../../../../data_models/models/component_models/partner_with_currency_list.dart';
import '../../../../data_models/models/component_models/response_model.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/network/network_urls.dart';
import '../../../widgets/alert/alert_dialog.dart';

class AddNewCreditlineViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryComponents _components = locator<RepositoryComponents>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WebService _webService = locator<WebService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  AddNewCreditlineViewModel() {
    // for (int i = 0; i < itemsCount; i++) {
    monthlyControllers.add(TextEditingController());
    purchasesControllers.add(TextEditingController());
    amountControllers.add(TextEditingController());
    frequencyList.add(null);
    selectedWholesaler.add(null);
    currencyList.add(null);
    // }
    getWholesalerList();
    notifyListeners();
  }

  PartnerWithCurrencyList? wholesalerWithCurrency;
  List<WholesalerData> wholesalerList = [];
  List<List<WholesalerData>> sortedWholesalerList = [];

  String get tabNumber => _webBasicService.tabNumber.value;
  int itemsCount = 1;
  List<WholesalerData?> selectedWholesaler = [];
  List<WholesalerCurrency?> currencyList = [];
  List<VisitFrequentListModel?> frequencyList = [];
  List<TextEditingController> monthlyControllers = [];
  List<TextEditingController> purchasesControllers = [];
  List<TextEditingController> amountControllers = [];
  List<VisitFrequentListModel> visitFrequentlyList =
      AppList.visitFrequentlyList;
  int? selectedOption;
  bool acceptTermCondition = false;
  bool isButtonBusy = false;
  List<FieCreditLineRequestData> fieList = [];
  FieCreditLineRequestData? selectedFie;
  String platformImageName = "";
  Uint8List? platformImage;

  List<FieCreditLineRequestData> selectedFileList = [];

  //error messages
  String creditLineInformationErrorMessage = "";
  String crn1ErrorMessage = "";
  String crp1ErrorMessage = "";
  String selectedOptionErrorMessage = "";
  String acceptTermConditionErrorMessage = "";
  String fieListErrorMessage = "";
  String filesErrorMessage = "";

  void change(value) {
    selectedFie = FieCreditLineRequestData.fromJson(value);
    notifyListeners();
    Utils.fPrint(selectedFie.toString());
  }

  void selectedFieData(List value) {
    selectedFileList = List<FieCreditLineRequestData>.from(
        jsonDecode(jsonEncode(value))
            .map((model) => FieCreditLineRequestData.fromJson(model)));

    // value
    // .map((e) => FieCreditLineRequestData.fromJson(jsonDecode(e)))
    // .toList();
    Utils.fPrint('selectedFileList');
    Utils.fPrint(selectedFileList.toString());
    // FieCreditLineRequestData.fromJson(value);
  }

  List<PlatformFile> files = [];

  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      onFileLoading: (status) => Utils.fPrint(status.toString()),
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (result != null) {
      files = result.files;
    } else {
      files = [];
    }
    notifyListeners();
  }

  getWholesalerList() async {
    setBusy(true);
    notifyListeners();
    await _components.getWholesalerWithCurrency();
    wholesalerWithCurrency = _components.wholesalerWithCurrency.value;
    wholesalerList = wholesalerWithCurrency!.data![0].wholesalerData!;
    sortedWholesalerList.add(wholesalerWithCurrency!.data![0].wholesalerData!);
    Utils.fPrint('wholesalerListwholesalerList');
    Utils.fPrint(wholesalerList.toString());
    fieList = (await _components.getAllFieListForCreditLineWeb()) ?? [];
    Utils.fPrint('sortedWholesalerList');
    Utils.fPrint(wholesalerList.length.toString());
    setBusy(false);
    notifyListeners();
  }

  selectFrequent(int i, VisitFrequentListModel? v) {
    frequencyList[i] = v;

    notifyListeners();
  }

  selectWholesaler(int i, WholesalerData? v) {
    currencyList[i] = null;
    if (sortedWholesalerList.last.length != 1) {
      selectedWholesaler[i] = v;
      List<WholesalerData> innerArray = List.from(sortedWholesalerList.last);
      innerArray.removeAt(1);
      sortedWholesalerList.add(innerArray);
      // currencyList.clear();
      notifyListeners();
    } else {
      selectedWholesaler[i] = v;

      notifyListeners();
    }
  }

  selectCurrency(int i, WholesalerCurrency? v) {
    currencyList[i] = v;
    notifyListeners();
  }

  increaseWholeSalers() {
    if (selectedWholesaler[itemsCount - 1] != null &&
        frequencyList[itemsCount - 1] != null &&
        currencyList[itemsCount - 1] != null &&
        monthlyControllers[itemsCount - 1].text.isNotEmpty &&
        purchasesControllers[itemsCount - 1].text.isNotEmpty &&
        amountControllers[itemsCount - 1].text.isNotEmpty) {
      itemsCount = itemsCount + 1;
      monthlyControllers.add(TextEditingController());
      purchasesControllers.add(TextEditingController());
      amountControllers.add(TextEditingController());
      frequencyList.add(null);
      selectedWholesaler.add(null);
      currencyList.add(null);

      notifyListeners();
    } else {
      Utils.toast("fill the previous wholesaler's data");
      notifyListeners();
    }
    notifyListeners();
  }

  removeWholeSalers() {
    if (itemsCount > 1) {
      itemsCount = itemsCount - 1;
      monthlyControllers.remove(monthlyControllers.last);
      purchasesControllers.remove(purchasesControllers.last);
      amountControllers.remove(amountControllers.last);
      frequencyList.remove(frequencyList.last);
      selectedWholesaler.remove(selectedWholesaler.last);
      currencyList.remove(currencyList.last);
      notifyListeners();
    }
  }

  ScrollController scrollController = ScrollController();
  TextEditingController crn1Controller = TextEditingController();
  TextEditingController crn2Controller = TextEditingController();
  TextEditingController crn3Controller = TextEditingController();
  TextEditingController crp1Controller = TextEditingController();
  TextEditingController crp2Controller = TextEditingController();
  TextEditingController crp3Controller = TextEditingController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeOption(int v) {
    selectedOption = v;
    notifyListeners();
  }

  void changeCheckBox() {
    acceptTermCondition = !acceptTermCondition;
    notifyListeners();
  }

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  Future<void> addCreditLine(BuildContext context) async {
    makeButtonBusy(true);
    Utils.fPrint('selectedWholesaler');
    Utils.fPrint(selectedWholesaler.toString());
    if (selectedWholesaler[0] == null) {
      creditLineInformationErrorMessage =
          (AppLocalizations.of(context)!.needToSelectOneWholesaler);
    } else {
      creditLineInformationErrorMessage = "";
    }
    if (selectedFileList.isEmpty) {
      fieListErrorMessage = (AppLocalizations.of(context)!.needToSelectFie);
    } else {
      fieListErrorMessage = "";
    }
    if (selectedOption == null) {
      selectedOptionErrorMessage =
          (AppLocalizations.of(context)!.pleaseSelectOne);
    } else {
      selectedOptionErrorMessage = "";
    }
    if (!acceptTermCondition) {
      acceptTermConditionErrorMessage =
          (AppLocalizations.of(context)!.pleaseSelectTermConditions);
    } else {
      acceptTermConditionErrorMessage = "";
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
    notifyListeners();
    if (files.isEmpty) {
      filesErrorMessage = (AppLocalizations.of(context)!.provideRelevantDoc);
    } else {
      filesErrorMessage = "";
    }
    try {
      if (creditLineInformationErrorMessage.isEmpty &&
          acceptTermCondition &&
          selectedFileList.isNotEmpty &&
          crn1Controller.text.isNotEmpty &&
          crp1Controller.text.isNotEmpty &&
          (selectedOption == 0 || selectedOption == 1) &&
          files.isNotEmpty) {
        List<String> wholesaler =
            selectedWholesaler.map((e) => e!.associationUniqueId!).toList();
        List<String> currency = currencyList.map((e) => e!.currency!).toList();
        List<String> monthlyPurchase =
            monthlyControllers.map((e) => e.text).toList();
        List<String> averagePurchaseTickets =
            purchasesControllers.map((e) => e.text).toList();
        List<int> visitFrequency = frequencyList.map((e) => e!.id!).toList();
        List<String> requestedAmount =
            amountControllers.map((e) => e.text).toList();
        List fieData = fieList.map((e) => e.fieUniqueId).toList();
        List img = files
            .map((e) => dio.MultipartFile.fromBytes(e.bytes!, filename: e.name))
            .toList();

        FormData formData = FormData.fromMap({
          "wholesaler[]": wholesaler,
          "currency[]": currency,
          "monthly_purchase[]": monthlyPurchase,
          "average_purchase_tickets[]": averagePurchaseTickets,
          "visit_frequency[]": visitFrequency,
          "requested_amount[]": requestedAmount,
          "fie[]": fieData,
          "commercial_name_one": crn1Controller.text,
          "commercial_phone_one": crp1Controller.text,
          "commercial_name_two": crn2Controller.text,
          "commercial_phone_two": crp2Controller.text,
          "commercial_name_three": crn3Controller.text,
          "commercial_phone_three": crp3Controller.text,
          "send_cl": selectedOption.toString(),
          "selectedfie": selectedOption == 1 ? "" : selectedFie!.fieUniqueId!,
          "auth_check": '1',
          "documents": img
        });

        final response = await dio.Dio().post(NetworkUrls.addCreditlineRequests,
            data: formData, options: Options(headers: _webService.headers));
        ResponseMessages body = ResponseMessages.fromJson((response.data));

        if (response.statusCode == 500) {
          _navigationService.animatedDialog(
              AlertDialogMessage(AppLocalizations.of(context)!.serverError));
          makeButtonBusy(false);
        } else if (!body.success!) {
          makeButtonBusy(false);
          _navigationService.animatedDialog(AlertDialogMessage(body.message!));
        } else {
          await _repositoryRetailer.getCreditLinesList();
          Utils.toast(AppLocalizations.of(context)!.dataStoredMessage);
          context.goNamed(Routes.creditLineRequestWebView,
              pathParameters: {"page": "1"});
          makeButtonBusy(false);
        }
      } else {
        makeButtonBusy(false);
        notifyListeners();
      }
    } on Exception catch (_) {
      makeButtonBusy(false);
    }
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.creditLineRequestWebView,
        pathParameters: {'page': "1"});
  }

// void openTerm(String s, String termTitle) {
//   int termNumber = termConditions.indexWhere((element) =>
//   element.termsConditionFor!.toLowerCase() == s.toLowerCase());
//   _navigationService.push(MaterialPageRoute(
//       builder: (c) => TermScreenView(
//           id: termTitle,
//           des: termConditions[termNumber].termsCondition!,
//           isRetailer: true)));
// }
}
