import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/presentation/widgets/alert/confirmation_dialog.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../../const/special_key.dart';
import '../../../../../data/data_source/product_list.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/order_details/order_details.dart'
    as c;
import '../../../../../data_models/models/order_details_wholesaler/order_details_wholesaler.dart';
import '../../../../../data_models/models/order_selection_model/order_selection_model.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../data_models/models/user_model/user_model.dart';
import '../../../../../data_models/models/wholesaler_for_order_model/wholesaler_for_order_model.dart';
import '../../../../../main.dart';
import '../../../../../repository/order_repository.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../widgets/alert/date_picker.dart';
import '../../../../widgets/alert/order_module/over_amount_reconfirm_order.dart';

class OrderDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();
  final NavigationService _navigationService = locator<NavigationService>();

  String get tabNumber => _webBasicService.tabNumber.value;
  // bool isEdit = true;
  ScrollController scrollController = ScrollController();
  TextEditingController orderDesController = TextEditingController();
  TextEditingController creditLineController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();

  TextEditingController retailerNameController = TextEditingController();
  TextEditingController wholesalerNameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController dateOfTransactionController = TextEditingController();
  TextEditingController bingoIdController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController taxReceiptController = TextEditingController();
  TextEditingController paymentMethodeController = TextEditingController();

  // TextEditingController paymentController = TextEditingController();
  FocusNode promoFocus = FocusNode();
  DeliveryMethod? selectedDeliveryMethod;
  PaymentMethod? selectedPaymentMethod;
  String promoErrorMessage = "";
  String orderNumberErrorMessage = "";
  String deliveryDateErrorMessage = "";
  Stores? selectedStore;
  WholesalerForOrderData? selectedWholesaler;
  List<Stores> get storeList => _authService.user.value.data!.stores!;
  UserModel get user => _authService.user.value;
  List<WholesalerForOrderData> wholesaler = [];
  List<OrderModel> orderModel = [];
  List<DeliveryMethod> deliveryMethods = [];
  OrderSelectionModel? orderSelectionData;
  OrderDetailWholesaler? orderDetailWholesaler;
  OrderDetails? orderDetails;
  SkuData? selectedSkuData;
  List<SkuData> skuData = [];
  List<SkuData> sortedSkuData = [];
  int totalItemCount = 0;
  String errorDeliveryMethod = "";
  String errorPaymentMethod = "";
  String errorTermSelection = "";
  String orderDesError = "";
  String productEmptyError = "";
  String termAcceptedError = "";
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  bool isPromoLoading = false;
  bool submitBusy = false;
  int viewType = 0;
  int orderType = 0;
  Future<void> prefill(String? type, String? w, String? s, String? ot,
      String? u, String? orderId) async {
    if (enrollment == UserTypeForWeb.retailer) {
      setBusy(true);
      notifyListeners();
      await callWholesalerListForOrder();
      if (w != null) {
        if (enrollment == UserTypeForWeb.retailer) {
          selectedWholesaler =
              wholesaler.firstWhere((element) => element.uniqueId == w);
        }
        selectedStore =
            storeList.firstWhere((element) => element.uniqueId == s);

        await callOrderSelection(w: w);
      }
      if (w != null) {
        if (type!.toLowerCase() == "edit") {
          viewType = 1;
        } else if (type.toLowerCase() == "view") {
          viewType = 2;
        }
        if (ot == '0' || ot == '1') {
          orderType = int.parse(ot ?? '0');
          draftPreloading(orderType, u!);
        } else {
          c.OrderDetail? orderDetails = await _repositoryOrder.getDetails(u!);
          for (int i = 0;
              i < orderDetails!.data!.orderDetails![0].orderLogs!.length;
              i++) {
            c.OrderLogs d = orderDetails.data!.orderDetails![0].orderLogs![i];
            addProductToCart(OrderLogs(
                uniqueId: d.uniqueId!,
                productId: d.productId!,
                sku: d.sku!,
                productDescription: d.productDescription!,
                unitPrice: d.unitPrice!.toDouble(),
                currency: d.currency!,
                qty: d.qty!,
                unit: d.unit,
                tax: d.tax,
                amount: d.amount,
                country: d.country!));
          }

          deliveryDateController.text =
              orderDetails.data!.orderDetails![0].deliveryDate!;

          selectedDeliveryMethod = orderSelectionData!.data!.deliveryMethod!
              .firstWhere(
                  (element) =>
                      element.uniqueId ==
                      (orderDetails.data!.orderDetails![0].deliveryMethodId!),
                  orElse: () => DeliveryMethod());
          selectedPaymentMethod = orderSelectionData!.data!.paymentMethod!
              .firstWhere(
                  (element) =>
                      element.uniqueId ==
                      (orderDetails.data!.orderDetails![0].paymentMethodId),
                  orElse: () => PaymentMethod());
          creditLineController.text =
              "${statusForCreditline(orderSelectionData!.data!.creditline!.statusDescription!)} | ${orderDetails.data!.orderDetails![0].creditlineCurrency} ${orderDetails.data!.orderDetails![0].creditlineAvailableAmount!}";
          dateOfTransactionController.text =
              orderDetails.data!.orderDetails![0].dateOfTransaction!;
          // draftPreloading(orderType, u);
        }
      } else {
        viewType = 0;
      }
      totalItemCount = getTotals();

      setBusy(false);
      notifyListeners();
    } else {
      setBusy(true);
      notifyListeners();
      var body = {"unique_id": orderId};
      orderDetailWholesaler = await _repositoryOrder.callOrderDetailer(body);
      orderDetails = orderDetailWholesaler!.data!.orderDetails![0];
      skuData = orderDetailWholesaler!.data!.orderDetails![0].skuData!;
      if (type!.toLowerCase() == "edit") {
        viewType = 1;
      } else if (type.toLowerCase() == "view") {
        viewType = 2;
      }
      // final orderDetails = this.orderDetails;
      if (orderDetails != null) {
        print('orderDetails');
        print(jsonEncode(orderDetails));
        retailerNameController.text = orderDetails!.retailerName!;
        wholesalerNameController.text = orderDetails!.wholesalerName!;
        storeNameController.text = orderDetails!.storeName!;
        dateOfTransactionController.text = orderDetails!.dateOfTransaction!;
        bingoIdController.text = orderDetails!.bingoOrderId!;
        orderNumberController.text = orderDetails!.orderNumber!;
        invoiceNumberController.text = orderDetails!.invoiceNumber!;
        taxReceiptController.text = orderDetails!.taxReceiptNumber!;
        orderDesController.text = orderDetails!.orderDescription!;
        paymentMethodeController.text = orderDetails!.paymentMethodName!;
        paymentMethodeController.text = orderDetails!.paymentMethodName!;
        deliveryMethods = orderDetails!.deliveryMethods!;
        deliveryDateController.text = orderDetails!.deliveryDate!;
        creditLineController.text =
            "${statusForCreditline(orderDetails!.creditlineStatusDescription!)} | ${orderDetails!.creditlineCurrency} ${orderDetails!.creditlineAvailableAmount!}";
        selectedDeliveryMethod = deliveryMethods.firstWhereOrNull(
            (e) => e.uniqueId == orderDetails!.deliveryMethod);
      } else {}

      for (int i = 0; i < orderDetails!.orderLogs!.length; i++) {
        OrderLogs d = orderDetails!.orderLogs![i];
        addProductToCart(OrderLogs(
            uniqueId: d.uniqueId!,
            productId: d.productId!,
            sku: d.sku!,
            productDescription: d.productDescription!,
            unitPrice: d.unitPrice!.toDouble(),
            currency: d.currency!,
            qty: d.qty!,
            unit: d.unit,
            tax: d.tax,
            amount: d.amount,
            country: d.country!));
      }
      totalItemCount = getTotals();
      setBusy(false);
      notifyListeners();
    }
  }

  void openCalender() async {
    deliveryDateController.text = ((DateFormat(SpecialKeys.dateFormat).format(
            await _navigationService
                    .animatedDialog(DatePicker(cancelEmpty: true)) ??
                "")))
        .toString();
    notifyListeners();
  }

  void draftPreloading(int orderType, String u) {
    if (orderType == 0) {
      orderDesController.text =
          orderSelectionData!.data!.drafts![0].orderDescription!;
      addProductToCart(orderSelectionData!.data!.drafts![0].orderLogs![0]);
    } else {
      orderDesController.text =
          orderSelectionData!.data!.templates![0].orderDescription!;
      int indexOfTemplate = orderSelectionData!.data!.templates!
          .indexWhere((element) => element.uniqueId == u);
      for (int i = 0;
          i <
              orderSelectionData!
                  .data!.templates![indexOfTemplate].orderLogs!.length;
          i++) {
        addProductToCart(orderSelectionData!
            .data!.templates![indexOfTemplate].orderLogs![i]);
      }
    }

    dateOfTransactionController.text =
        orderSelectionData!.data!.drafts![0].dateOfTransaction!;
    deliveryDateController.text = orderType == 0
        ? orderSelectionData!.data!.drafts![0].deliveryDate!
        : orderSelectionData!.data!.templates![0].deliveryDate!;
    selectedDeliveryMethod = orderSelectionData!.data!.deliveryMethod!
        .firstWhere(
            (element) =>
                element.uniqueId ==
                (orderType == 0
                    ? orderSelectionData!.data!.drafts![0].deliveryMethod
                    : orderSelectionData!.data!.templates![0].deliveryMethod),
            orElse: () => DeliveryMethod());
    selectedPaymentMethod = orderSelectionData!.data!.paymentMethod!.firstWhere(
        (element) =>
            element.uniqueId ==
            (orderType == 0
                ? orderSelectionData!.data!.drafts![0].paymentMethod
                : orderSelectionData!.data!.templates![0].paymentMethod),
        orElse: () => PaymentMethod());
    creditLineController.text =
        "${statusForCreditline(orderSelectionData!.data!.creditline!.statusDescription!)} | ${orderSelectionData!.data!.creditline!.currency!} ${orderSelectionData!.data!.spcreditline!.creditlineAvailableAmount!}";
  }

  void addProductToCart(OrderLogs orderLogs) {
    double up = orderLogs.unitPrice ?? 0.0;
    double t = orderLogs.tax ?? 0.0;
    double q = double.parse((orderLogs.qty ?? 0).toString());
    double total = (up * q);
    double tax = t * q;
    selectedProductList.add({
      'sku': TextEditingController(text: orderLogs.sku!),
      'productId': TextEditingController(text: orderLogs.productId!),
      'des': TextEditingController(text: orderLogs.productDescription!),
      'price':
          TextEditingController(text: orderLogs.unitPrice!.toStringAsFixed(2)),
      'currency': TextEditingController(text: orderLogs.currency!),
      'amount': TextEditingController(text: orderLogs.qty.toString()),
      'unit': TextEditingController(text: orderLogs.unit!),
      'tax': TextEditingController(text: t.toString()),
      'accTax': TextEditingController(text: tax.toStringAsFixed(2)),
      'total': TextEditingController(text: total.toStringAsFixed(2))
    });
  }

  List<Map<String, TextEditingController>> selectedProductList = [];

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  TextEditingController skuDataController = TextEditingController();

  selectProduct(SkuData value, String sku) {
    int index = selectedProductList.indexWhere((e) => sku == e['sku']!.text);
    if (selectedProductList.where((e) => sku == e['sku']!.text).isNotEmpty) {
      int count = int.parse(selectedProductList[index]['amount']!.text);

      if (count < 1) {
        double total = 0.0;
        selectedProductList[index]['total']!.text = total.toString();
        selectedProductList[index]['amount']!.text = "0";
        notifyListeners();
      } else {
        selectedProductList[index]['amount']!.text = (count + 1).toString();
        double up = double.parse(selectedProductList[index]['price']!.text);
        double t = double.parse(selectedProductList[index]['tax']!.text);
        double q = double.parse((count + 1).toString());
        double total = (up * q);
        selectedProductList[index]['total']!.text = total.toString();
        selectedProductList[index]['accTax']!.text = (t * q).toString();
        selectedProductList[index]['amount']!.text = (count + 1).toString();
        notifyListeners();
      }
    } else {
      double up = double.parse(value.unitPrice!.toString());
      double t = value.tax!;
      double total = (up);
      selectedProductList.add({
        'sku': TextEditingController(text: value.sku!),
        'productId': TextEditingController(text: value.productId!),
        'des': TextEditingController(text: value.productDescription!),
        'price': TextEditingController(text: value.unitPrice!.toString()),
        'currency': TextEditingController(text: value.currency!),
        'amount': TextEditingController(text: "1"),
        'unit': TextEditingController(text: value.unit!),
        'tax': TextEditingController(text: value.tax!.toString()),
        'accTax': TextEditingController(text: value.tax!.toString()),
        'total': TextEditingController(text: total.toString())
      });
    }
    totalItemCount = getTotals();
    notifyListeners();
  }

  int selectedTerms = 0;
  bool isTermAccepted = false;
  changeSelectedTerms(int v) {
    selectedTerms = v;
    notifyListeners();
  }

  selectTerms() {
    isTermAccepted = !isTermAccepted;
    notifyListeners();
  }

  Future changeStore(Stores v) async {
    if (selectedWholesaler == null) {
      selectedStore = v;
      notifyListeners();
      if (selectedWholesaler != null) {
        await callOrderSelection();
      }
      notifyListeners();
    } else if (selectedStore!.uniqueId == v.uniqueId) {
      if (selectedWholesaler != null) {
        await callOrderSelection(isRequireToChange: false);
      }
    } else {
      selectedStore = v;
      notifyListeners();
      if (selectedWholesaler != null) {
        await callOrderSelection();
      }
    }
  }

  Future changeWholesaler(WholesalerForOrderData v) async {
    Utils.fPrint('jsonEncode(v)');
    Utils.fPrint(jsonEncode(v));
    if (selectedWholesaler == null) {
      selectedWholesaler = v;
      Utils.fPrint(v.toString());
      Utils.fPrint(v.toString());
      await callOrderSelection();
      notifyListeners();
    } else if (selectedWholesaler!.uniqueId == v.uniqueId) {
      await callOrderSelection(isRequireToChange: false);
      notifyListeners();
    } else {
      selectedWholesaler = v;
      Utils.fPrint(v.toString());
      Utils.fPrint(v.toString());
      await callOrderSelection();
      notifyListeners();
    }
  }

  Future callWholesalerListForOrder() async {
    setBusyForObject(wholesaler, true);
    notifyListeners();
    await _repositoryOrder.callWholesalerListForOrder();
    wholesaler = _repositoryOrder.wholesalerForOrderData.value;

    // dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    setBusyForObject(wholesaler, false);
    notifyListeners();
  }

  Future callOrderSelection({bool isRequireToChange = true, String? w}) async {
    setBusyForObject(orderSelectionData, true);
    notifyListeners();
    var body = selectedStore == null
        ? {
            "wholesaler_id": selectedWholesaler!.uniqueId,
          }
        : {
            "wholesaler_id": selectedWholesaler!.uniqueId,
            "store_id": selectedStore!.uniqueId,
          };
    if (isRequireToChange) {
      selectedProductList.clear();
    }
    setBusy(true);
    notifyListeners();
    await _repositoryOrder.callOrderInfo(body);
    orderSelectionData = _repositoryOrder.orderSelectionModel.value;
    deliveryMethods = orderSelectionData!.data!.deliveryMethod!;

    if (orderSelectionData!.data!.id.toString() != "0") {
      if (w == null) {
        bool isDraftLoading =
            await _navigationService.displayDialog(ConfirmationDialog(
                  title: "Load Draft",
                  content:
                      AppLocalizations.of(activeContext)!.draftOrderDialogBody,
                )) ??
                false;
        if (isDraftLoading) {
          draftPreloading(0, orderSelectionData!.data!.drafts![0].uniqueId!);
        }
      } else {
        // draftPreloading();
      }
    }
    setBusy(false);
    notifyListeners();

    skuData = orderSelectionData!.data!.skuData!;
    skuData.map((e) => sortedSkuData.add(e));
    setBusyForObject(orderSelectionData, false);
    notifyListeners();
  }

  void changeDeliveryMethod(DeliveryMethod v) {
    selectedDeliveryMethod = v;
    if (selectedDeliveryMethod == null) {
      errorDeliveryMethod =
          AppLocalizations.of(activeContext)!.deliveryMethodeRequirement;
    } else {
      errorDeliveryMethod = "";
    }
    notifyListeners();
  }

  void changePaymentMethod(PaymentMethod v) {
    selectedPaymentMethod = v;
    creditLineController.text =
        "${statusForCreditline(orderSelectionData!.data!.creditline!.statusDescription!)} | ${orderSelectionData!.data!.creditline!.currency!} ${orderSelectionData!.data!.spcreditline!.creditlineAvailableAmount!}";
    if (selectedPaymentMethod == null) {
      errorPaymentMethod =
          AppLocalizations.of(activeContext)!.paymentMethodeRequirement;
    } else {
      errorPaymentMethod = "";
    }
    notifyListeners();
  }

  void changeTotal(String v, int i) {
    if (v.isEmpty) {
      selectedProductList.removeAt(i);
    } else {
      double up = double.parse(selectedProductList[i]['price']!.text);
      double t = double.parse(selectedProductList[i]['tax']!.text);
      double q = double.parse(v);
      double total = (up * q);
      double tax = t * q;

      selectedProductList[i]['total']!.text = total.toStringAsFixed(2);
      selectedProductList[i]['tax']!.text = t.toStringAsFixed(2);
      selectedProductList[i]['accTax']!.text = tax.toStringAsFixed(2);
      notifyListeners();
    }
    notifyListeners();
    totalItemCount = selectedProductList.fold<int>(0, (v, e) {
      Utils.fPrint(e['amount'].toString());
      return v += int.parse(e['amount']!.text.toString());
    });
    notifyListeners();
  }

  int getTotals() {
    return selectedProductList.fold<int>(0, (v, e) {
      return v += int.parse(e['amount']!.text.toString());
    });
  }

  String statusForCreditline(String statusDescription) {
    if (_authService.user.value.data!.languageCode!.toLowerCase() == 'en') {
      return statusDescription;
    } else {
      switch (statusDescription.toLowerCase()) {
        case "pending wholesaler review":
          return "Pendiente Revisión \nde Mayorista";
        case "pending fie forward":
          return "Pendiente de Enviar \na Institución";
        case "fie queue":
          return "En cola de la Institución";
        case "association pending / fie queue":
          return "Asociación Pendiente/En \ncola de la Institución";
        case "on evaluation/association pending":
          return "En Evaluación/\nAsociación Pendiente";
        case "on evaluation":
          return "En Evaluación";
        case "rejected":
          return "Rechazada";
        case "waiting reply/association pending":
          return "Esperando Respuesta/\nAsociación Pendiente";
        case "waiting reply":
          return "Esperando Respuesta";
        case "association pending/recommended":
          return "Asociación Pendiente/\nRecomendada";
        case "recommended":
          return "Recomendada";
        case "formalized":
          return "Formalizada";
        case "approved":
          return "Aprobada";
        case "active":
          return "Activa";
        case "inactive":
          return "Inactiva";
      }
      return "";
    }
  }

  double getSubTotal() {
    return selectedProductList.fold<double>(0.0, (currentValue, cartItem) {
      Utils.fPrint("cartItem['amount']!.text");
      Utils.fPrint(cartItem['amount']!.text);
      if (int.parse(cartItem['amount']!.text) > 0) {
        return currentValue +=
            (double.parse(cartItem['amount']!.text.toString())) *
                double.parse(cartItem['price']!.text);
      } else {
        return 0.00;
      }
    });
  }

  double getTotalTax() {
    return selectedProductList.fold<double>(0.0, (currentValue, cartItem) {
      return currentValue += (double.parse(cartItem['accTax']!.text));
      // 50*7.5/100;
    });
  }

  double getTotal() {
    return getSubTotal() + getTotalTax();
  }

  double getGrandTotal() {
    if (selectedDeliveryMethod == null ||
        selectedDeliveryMethod!.shippingAndHandlingCost == null) {
      return getTotal();
    } else {
      return getTotal() + selectedDeliveryMethod!.shippingAndHandlingCost!;
    }
  }

  Future applyPromoCode() async {
    if (promoCodeController.text.isNotEmpty) {
      isPromoLoading = true;
      promoErrorMessage = "";
      notifyListeners();
      var body = {
        SpecialKeys.bpIdW: selectedWholesaler!.uniqueId!,
        SpecialKeys.promoCode: promoCodeController.text
      };
      bool response = await _repositoryOrder.applyPromoCode(body);
      ResponseMessageModel applyPromoCodeReplyMessage =
          _repositoryOrder.applyPromoCodeReplyMessage.value;
      Utils.toast(applyPromoCodeReplyMessage.message!,
          isSuccess: applyPromoCodeReplyMessage.success!);
      isPromoLoading = false;
      if (!response) {
        promoCodeController.clear();
      }
      notifyListeners();
    } else {
      promoErrorMessage = AppLocalizations.of(activeContext)!.selectPromoCode;
      _repositoryOrder.clearPromoCode();
      notifyListeners();
    }
  }

  Future<void> deleteItem(int i) async {
    bool confirmation = await _navigationService.animatedDialog(const SizedBox(
      width: 200,
      child: ConfirmationDialog(
          ifYesNo: true, title: "Do you really want to delete this item?"),
    ));
    if (confirmation) {
      selectedProductList.removeAt(i);
      totalItemCount = getTotals();
      notifyListeners();
    }
  }

  int creditLineAvailability = 0;
  int isDraftForSend = 3;
  Future sendCreateOrderRequest(int orderType, BuildContext context) async {
    if (selectedDeliveryMethod == null) {
      errorDeliveryMethod =
          AppLocalizations.of(activeContext)!.deliveryMethodeRequirement;
    } else {
      errorDeliveryMethod = "";
    }
    if (selectedPaymentMethod == null) {
      errorPaymentMethod =
          AppLocalizations.of(activeContext)!.paymentMethodeRequirement;
    } else {
      errorPaymentMethod = "";
    }
    if (!isTermAccepted) {
      errorTermSelection = AppLocalizations.of(activeContext)!.needToAcceptTerm;
    } else {
      errorTermSelection = "";
    }
    if (orderDesController.text.isEmpty) {
      orderDesError =
          AppLocalizations.of(activeContext)!.orderDescriptionEmptyMessage;
    } else {
      orderDesError = "";
    }

    if (totalItemCount < 1) {
      productEmptyError =
          AppLocalizations.of(activeContext)!.needToSelectProduct;
    } else {
      productEmptyError = "";
    }
    if (!isTermAccepted) {
      termAcceptedError = AppLocalizations.of(activeContext)!.needToAcceptTerm;
    } else {
      termAcceptedError = "";
    }
    notifyListeners();
    if (selectedDeliveryMethod != null &&
        selectedPaymentMethod != null &&
        orderDesController.text.isNotEmpty &&
        isTermAccepted) {
      setBusyForObject(submitBusy, true);
      notifyListeners();
      List productList = [];
      for (int i = 0; i < selectedProductList.length; i++) {
        productList.add({
          SpecialKeys.productId: selectedProductList[i]['productId']!.text,
          SpecialKeys.productDescription: selectedProductList[i]['des']!.text,
          SpecialKeys.unitPrice:
              selectedProductList[i]['price']!.text.toString(),
          SpecialKeys.currency: selectedProductList[i]['currency']!.text,
          SpecialKeys.qty: selectedProductList[i]['amount']!.text,
          SpecialKeys.unit: selectedProductList[i]['unit']!.text,
          SpecialKeys.tax: selectedProductList[i]['accTax']!.text,
          SpecialKeys.amount: selectedProductList[i]['total']!.text
        });
      }
      // 'sku': TextEditingController(text: value.sku!),
      // 'productId': TextEditingController(text: value.productId!),
      // 'des': TextEditingController(text: value.productDescription!),
      // 'price': TextEditingController(text: value.unitPrice!.toString()),
      // 'currency': TextEditingController(text: value.currency!),
      // 'amount': TextEditingController(text: "1"),
      // 'unit': TextEditingController(text: value.unit!),
      // 'tax': TextEditingController(text: value.tax!.toString()),
      // 'total': TextEditingController(text: total.toString())
      Utils.fPrint('productList');
      Utils.fPrint(productList.toString());
      var body = {
        SpecialKeys.bpIdW: selectedWholesaler!.uniqueId ?? "",
        SpecialKeys.storeId: selectedStore!.uniqueId ?? "",
        SpecialKeys.clId: orderSelectionData!.data!.creditline!.uniqueId,
        SpecialKeys.orderDescription: orderDesController.text,
        SpecialKeys.productDetails: jsonEncode(productList),
        SpecialKeys.promoCode: promoCodeController.text,
        SpecialKeys.dateOfTransaction:
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
        SpecialKeys.itemsQty: getTotals().toString(),
        SpecialKeys.subTotal: getSubTotal().toString(),
        SpecialKeys.taxSum: getTotalTax().toString(),
        SpecialKeys.total: getTotal().toString(),
        SpecialKeys.deliveryMethod: selectedDeliveryMethod!.uniqueId,
        SpecialKeys.shippingCost:
            selectedDeliveryMethod!.shippingAndHandlingCost.toString(),
        SpecialKeys.grandTotal: getGrandTotal().toString(),
        SpecialKeys.paymentMethod: selectedPaymentMethod!.uniqueId.toString(),
        SpecialKeys.clAvailability: creditLineAvailability.toString(),
        SpecialKeys.orderType: orderType.toString()
      };
      Utils.fPrint('productList');
      Utils.fPrint(body.toString());
      if (isDraftForSend == 0) {
        body.addAll({
          SpecialKeys.orderId: orderSelectionData!.data!.drafts![0].uniqueId
        });
      }

      try {
        ResponseMessageModel responseData =
            await _repositoryOrder.createOrderWeb(body);
        if (responseData.success!) {
          setBusyForObject(submitBusy, false);
          notifyListeners();

          selectedProductList.clear();
          promoFocus.requestFocus();

          Utils.toast(responseData.message!);
          if (context.mounted) {
            context
                .goNamed(Routes.orderListView, pathParameters: {"page": "1"});
          }
        } else {
          setBusyForObject(submitBusy, false);
          notifyListeners();
          if (responseData.data == SpecialKeys.amountIsBigger) {
            creditLineAvailability = await _navigationService
                    .displayDialog(OverAmountReconfirmOrder()) ??
                5;
            if (creditLineAvailability == 1) {
              creditLineAvailability = 0;
              notifyListeners();
            } else if (creditLineAvailability == 5) {
            } else {
              if (context.mounted) {
                await sendCreateOrderRequest(orderType, context);
              }
            }
          } else {
            Utils.toast(responseData.message!);
          }
        }
      } on Exception catch (_) {
        setBusyForObject(submitBusy, false);
        notifyListeners();
      }
    }
  }

  Future<void> update(BuildContext context) async {
    if (orderNumberController.text.isNotEmpty &&
        deliveryDateController.text.isNotEmpty) {
      List productList = [];
      for (int i = 0; i < selectedProductList.length; i++) {
        productList.add({
          SpecialKeys.productId: selectedProductList[i]['productId']!.text,
          SpecialKeys.productDescription: selectedProductList[i]['des']!.text,
          SpecialKeys.unitPrice:
              selectedProductList[i]['price']!.text.toString(),
          SpecialKeys.currency: selectedProductList[i]['currency']!.text,
          SpecialKeys.qty: selectedProductList[i]['amount']!.text,
          SpecialKeys.unit: selectedProductList[i]['unit']!.text,
          SpecialKeys.tax: selectedProductList[i]['accTax']!.text,
          SpecialKeys.amount: selectedProductList[i]['total']!.text
        });
      }
      Map<String, dynamic> body = {
        "bingo_order_id": orderDetails!.bingoOrderId!,
        "cl_id": orderDetails!.clId!,
        "order_number": orderNumberController.text,
        "invoice_number": invoiceNumberController.text,
        "tax_receipt_number": orderDetails!.taxReceiptNumber!,
        "order_description": orderDetails!.orderDescription!,
        "product_details": jsonEncode(productList),
        "date_of_transaction": orderDetails!.dateOfTransaction!,
        SpecialKeys.itemsQty: getTotals().toString(),
        SpecialKeys.subTotal: getSubTotal().toString(),
        SpecialKeys.taxSum: getTotalTax().toString(),
        SpecialKeys.total: getTotal().toString(),
        "delivery_method": selectedDeliveryMethod!.uniqueId!,
        "delivery_date": deliveryDateController.text,
        "shipping_cost":
            selectedDeliveryMethod!.shippingAndHandlingCost.toString(),
        "grand_total": getGrandTotal().toString(),
        "payment_method": orderDetails!.paymentMethod!.toString()
      };
      Utils.fPrint('deliveryDateController.text');
      Utils.fPrint(deliveryDateController.text);
      setBusyForObject(submitBusy, true);
      notifyListeners();
      ResponseMessageModel responseMessageModel =
          await _repositoryOrder.updateOrderWebWholesaler(body);

      if (responseMessageModel.success!) {
        if (context.mounted) {
          context.goNamed(Routes.orderListView, pathParameters: {"page": "1"});
        }
      } else {
        Utils.toast(responseMessageModel.message!);
      }
      setBusyForObject(submitBusy, false);
      notifyListeners();
    } else {
      if (orderNumberController.text.isEmpty) {
        orderNumberErrorMessage = "Need to put order number";
      } else {
        orderNumberErrorMessage = "";
      }
      if (deliveryDateController.text.isEmpty) {
        deliveryDateErrorMessage = "Need to select delivery date";
      } else {
        deliveryDateErrorMessage = "";
      }
      notifyListeners();
    }
  }
}
