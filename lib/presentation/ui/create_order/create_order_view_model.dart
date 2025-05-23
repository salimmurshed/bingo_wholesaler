import 'dart:convert';

import '../../../data_models/enums/user_roles_files.dart';
import '/data/data_source/product_list.dart';
import '/repository/order_repository.dart';
import '/repository/repository_retailer.dart';
import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/locator.dart';
import '../../../const/special_key.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/order_selection_model/order_selection_model.dart';
import '../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../data_models/models/term_condition_model/term_condition_model.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../data_models/models/wholesaler_for_order_model/wholesaler_for_order_model.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../widgets/alert/open_details_webview.dart';
import '../../widgets/alert/order_module/order_draft_alert_dialog.dart';
import '../../widgets/alert/order_module/over_amount_reconfirm_order.dart';
import '../../widgets/cards/product_in_sheet.dart';

class CreateOrderViewModel extends ReactiveViewModel {
  CreateOrderViewModel() {
    callWholesalerListForOrder();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryOrder, _repositoryRetailer];
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();
  final AuthService _authService = locator<AuthService>();

  TextEditingController searchController = TextEditingController();

  OrderSelectionModel orderSelectionData = OrderSelectionModel();

  // _repositoryOrder.orderSelectionModel.value;

  List<Promotions> get promotionalImages => _repositoryOrder.promotionalImages;

  List<Stores> get storeList => _authService.user.value.data!.stores!;

  UserModel get user => _authService.user.value;
  List<WholesalerForOrderData> wholesaler = [];
  Stores? selectedStore;
  WholesalerForOrderData? selectedWholesaler;

  List<OrderModel> orderList = [];
  List<OrderModel> searchedOrderList = [];
  String orderDesError = "";
  String productEmptyError = "";

  Templates? selectedTemplates;
  Drafts? selectedDrafts;
  TextEditingController orderDesController = TextEditingController();

  List<TermConditionData> get termConditions => _authService.termConditions;

  String get wholeSaler => _repositoryOrder.orderInfo['wholesaler_id']!;

  ResponseMessageModel get applyPromoCodeReplyMessage =>
      _repositoryOrder.applyPromoCodeReplyMessage.value;

  bool isTermAccepted = false;
  TextEditingController creditLineController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  FocusNode promoFocus = FocusNode();
  DeliveryMethod? selectedDeliveryMethod;
  PaymentMethod? selectedPaymentMethod;
  String promoErrorMessage = "";

  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  // bool get isUserAdminRole {
  //   return userRoles.contains(UserRoles.admin) ||
  //       userRoles.contains(UserRoles.master);
  // }

  refreshScreen() {
    notifyListeners();
  }

  callWholesalerListForOrder() async {
    setBusyForObject(wholesaler, true);
    notifyListeners();
    await _repositoryOrder.callWholesalerListForOrder();
    wholesaler = _repositoryOrder.wholesalerForOrderData.value;
    setBusyForObject(wholesaler, false);
    notifyListeners();
  }

  clearOrderSelection() {
    searchController.clear();
    selectedTemplates = null;
    selectedDeliveryMethod = null;
    selectedPaymentMethod = null;
    _repositoryOrder.clearOrderSelection();
    setBusy(false);
    notifyListeners();
    // await Future.delayed(Duration.zero);
    // return true;
  }

  Future changeStore(Stores v) async {
    selectedStore = v;
    notifyListeners();
    if (selectedWholesaler != null) {
      await callOrderSelection();
    }
  }

  Future<void> changeWholesaler(WholesalerForOrderData v) async {
    selectedWholesaler = v;
    notifyListeners();
    await callOrderSelection();
  }

  Future<void> callOrderSelection({bool isFromList = false}) async {
    _repositoryOrder.clearPromoCode();
    print(orderSelectionData.data);
    var body = selectedStore == null
        ? {
            "wholesaler_id": selectedWholesaler!.uniqueId,
          }
        : {
            "wholesaler_id": selectedWholesaler!.uniqueId,
            "store_id": selectedStore!.uniqueId,
          };
    orderList.clear();
    searchedOrderList.clear();
    setBusy(true);
    notifyListeners();

    if (orderSelectionData.data == null) {
      orderSelectionData = OrderSelectionModel();
      await _repositoryOrder.callOrderInfo(body).then((value) async {
        orderSelectionData = _repositoryOrder.orderSelectionModel.value;
        if (orderSelectionData.data!.skuData!.isNotEmpty) {
          for (SkuData data in orderSelectionData.data!.skuData!) {
            OrderModel order = OrderModel(
                productId: data.productId,
                sku: data.sku,
                productDescription: data.productDescription,
                unitPrice: data.unitPrice,
                currency: data.currency,
                unit: data.unit,
                tax: data.tax,
                productImage: data.productImage,
                qty: 0);
            orderList.add(order);
          }
          searchedOrderList = orderList;
        }
        if (orderSelectionData.data!.id.toString() != "0") {
          if (!isFromList) {
            bool isDraftLoading = await _navigationService
                    .displayDialog(const OrderDraftAlertDialog()) ??
                false;
            if (isDraftLoading) {
              draftPreloading();
            }
          } else {
            draftPreloading();
          }
        }
      });
      setBusy(false);
      notifyListeners();
    } else {
      if (orderSelectionData.data!.wholesalerId !=
              selectedWholesaler!.uniqueId ||
          orderSelectionData.data!.storeId != selectedStore!.uniqueId) {
        orderSelectionData = OrderSelectionModel();
        await _repositoryOrder.callOrderInfo(body).then((value) async {
          orderSelectionData = _repositoryOrder.orderSelectionModel.value;
          if (orderSelectionData.data!.skuData!.isNotEmpty) {
            for (SkuData data in orderSelectionData.data!.skuData!) {
              OrderModel order = OrderModel(
                  productId: data.productId,
                  sku: data.sku,
                  productDescription: data.productDescription,
                  unitPrice: data.unitPrice,
                  currency: data.currency,
                  unit: data.unit,
                  tax: data.tax,
                  productImage: data.productImage,
                  qty: 0);
              orderList.add(order);
            }
            searchedOrderList = orderList;
          }
          if (orderSelectionData.data!.id.toString() != "0") {
            bool isDraftLoading = await _navigationService
                    .displayDialog(const OrderDraftAlertDialog()) ??
                false;
            if (isDraftLoading) {
              draftPreloading();
            }
          }
        });
      }
      setBusy(false);
      notifyListeners();
    }

    setBusy(false);
    notifyListeners();
  }

  // callOrderInfo() async {
  //   if (selectedWholesaler != null && selectedStore != null) {
  //     if (orderSelectionData.data == null) {
  //       await callOrderSelection();
  //     } else {
  //       if (orderSelectionData.data!.wholesalerId !=
  //               selectedWholesaler!.uniqueId ||
  //           orderSelectionData.data!.storeId != selectedStore!.uniqueId) {
  //         await callOrderSelection();
  //       }
  //     }
  //   }
  // }

  // formatter.format(d)model.formatter.format

  void draftPreloading() {
    searchController.clear();
    isDraftForSend = 0;
    OrderModel? product;
    for (int i = 0;
        i < orderSelectionData.data!.drafts![0].orderLogs!.length;
        i++) {
      print(orderSelectionData.data!.drafts![0].orderLogs!.length);
      product = OrderModel(
        productId: orderSelectionData.data!.drafts![0].orderLogs![i].productId,
        sku: orderSelectionData.data!.drafts![0].orderLogs![i].sku,
        productDescription: orderSelectionData
            .data!.drafts![0].orderLogs![i].productDescription,
        unitPrice: orderSelectionData.data!.drafts![0].orderLogs![i].unitPrice,
        currency: orderSelectionData.data!.drafts![0].orderLogs![i].currency,
        unit: orderSelectionData.data!.drafts![0].orderLogs![i].unit,
        tax: orderSelectionData.data!.drafts![0].orderLogs![i].tax,
        productImage: orderSelectionData
            .data!.drafts![0].orderLogs![i].productDescription,
        qty: orderSelectionData.data!.drafts![0].orderLogs![i].qty,
      );

      addProductToCart(product);
    }
    searchedOrderList = orderList;

    orderDesController.text =
        orderSelectionData.data!.drafts![0].orderDescription!;
    selectedDeliveryMethod = orderSelectionData.data!.deliveryMethod!
        .firstWhere(
            (element) =>
                element.uniqueId ==
                orderSelectionData.data!.drafts![0].deliveryMethod,
            orElse: () => DeliveryMethod());
    selectedPaymentMethod = orderSelectionData.data!.paymentMethod!.firstWhere(
        (element) =>
            element.uniqueId ==
            orderSelectionData.data!.drafts![0].paymentMethod,
        orElse: () => PaymentMethod());
    creditLineController.text =
        "${statusForCreditline()} | ${orderSelectionData.data!.creditline!.currency!} ${orderSelectionData.data!.spcreditline!.creditlineAvailableAmount!}";

    orderScreenNumber = 1;
    notifyListeners();
    // _navigationService.pushNamed(Routes.createOrderSelectProductView);
  }

  void templatePreloading(int j) {
    searchController.clear();
    OrderModel? product;
    for (int i = 0; i < orderList.length; i++) {
      orderList[i].qty = 0;
    }
    for (int i = 0;
        i < orderSelectionData.data!.templates![j].orderLogs!.length;
        i++) {
      product = OrderModel(
        productId:
            orderSelectionData.data!.templates![j].orderLogs![i].productId,
        sku: orderSelectionData.data!.templates![j].orderLogs![i].sku,
        productDescription: orderSelectionData
            .data!.templates![j].orderLogs![i].productDescription,
        unitPrice:
            orderSelectionData.data!.templates![j].orderLogs![i].unitPrice,
        currency: orderSelectionData.data!.templates![j].orderLogs![i].currency,
        unit: orderSelectionData.data!.templates![j].orderLogs![i].unit,
        tax: orderSelectionData.data!.templates![j].orderLogs![i].tax,
        productImage: orderSelectionData
            .data!.templates![j].orderLogs![i].productDescription,
        qty: orderSelectionData.data!.templates![j].orderLogs![i].qty,
      );

      addProductToCart(product);
    }

    searchedOrderList = orderList;
    orderDesController.text =
        orderSelectionData.data!.templates![j].orderDescription!;
    selectedDeliveryMethod = orderSelectionData.data!.deliveryMethod!
        .firstWhere(
            (element) =>
                element.uniqueId ==
                orderSelectionData.data!.templates![j].deliveryMethod,
            orElse: () => DeliveryMethod());
    selectedPaymentMethod = orderSelectionData.data!.paymentMethod!.firstWhere(
        (element) =>
            element.uniqueId ==
            orderSelectionData.data!.templates![j].paymentMethod,
        orElse: () => PaymentMethod());
    creditLineController.text =
        "${statusForCreditline()} | ${orderSelectionData.data!.creditline!.currency!} ${orderSelectionData.data!.spcreditline!.creditlineAvailableAmount!}";

    orderScreenNumber = 1;
    notifyListeners();
    // _navigationService.pushNamed(Routes.createOrderSelectProductView);
  }

  void onChangedTab(context, int index) {
    print(index);
    _repositoryComponents.onChangedTab(context, index);
  }

  int orderScreenNumber = 0;

  void goNextScreen(v) {
    if (orderScreenNumber == 1) {
      if (orderDesController.text.isEmpty) {
        orderDesError =
            AppLocalizations.of(activeContext)!.orderDescriptionEmptyMessage;
      } else {
        orderDesError = "";
      }
      print(getTotalItemNumber());
      if (getTotalItemNumber() < 1) {
        productEmptyError =
            AppLocalizations.of(activeContext)!.needToSelectProduct;
      } else {
        productEmptyError = "";
      }
      if (orderDesController.text.isNotEmpty && getTotalItemNumber() > 0) {
        orderScreenNumber = 2;
        promoErrorMessage = "";
      } else {
        orderScreenNumber = 1;
      }
    } else {
      orderScreenNumber = v;
    }

    notifyListeners();
  }

  void backScreen(BuildContext context) {
    // if (isEdit) {
    //   _navigationService.pop();
    // } else {
    if (orderScreenNumber == 0) {
      if (isEdit) {
        _navigationService.pop();
      } else {
        _repositoryComponents.onChangedTab1(context);
        notifyListeners();
      }
    } else {
      orderScreenNumber -= 1;
      notifyListeners();
    }
    // }
  }

  /////new////

  void changeTemplates(Templates v) {
    selectedTemplates = v;
    notifyListeners();
  }

  Future<void> openProductSheet() async {
    final selectedProduct = await _navigationService
        .displayBottomSheet(ProductInSheet(orderSelectionData.data!.skuData!));
    if (selectedProduct != null) {
      OrderModel order = OrderModel(
          productId: selectedProduct.productId,
          sku: selectedProduct.sku,
          productDescription: selectedProduct.productDescription,
          unitPrice: selectedProduct.unitPrice,
          currency: selectedProduct.currency,
          unit: selectedProduct.unit,
          tax: selectedProduct.tax,
          productImage: selectedProduct.productImage,
          qty: 1);
      addProductToCart(order);
    }
  }

  void addProductToCart(OrderModel order) {
    addProduct(order);
  }

  void addProduct(OrderModel item) {
    int index = orderList.indexWhere((e) => e.productId == item.productId);
    if (index < 0) {
      orderList.add(item);
      notifyListeners();
    } else {
      orderList[index].qty = (orderList[index].qty! + item.qty!);
      print(orderList[index].qty);
      notifyListeners();

      notifyListeners();
    }
  }

  void addingProductToCart(OrderModel orderList) {
    OrderModel order = OrderModel(
        productId: orderList.productId,
        sku: orderList.sku,
        productDescription: orderList.productDescription,
        unitPrice: orderList.unitPrice,
        currency: orderList.currency,
        unit: orderList.unit,
        tax: orderList.tax,
        productImage: orderList.productImage,
        qty: 1);
    addProduct(order);
  }

  void deductProductFromCart(OrderModel orderItem) {
    OrderModel order = OrderModel(
        productId: orderItem.productId,
        sku: orderItem.sku,
        productDescription: orderItem.productDescription,
        unitPrice: orderItem.unitPrice,
        currency: orderItem.currency,
        unit: orderItem.unit,
        tax: orderItem.tax,
        productImage: orderItem.productImage,
        qty: 1);
    int index = orderList.indexWhere((e) => e.productId == order.productId);

    if (index >= 0) {
      if (orderList[index].qty! > 0) {
        orderList[index].qty = orderList[index].qty! - order.qty!;
        notifyListeners();
      }
    }
  }

  int getTotalItemNumber() {
    return orderList.fold<int>(0, (currentValue, cartItem) {
      return currentValue += cartItem.qty!;
    });
  }

  void gotoFinalOrderScreen() {
    if (orderDesController.text.isEmpty) {
      orderDesError =
          AppLocalizations.of(activeContext)!.orderSDescriptionRequirement;
    } else {
      orderDesError = "";
      // _navigationService.pushNamed(Routes.createOrderFinalView,
      //     arguments: orderDesController.text);
      orderScreenNumber = 2;
      notifyListeners();
    }
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
        "${statusForCreditline()} | ${orderSelectionData.data!.creditline!.currency!} ${orderSelectionData.data!.spcreditline!.creditlineAvailableAmount!}";
    if (selectedPaymentMethod == null) {
      errorPaymentMethod =
          AppLocalizations.of(activeContext)!.paymentMethodeRequirement;
    } else {
      errorPaymentMethod = "";
    }
    notifyListeners();
  }

  void changeTermRadioButton() {
    isTermAccepted = !isTermAccepted;
    if (!isTermAccepted) {
      errorTermSelection = AppLocalizations.of(activeContext)!.needToAcceptTerm;
    } else {
      errorTermSelection = "";
    }
    notifyListeners();
  }

  searchProduct(String v) {
    // if (v.isEmpty) {
    //   orderList = searchedOrderList;
    // }
    searchedOrderList = orderList
        .where((element) =>
            element.productDescription!.toLowerCase().contains(v.toLowerCase()))
        .toList();
    notifyListeners();
  }

  double getSubTotal() {
    // if (v == 0.0) {
    return orderList.fold<double>(0.0, (currentValue, cartItem) {
      return currentValue += cartItem.qty! * cartItem.unitPrice!;
    });
    // } else {
    //   return v;
    // }
  }

  double getTotalTax() {
    return orderList.fold<double>(0.0, (currentValue, cartItem) {
      return currentValue += cartItem.qty!.toDouble() * cartItem.tax!;
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

  void openTerm(int i, String s) {
    print(termConditions[i].termsCondition!);
    _navigationService.animatedDialog(OpenDetailsWebView(
      id: "Term and Condition $s",
      des: termConditions[i].termsCondition!,
    ));
  }

  bool isPromoLoading = false;

  Future applyPromoCode() async {
    if (promoCodeController.text.isNotEmpty) {
      isPromoLoading = true;
      promoErrorMessage = "";
      notifyListeners();
      var body = {
        SpecialKeys.bpIdW: wholeSaler,
        SpecialKeys.promoCode: promoCodeController.text
      };
      await _repositoryOrder.applyPromoCode(body);
      isPromoLoading = false;
      notifyListeners();
    } else {
      promoErrorMessage = AppLocalizations.of(activeContext)!.selectPromoCode;
      _repositoryOrder.clearPromoCode();
      notifyListeners();
    }
  }

  String errorDeliveryMethod = "";
  String errorPaymentMethod = "";
  String errorTermSelection = "";
  int creditLineAvailability = 0;

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
    notifyListeners();
    if (selectedDeliveryMethod != null &&
        selectedPaymentMethod != null &&
        isTermAccepted) {
      setBusy(true);
      notifyListeners();
      List productList = [];
      for (int i = 0; i < orderList.length; i++) {
        productList.add({
          SpecialKeys.productId: orderList[i].productId,
          SpecialKeys.productDescription: orderList[i].productDescription,
          SpecialKeys.unitPrice: orderList[i].unitPrice.toString(),
          SpecialKeys.currency: orderList[i].currency,
          SpecialKeys.qty: orderList[i].qty.toString(),
          SpecialKeys.unit: orderList[i].unit.toString(),
          SpecialKeys.tax: orderList[i].tax.toString(),
          SpecialKeys.amount:
              (orderList[i].qty! * orderList[i].unitPrice!).toString()
        });
      }
      var body = {
        SpecialKeys.bpIdW: _repositoryOrder.orderInfo['wholesaler_id'] ?? "",
        SpecialKeys.storeId: _repositoryOrder.orderInfo['store_id'] ?? "",
        SpecialKeys.clId: orderSelectionData.data!.creditline!.uniqueId,
        SpecialKeys.orderDescription: orderDesController.text,
        SpecialKeys.productDetails: jsonEncode(productList),
        SpecialKeys.promoCode: promoCodeController.text,
        SpecialKeys.dateOfTransaction:
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
        SpecialKeys.itemsQty: getTotalItemNumber().toString(),
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
      if (isDraftForSend == 0) {
        body.addAll({
          SpecialKeys.orderId: orderSelectionData.data!.drafts![0].uniqueId
        });
      }

      try {
        ResponseMessageModel responseData =
            await _repositoryOrder.createOrder(body);
        if (responseData.success!) {
          setBusy(false);
          notifyListeners();
          if (isEdit) {
            _navigationService.pop();
          } else {
            orderScreenNumber = 1;
            if (context.mounted) {
              _repositoryComponents.setBottomTabBarTOrder(context);
            }
          }

          orderList.clear();
          promoFocus.requestFocus();
          if (context.mounted) {
            _repositoryComponents.onChangedTab(context, 1);
          }
          _repositoryComponents.setSalesTabIndex(0);
          Utils.toast(responseData.message!);
        } else {
          setBusy(false);
          notifyListeners();
          if (responseData.data == SpecialKeys.amountIsBigger) {
            creditLineAvailability = await _navigationService
                    .displayDialog(OverAmountReconfirmOrder()) ??
                5;
            if (creditLineAvailability == 1) {
              orderScreenNumber = 1;
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
        setBusy(false);
        notifyListeners();
      }
    }
  }

  bool isEdit = false;

  int isDraftForSend = 3;
  bool isFromList = false;

  Future<void> setDetails(Map arguments) async {
    print('argumentsarguments');
    print(arguments);
    setBusy(true);
    wholesaler = _repositoryOrder.wholesalerForOrderData.value;
    isFromList = true;
    if (arguments["type"] == 0 || arguments["type"] == 1) {
      isEdit = true;
      orderList.clear();
      print('selectedWholesaler');
      print(selectedWholesaler);
      print(selectedWholesaler!.uniqueId!);
      print(arguments["wholesaler_id"]);
      selectedWholesaler = wholesaler.firstWhere(
          (element) => element.uniqueId == arguments["wholesaler_id"]);
      selectedStore = storeList
          .firstWhere((element) => element.uniqueId == arguments["store_id"]);
      await callOrderSelection(isFromList: isFromList);
      if (arguments["type"] == 0) {
        // draftPreloading();
      } else {
        int i = 1;
        i = orderSelectionData.data!.templates!
            .indexWhere((e) => e.uniqueId == arguments['id']);
        templatePreloading(i);
      }
      setBusy(false);
      notifyListeners();
    } else {
      setBusy(false);
      notifyListeners();
      _navigationService.pop();
    }
  }

  String statusForCreditline() {
    print(
        orderSelectionData.data!.creditline!.statusDescription!.toLowerCase());
    if (user.data!.languageCode!.toLowerCase() == 'en') {
      return orderSelectionData.data!.creditline!.statusDescription!;
    } else {
      switch (orderSelectionData.data!.creditline!.statusDescription!
          .toLowerCase()) {
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
}
