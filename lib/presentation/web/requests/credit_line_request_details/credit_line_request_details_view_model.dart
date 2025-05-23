import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;
import 'package:bingo/presentation/web/requests/credit_line_request_details/widgets/open_image.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/app_secrets.dart';
import '../../../../const/app_colors.dart';
import '../../../../const/special_key.dart';
import '../../../../const/utils.dart';
import '../../../../data/data_source/visit_frequently_list.dart';
import '../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/retailer_creditline_request_details_model/retailer_creditline_request_details_model.dart';
import '../../../../data_models/models/wholesaler_credit_line_model/wholesaler_credit_line_model.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../widgets/alert/date_picker.dart';
import 'widgets/alert_dialog.dart';

class CreditLineRequestDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();
  final NavigationService _nav = locator<NavigationService>();

  String get tabNumber => _webBasicService.tabNumber.value;

  UserTypeForWeb get enrollment => _authService.enrollment.value;

  ScrollController scrollController = ScrollController();

  TextEditingController customerSinceController = TextEditingController();
  TextEditingController monthlySaleController = TextEditingController();
  TextEditingController averageSaleTicketController = TextEditingController();
  TextEditingController rcCreditLineAmountController = TextEditingController();

  TextEditingController monthlyPurchaseController = TextEditingController();
  TextEditingController averagePurchaseController = TextEditingController();
  TextEditingController requestedAmountController = TextEditingController();

  TextEditingController wholesalerNameController = TextEditingController();
  TextEditingController fieController = TextEditingController();
  TextEditingController dateRequestedController = TextEditingController();

  TextEditingController crn1Controller = TextEditingController();
  TextEditingController crn2Controller = TextEditingController();
  TextEditingController crn3Controller = TextEditingController();
  TextEditingController crp1Controller = TextEditingController();
  TextEditingController crp2Controller = TextEditingController();
  TextEditingController crp3Controller = TextEditingController();

  List<String> currencyList = [];
  List<VisitFrequentListModel> visitFrequentlyList = [];
  String? selectedCurrency;
  VisitFrequentListModel? selectedVisitFrequently;

  bool isButtonBusy = false;
  bool isEdit = false;
  RetailerCreditLineReqDetailsModel retailerCreditLineReqDetails =
      RetailerCreditLineReqDetailsModel();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.creditLineRequestWebView,
        pathParameters: {"page": "1"});
  }

  prefill(String? id, String? data) {
    if (enrollment == UserTypeForWeb.wholesaler) {
      prefillWholesaler(data);
    } else if (enrollment == UserTypeForWeb.retailer) {
      prefillRetailer(id);
    } else {}
  }

  prefillRetailer(id) async {
    setBusy(true);
    notifyListeners();
    await _retailer.getCreditLinesDetails(id);
    retailerCreditLineReqDetails = _retailer.retailerCreditLineReqDetails.value;

    monthlyPurchaseController.text =
        retailerCreditLineReqDetails.data!.monthlyPurchase!;
    averagePurchaseController.text =
        retailerCreditLineReqDetails.data!.averagePurchaseTickets!;
    requestedAmountController.text =
        retailerCreditLineReqDetails.data!.requestedAmount!;
    wholesalerNameController.text =
        retailerCreditLineReqDetails.data!.wholesalerName!;
    fieController.text = retailerCreditLineReqDetails.data!.fieName!;
    dateRequestedController.text =
        retailerCreditLineReqDetails.data!.dateRequested!;

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
    currencyList.add(retailerCreditLineReqDetails.data!.currency!);
    selectedCurrency = currencyList.first;
    visitFrequentlyList = AppList.visitFrequentlyList;
    selectedVisitFrequently = visitFrequentlyList.firstWhere((element) =>
        element.id == retailerCreditLineReqDetails.data!.visitFrequency);
    setBusy(false);
    notifyListeners();
  }

  prefillWholesaler(String? data) {
    String b = data!.replaceAll("()", "/").replaceAll(")(", "+");
    var bb = Utils.encrypter.decrypt64(b, iv: SpecialKeys.iv);
    WholesalerCreditLineData p =
        WholesalerCreditLineData.fromJson(jsonDecode(bb));
    currencyList.add(p.currency!);
    selectedCurrency = currencyList.first;
    visitFrequentlyList = AppList.visitFrequentlyList;
    selectedVisitFrequently = visitFrequentlyList
        .firstWhere((element) => element.id == p.visitFrequency);
    customerSinceController.text = p.customerSinceDate!;
    monthlySaleController.text = p.monthlySales!;
    averageSaleTicketController.text = p.averageSalesTicket!;
    rcCreditLineAmountController.text = p.rcCrlineAmt!;
    monthlyPurchaseController.text = p.monthlyPurchase!;
    averagePurchaseController.text = p.averagePurchaseTickets!;
    requestedAmountController.text = p.requestedAmount!;
    notifyListeners();
  }

  void openImage(String img) {
    html.window.open(img, 'new tab');
  }

  void openQuestion(
      String question, String answer, List<SupportedDocuments> docList) {
    _nav.animatedDialog(QuestionAnswerCreditline(
      question: question,
      answer: answer,
      docList: docList,
    ));
  }

  void openCalender() async {
    customerSinceController.text = (DateFormat(SpecialKeys.dateDDMMYYYY)
            .format(await _navigationService.animatedDialog(DatePicker())))
        .toString();
    notifyListeners();
  }
}
