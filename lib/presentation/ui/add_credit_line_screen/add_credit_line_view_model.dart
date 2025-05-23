import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '/app/locator.dart';
import '/app/router.dart';
import '/data_models/models/retailer_creditline_request_details_model/retailer_creditline_request_details_model.dart';
import '/presentation/widgets/alert/alert_dialog.dart';
import '/repository/repository_retailer.dart';
import '/services/navigation/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../const/database_helper.dart';
import '../../../data_models/construction_model/reply_model.dart';
import '../../../data_models/construction_model/wholesaler_data.dart';
import '../../../data_models/models/component_models/fie_list_creditline_request_model.dart';
import '../../../data_models/models/component_models/partner_with_currency_list.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../data_models/models/term_condition_model/term_condition_model.dart';
import '../../../repository/repository_components.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/local_data/table_names.dart';
import '../../widgets/alert/image_viewer.dart';
import '../../widgets/alert/pdf_viewer.dart';
import '../term_screen/term_screen_view.dart';

class AddCreditLineViewModel extends ReactiveViewModel {
  AddCreditLineViewModel() {
    getAllFieListForCreditLine();
    multipleSearch();
    // getWholesalerWithCurrenct();
    if (allWholesalers.data == null) {
      getWholesalerWithCurrenct();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryRetailer, _repositoryComponents];

  //services
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final dbHelper = DatabaseHelper.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  //services get variables
  List<TermConditionData> get termConditions => _authService.termConditions;

  List<WholesalerData> get sortedWholsaler =>
      _repositoryRetailer.sortedWholsaler.value;

  List<WholesalersData> get creditLineInformation =>
      _repositoryRetailer.creditLineInformation.value;

  PartnerWithCurrencyList get allWholesalers =>
      _repositoryComponents.wholesalerWithCurrency.value;

  //view credit line full data base
  RetailerCreditLineReqDetailsModel get retailerCreditLineReqDetails =>
      _repositoryRetailer.retailerCreditLineReqDetails.value;

  String get language => _authService.selectedLanguageCode;

  //local variables
  bool acceptTermCondition = false;
  bool isView = false;
  bool isButtonBusy = false;

  List<File> files = [];
  List<ReplyModel> replyData = [];
  List<FieCreditLineRequestData> listFie = [];
  List<bool> isAnswerButtonBusy = [];

  List<TextEditingController> _controller = [];

  List<TextEditingController> get answerController => _controller;
  List<FieCreditLineRequestData> _allFieCreditLine = [];

  List<FieCreditLineRequestData> get allFieCreditLine => _allFieCreditLine;
  // List<FieQuestionAnswer> _listOfQuestion = [
  //   FieQuestionAnswer(questionId: "1", question: "abc", answer: "efg"),
  //   FieQuestionAnswer(questionId: "1", question: "abc", answer: "efg")
  // ];

  // List<FieQuestionAnswer> get listOfQuestion => _listOfQuestion;
  List<SupportedDocuments> _fileList = [];

  List<SupportedDocuments> get fileList => _fileList;

  String creditLineInformationErrorMessage = "";
  String crn1ErrorMessage = "";
  String crp1ErrorMessage = "";
  String selectedOptionErrorMessage = "";
  String acceptTermConditionErrorMessage = "";
  String fileListErrorMessage = "";
  String filesErrorMessage = "";

  FieCreditLineRequestData? selectedFie;

  String filter = "";

  int selectedOption = 10;

  TextEditingController crn1Controller = TextEditingController();
  TextEditingController crn2Controller = TextEditingController();
  TextEditingController crn3Controller = TextEditingController();
  TextEditingController crp1Controller = TextEditingController();
  TextEditingController crp2Controller = TextEditingController();
  TextEditingController crp3Controller = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  void viewImage(String img) {
    print(img);
    _navigationService.animatedDialog(ImageViewer(
      image: img,
      isFile: false,
    ));
  }

  viewPdf(String pdf) {
    _navigationService.animatedDialog(PdfViewer(
      pdf: pdf,
      isFile: false,
    ));
  }

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void makeAnswerButtonBusy(bool v, int i) {
    isAnswerButtonBusy[i] = v;
    notifyListeners();
  }

  Future getWholesalerWithCurrenct() async {
    setBusy(true);
    notifyListeners();
    print('call api');
    await _repositoryComponents.getWholesalerWithCurrency();

    setBusy(false);
    notifyListeners();
  }

  void multipleSearch() {
    searchTextController.addListener(() {
      print(searchTextController.text);
      filter = searchTextController.text;
      notifyListeners();
    });
  }

  void pickFiles() async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png']);
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }

  void pickFilesForAnswer(int i) async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png']);
    if (result != null) {
      replyData[i].documents = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }

  void addFieList(List<FieCreditLineRequestData> item) {
    // print(item.fieUniqueId);
    // if (listFie.any((e) => e.fieUniqueId == item.fieUniqueId)) {
    //   listFie.remove(item);
    //   _allFieCreditLine.add(item);
    //   _allFieCreditLine.sort((a, b) => a.bpName!.compareTo(b.bpName!));
    // } else {
    //   listFie.add(item);
    //   _allFieCreditLine.remove(item);
    // }
    // print(listFie);
    listFie = item;
    notifyListeners();
  }

  void changeAcceptTermCondition() {
    acceptTermCondition = !acceptTermCondition;
    notifyListeners();
  }

  void changeSingleFie(v) {
    selectedFie = v;
    notifyListeners();
  }

  void changeSelectedOption(int v) {
    selectedOption = v;
    print("v $v");
    notifyListeners();
  }

  void getAllFieListForCreditLine() {
    dbHelper.queryAllRows(TableNames.fieFistForCreditlineRequest).then((value) {
      _allFieCreditLine =
          value.map((d) => FieCreditLineRequestData.fromJson(d)).toList();
      notifyListeners();
    });
  }

  Future<void> gotoAddWholesalerScreen() async {
    bool? getData =
        await _navigationService.pushNamed(Routes.addWholesalerView);
    if (getData != null || getData == true) {
      creditLineInformationErrorMessage = "";
      notifyListeners();
    }
  }

  void gotoUpdateWholesalerScreen(int index) {
    WholesalersData data = WholesalersData(
        id: creditLineInformation[index].id,
        wholesaler: creditLineInformation[index].wholesaler,
        currency: creditLineInformation[index].currency,
        monthlyPurchase: creditLineInformation[index].monthlyPurchase,
        averageTicket: creditLineInformation[index].averageTicket,
        visitFrequency: creditLineInformation[index].visitFrequency,
        amount: creditLineInformation[index].amount);
    _navigationService.pushNamed(Routes.addWholesalerView, arguments: data);
  }

  void cancel(context) {
    _navigationService.pop();
  }

  Future<void> addCreditLine(context) async {
    makeButtonBusy(true);
    SnackBar snackBar;
    if (creditLineInformation.isEmpty) {
      creditLineInformationErrorMessage =
          (AppLocalizations.of(context)!.needToSelectOneWholesaler);
    } else {
      creditLineInformationErrorMessage = "";
    }
    if (selectedOption == 10) {
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
    print(_allFieCreditLine.length);
    // if (listFie.isEmpty) {
    //   fileListErrorMessage = (AppLocalizations.of(context)!.needToSelectFie);
    // } else {
    //   fileListErrorMessage = "";
    // }
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
    try {
      if (creditLineInformation.isNotEmpty &&
          acceptTermCondition &&
          // listFie.isNotEmpty &&
          crn1Controller.text.isNotEmpty &&
          crp1Controller.text.isNotEmpty &&
          (selectedOption == 0 || selectedOption == 1) &&
          files.isNotEmpty) {
        List<String> wholesaler = creditLineInformation
            .map((e) => e.wholesaler!.associationUniqueId!)
            .toList();
        List<String> currency =
            creditLineInformation.map((e) => e.currency!).toList();
        List<String> monthlyPurchase =
            creditLineInformation.map((e) => e.monthlyPurchase!).toList();
        List<String> averagePurchaseTickets =
            creditLineInformation.map((e) => e.averageTicket!).toList();
        List<int> visitFrequency =
            creditLineInformation.map((e) => e.visitFrequency!.id!).toList();
        List<String> requestedAmount =
            creditLineInformation.map((e) => e.amount!).toList();
        List fieData = listFie.map((e) => e.fieUniqueId).toList();

        MultipartRequest request = _repositoryRetailer.requestPostResponse();

        for (int i = 0; i < wholesaler.length; i++) {
          request.fields["wholesaler[$i]"] = wholesaler[i];
        }
        for (int i = 0; i < currency.length; i++) {
          request.fields["currency[$i]"] = currency[i];
        }
        for (int i = 0; i < monthlyPurchase.length; i++) {
          request.fields["monthly_purchase[$i]"] = monthlyPurchase[i];
        }
        for (int i = 0; i < averagePurchaseTickets.length; i++) {
          request.fields["average_purchase_tickets[$i]"] =
              averagePurchaseTickets[i];
        }
        for (int i = 0; i < visitFrequency.length; i++) {
          request.fields["visit_frequency[$i]"] = visitFrequency[i].toString();
        }
        for (int i = 0; i < requestedAmount.length; i++) {
          request.fields["requested_amount[$i]"] = requestedAmount[i];
        }
        for (int i = 0; i < fieData.length; i++) {
          request.fields["fie[$i]"] = fieData[i];
        }
        request.fields["commercial_name_one"] = crn1Controller.text;
        request.fields["commercial_phone_one"] = crp1Controller.text;
        request.fields["commercial_name_two"] = crn2Controller.text;
        request.fields["commercial_phone_two"] = crp2Controller.text;
        request.fields["commercial_name_three"] = crn3Controller.text;
        request.fields["commercial_phone_three"] = crp3Controller.text;
        request.fields["send_cl"] = selectedOption.toString();
        request.fields["selectedfie"] =
            selectedOption == 1 ? "" : selectedFie!.fieUniqueId!;
        request.fields["auth_check"] = '1';
        print("auth_check");
        log(jsonEncode(request.fields));
        Response response =
            await _repositoryRetailer.addCreditlineRequests(request, files);
        ResponseMessages body =
            ResponseMessages.fromJson(jsonDecode(response.body));

        if (response.statusCode == 500) {
          _navigationService.animatedDialog(
              AlertDialogMessage(AppLocalizations.of(context)!.serverError));
          makeButtonBusy(false);
        } else if (!body.success!) {
          makeButtonBusy(false);
          _navigationService.animatedDialog(AlertDialogMessage(body.message!));
        } else {
          await _repositoryRetailer.getCreditLinesList();
          snackBar = SnackBar(
            content: Text(AppLocalizations.of(context)!.dataStoredMessage),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _navigationService.pop();
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

  void openTerm(String s, String termTitle) {
    int termNumber = termConditions.indexWhere((element) =>
        element.termsConditionFor!.toLowerCase() == s.toLowerCase());
    _navigationService.push(MaterialPageRoute(
        builder: (c) => TermScreenView(
            id: termTitle,
            des: termConditions[termNumber].termsCondition!,
            isRetailer: true)));
  }

  void setDetails(String arguments) async {
    print(arguments);
    int numberOfAnswer = 0;
    setBusy(true);
    notifyListeners();
    isView = true;
    await _repositoryRetailer.getCreditLinesDetails(arguments);
    // _retailerCreditLineReqDetails =
    //     _repositoryRetailer.retailerCreditLineReqDetails.value;
    crn1Controller.text = retailerCreditLineReqDetails.data!.commercialNameOne!;
    crn2Controller.text = retailerCreditLineReqDetails.data!.commercialNameTwo!;
    crn3Controller.text =
        retailerCreditLineReqDetails.data!.commercialNameThree!;
    crp1Controller.text =
        retailerCreditLineReqDetails.data!.commercialPhoneOne!;
    crp2Controller.text =
        retailerCreditLineReqDetails.data!.commercialPhoneTwo!;
    crp3Controller.text =
        retailerCreditLineReqDetails.data!.commercialPhoneThree!;
    // _listOfQuestion = retailerCreditLineReqDetails.data!.fieQuestionAnswer!;
    // retailerCreditLineReqDetails.data!.fieQuestionAnswer = [
    //   FieQuestionAnswer(
    //       questionId: "1",
    //       question:
    //           "abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc ",
    //       answer:
    //           "efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg efg "),
    //   FieQuestionAnswer(
    //       questionId: "2",
    //       question:
    //           "abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc abc ",
    //       answer: "")
    // ];
    numberOfAnswer =
        retailerCreditLineReqDetails.data!.fieQuestionAnswer!.length;
    _controller = List.generate(
        numberOfAnswer,
        (i) => TextEditingController(
            text: retailerCreditLineReqDetails
                .data!.fieQuestionAnswer![i].answer));
    _fileList = retailerCreditLineReqDetails.data!.supportedDocuments!;
    if (retailerCreditLineReqDetails.data!.fieQuestionAnswer!.isNotEmpty) {
      for (FieQuestionAnswer answer
          in retailerCreditLineReqDetails.data!.fieQuestionAnswer!) {
        ReplyModel data = ReplyModel(
          creditLineId: retailerCreditLineReqDetails.data!.creditlineUniqueId!,
          questionId: answer.questionId!,
          reply: "",
          documents: [],
        );
        replyData.add(data);
        print(data.questionId);
        isAnswerButtonBusy.add(false);
      }
    }
    setBusy(false);
    notifyListeners();
  }

  void submitAnswers(int i, context) async {
    if (answerController[i].text.isNotEmpty) {
      makeAnswerButtonBusy(true, i);
      await Future.delayed(const Duration(seconds: 2));
      MultipartRequest request = _repositoryRetailer.requestReplyResponse();
      request.fields["reply"] = answerController[i].text;
      request.fields["question_id"] = replyData[i].questionId!;
      request.fields["creditline_unique_id"] =
          retailerCreditLineReqDetails.data!.creditlineUniqueId!;
      await _repositoryRetailer.addReplyRequests(
          request, replyData[i].documents!);
      makeAnswerButtonBusy(false, i);
    } else {
      makeAnswerButtonBusy(false, i);
      var snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.emptyFieldMessage),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
