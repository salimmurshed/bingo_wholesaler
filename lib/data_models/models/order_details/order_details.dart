class OrderDetail {
  bool? success;
  String? message;
  Data? data;

  OrderDetail({this.success, this.message, this.data});

  OrderDetail.fromJson(Map<String, dynamic> json) {
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
  List<OrderDetailPromotions>? promotions;

  Data({this.orderDetails, this.promotions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    if (json['promotions'] != null) {
      promotions = <OrderDetailPromotions>[];
      json['promotions'].forEach((v) {
        promotions!.add(OrderDetailPromotions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    if (promotions != null) {
      data['promotions'] = promotions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String? uniqueId;
  String? bpIdR;
  String? retailerName;
  String? bpIdW;
  String? wholesalerName;
  String? clId;
  String? storeId;
  String? storeName;
  String? orderDescription;
  String? dateOfTransaction;
  String? promocode;
  int? itemsQty;
  double? subTotal;
  double? totalTax;
  double? total;
  String? deliveryDate;
  String? deliveryMethodId;
  String? deliveryMethodName;
  String? deliveryMethodDescription;
  int? shippingCost;
  double? grandTotal;
  int? paymentMethodId;
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

  OrderDetails(
      {this.uniqueId,
      this.bpIdR,
      this.retailerName,
      this.bpIdW,
      this.wholesalerName,
      this.clId,
      this.storeId,
      this.storeName,
      this.orderDescription,
      this.dateOfTransaction,
      this.promocode,
      this.itemsQty,
      this.subTotal,
      this.totalTax,
      this.total,
      this.deliveryDate,
      this.deliveryMethodId,
      this.deliveryMethodName,
      this.deliveryMethodDescription,
      this.shippingCost,
      this.grandTotal,
      this.paymentMethodId,
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
      this.orderLogs});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    bpIdR = json['bp_id_r'];
    retailerName = json['retailer_name'];
    bpIdW = json['bp_id_w'];
    wholesalerName = json['wholesaler_name'];
    clId = json['cl_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    orderDescription = json['order_description'];
    dateOfTransaction = json['date_of_transaction'];
    promocode = json['promocode'];
    itemsQty = json['items_qty'];
    subTotal = double.parse((json['sub_total'] ?? 0).toString());
    totalTax = json['total_tax'];
    total = json['total'];
    deliveryDate = json['delivery_date'];
    deliveryMethodId = json['delivery_method_id'];
    deliveryMethodName = json['delivery_method_name'];
    deliveryMethodDescription = json['delivery_method_description'];
    shippingCost = json['shipping_cost'];
    grandTotal = json['grand_total'];
    paymentMethodId = json['payment_method_id'];
    paymentMethodName = json['payment_method_name'];
    country = json['country'];
    status = json['status'];
    statusDescription = json['status_description'];
    orderType = json['order_type'];
    orderTypeDescription = json['order_type_description'];
    isClIncrease = json['is_cl_increase'];
    creditlineCurrency = json['creditline_currency'];
    creditlineStatus = json['creditline_status'];
    creditlineStatusDescription = json['creditline_status_description'];
    creditlineAvailableAmount =
        json['creditline_available_amount'].runtimeType == int
            ? double.parse(json['creditline_available_amount'].toString())
            : json['creditline_available_amount'];
    if (json['order_logs'] != null) {
      orderLogs = <OrderLogs>[];
      json['order_logs'].forEach((v) {
        orderLogs!.add(OrderLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['bp_id_r'] = bpIdR;
    data['retailer_name'] = retailerName;
    data['bp_id_w'] = bpIdW;
    data['wholesaler_name'] = wholesalerName;
    data['cl_id'] = clId;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['order_description'] = orderDescription;
    data['date_of_transaction'] = dateOfTransaction;
    data['promocode'] = promocode;
    data['items_qty'] = itemsQty;
    data['sub_total'] = subTotal;
    data['total_tax'] = totalTax;
    data['total'] = total;
    data['delivery_date'] = deliveryDate;
    data['delivery_method_id'] = deliveryMethodId;
    data['delivery_method_name'] = deliveryMethodName;
    data['delivery_method_description'] = deliveryMethodDescription;
    data['shipping_cost'] = shippingCost;
    data['grand_total'] = grandTotal;
    data['payment_method_id'] = paymentMethodId;
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
    return data;
  }
}

class OrderLogs {
  String? uniqueId;
  String? productId;
  String? sku;
  String? productDescription;
  int? unitPrice;
  String? currency;
  int? qty;
  String? unit;
  double? tax;
  double? amount;
  String? country;

  OrderLogs(
      {this.uniqueId,
      this.productId,
      this.sku,
      this.productDescription,
      this.unitPrice,
      this.currency,
      this.qty,
      this.unit,
      this.tax,
      this.amount,
      this.country});

  OrderLogs.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    productId = json['product_id'];
    sku = json['sku'];
    productDescription = json['product_description'];
    unitPrice = json['unit_price'];
    currency = json['currency'];
    qty = json['qty'];
    unit = json['unit'];
    tax = json['tax'];
    amount = double.parse((json['amount'] ?? 0).toString());
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['product_id'] = productId;
    data['sku'] = sku;
    data['product_description'] = productDescription;
    data['unit_price'] = unitPrice;
    data['currency'] = currency;
    data['qty'] = qty;
    data['unit'] = unit;
    data['tax'] = tax;
    data['amount'] = amount;
    data['country'] = country;
    return data;
  }
}

class OrderDetailPromotions {
  String? uniqueId;
  String? name;
  String? banner;

  OrderDetailPromotions({this.uniqueId, this.name, this.banner});

  OrderDetailPromotions.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    name = json['name'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['name'] = name;
    data['banner'] = banner;
    return data;
  }
}
