import '../order_selection_model/order_selection_model.dart';

class OrderDetailWholesaler {
  bool? success;
  String? message;
  Data? data;

  OrderDetailWholesaler({this.success, this.message, this.data});

  OrderDetailWholesaler.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<OrderDetails>? orderDetails;
  List<List>? twoStepSales;

  Data({this.orderDetails, this.twoStepSales});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    if (json['two_step_sales'] != null) {
      twoStepSales = <List>[];
      json['two_step_sales'].forEach((v) {
        twoStepSales!.add([]);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    if (twoStepSales != null) {
      data['two_step_sales'] = [];
    }
    return data;
  }
}

class OrderDetails {
  String? bingoOrderId;
  String? bpIdR;
  String? retailerName;
  String? bpIdW;
  String? wholesalerName;
  String? clId;
  String? storeId;
  String? storeName;
  String? orderNumber;
  String? invoiceNumber;
  String? taxReceiptNumber;
  String? orderDescription;
  String? dateOfTransaction;
  String? promocode;
  int? itemsQty;
  int? subTotal;
  double? totalTax;
  double? total;
  String? deliveryDate;
  String? deliveryMethod;
  String? deliveryMethodId;
  int? shippingCost;
  double? grandTotal;
  int? paymentMethod;
  String? paymentMethodName;
  String? country;
  int? status;
  String? statusDescription;
  int? orderType;
  String? orderTypeDescription;
  int? isClIncrease;
  String? creditlineCurrency;
  int? creditlineStatus;
  String? creditlineStatusDescription;
  double? creditlineAvailableAmount;
  List<OrderLogs>? orderLogs;
  List<SkuData>? skuData;
  List<DeliveryMethod>? deliveryMethods;

  OrderDetails(
      {this.bingoOrderId,
      this.bpIdR,
      this.retailerName,
      this.bpIdW,
      this.wholesalerName,
      this.clId,
      this.storeId,
      this.storeName,
      this.orderNumber,
      this.invoiceNumber,
      this.taxReceiptNumber,
      this.orderDescription,
      this.dateOfTransaction,
      this.promocode,
      this.itemsQty,
      this.subTotal,
      this.totalTax,
      this.total,
      this.deliveryDate,
      this.deliveryMethod,
      this.deliveryMethodId,
      this.shippingCost,
      this.grandTotal,
      this.paymentMethod,
      this.paymentMethodName,
      this.country,
      this.status,
      this.statusDescription,
      this.orderType,
      this.orderTypeDescription,
      this.isClIncrease,
      this.creditlineCurrency,
      this.creditlineStatus,
      this.creditlineStatusDescription,
      this.creditlineAvailableAmount,
      this.orderLogs,
      this.skuData,
      this.deliveryMethods});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    bingoOrderId = json['bingo_order_id'] ?? '';
    bpIdR = json['bp_id_r'] ?? '';
    retailerName = json['retailer_name'] ?? '';
    bpIdW = json['bp_id_w'] ?? '';
    wholesalerName = json['wholesaler_name'] ?? '';
    clId = json['cl_id'] ?? '';
    storeId = json['store_id'] ?? '';
    storeName = json['store_name'] ?? '';
    orderNumber = json['order_number'] ?? '';
    invoiceNumber = json['invoice_number'] ?? '';
    taxReceiptNumber = json['tax_receipt_number'] ?? '';
    orderDescription = json['order_description'] ?? '';
    dateOfTransaction = json['date_of_transaction'] ?? '';
    promocode = json['promocode'] ?? '';
    itemsQty = json['items_qty'] ?? 0;
    subTotal = json['sub_total'] ?? 0;
    totalTax = json['total_tax'] ?? 0.0;
    total = json['total'] ?? 0.0;
    deliveryDate = json['delivery_date'] ?? '';
    deliveryMethod = json['delivery_method'] ?? '';
    deliveryMethodId = json['delivery_method_id'] ?? '';
    shippingCost = json['shipping_cost'] ?? 0;
    grandTotal = json['grand_total'] ?? 0.0;
    paymentMethod = json['payment_method'] ?? 0;
    paymentMethodName = json['payment_method_name'] ?? '';
    country = json['country'] ?? '';
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? '';
    orderType = json['order_type'] ?? 0;
    orderTypeDescription = json['order_type_description'] ?? '';
    isClIncrease = json['is_cl_increase'] ?? 0;
    creditlineCurrency = json['creditline_currency'] ?? '';
    creditlineStatus = json['creditline_status'] ?? 0;
    creditlineStatusDescription = json['creditline_status_description'] ?? '';
    creditlineAvailableAmount = json['creditline_available_amount'] ?? 0.0;
    if (json['order_logs'] != null) {
      orderLogs = <OrderLogs>[];
      json['order_logs'].forEach((v) {
        orderLogs!.add(OrderLogs.fromJson(v));
      });
    }
    if (json['sku_data'] != null) {
      skuData = <SkuData>[];
      json['sku_data'].forEach((v) {
        skuData!.add(SkuData.fromJson(v));
      });
    }
    if (json['delivery_methods'] != null) {
      deliveryMethods = <DeliveryMethod>[];
      json['delivery_methods'].forEach((v) {
        deliveryMethods!.add(DeliveryMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bingo_order_id'] = bingoOrderId;
    data['bp_id_r'] = bpIdR;
    data['retailer_name'] = retailerName;
    data['bp_id_w'] = bpIdW;
    data['wholesaler_name'] = wholesalerName;
    data['cl_id'] = clId;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['order_number'] = orderNumber;
    data['invoice_number'] = invoiceNumber;
    data['tax_receipt_number'] = taxReceiptNumber;
    data['order_description'] = orderDescription;
    data['date_of_transaction'] = dateOfTransaction;
    data['promocode'] = promocode;
    data['items_qty'] = itemsQty;
    data['sub_total'] = subTotal;
    data['total_tax'] = totalTax;
    data['total'] = total;
    data['delivery_date'] = deliveryDate;
    data['delivery_method'] = deliveryMethod;
    data['delivery_method_id'] = deliveryMethodId;
    data['shipping_cost'] = shippingCost;
    data['grand_total'] = grandTotal;
    data['payment_method'] = paymentMethod;
    data['payment_method_name'] = paymentMethodName;
    data['country'] = country;
    data['status'] = status;
    data['status_description'] = statusDescription;
    data['order_type'] = orderType;
    data['order_type_description'] = orderTypeDescription;
    data['is_cl_increase'] = isClIncrease;
    data['creditline_currency'] = creditlineCurrency;
    data['creditline_status'] = creditlineStatus;
    data['creditline_status_description'] = creditlineStatusDescription;
    data['creditline_available_amount'] = creditlineAvailableAmount;
    if (orderLogs != null) {
      data['order_logs'] = orderLogs!.map((v) => v.toJson()).toList();
    }
    if (skuData != null) {
      data['sku_data'] = skuData!.map((v) => v.toJson()).toList();
    }
    if (deliveryMethods != null) {
      data['delivery_methods'] =
          deliveryMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
