import '../../../const/app_extensions/make_double.dart';

class OrderSelectionModel {
  bool? success;
  String? message;
  Data? data;

  OrderSelectionModel({this.success, this.message, this.data});

  OrderSelectionModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  List<SkuData>? skuData;
  List<PaymentMethod>? paymentMethod;
  List<DeliveryMethod>? deliveryMethod;
  Creditline? creditline;
  Spcreditline? spcreditline;
  List<Templates>? templates;
  List<Drafts>? drafts;
  int? tmpCnt;
  int? draftCnt;
  List<WholesalerCurrency>? wholesalerCurrency;
  String? wholesalerId;
  String? storeId;
  List<Promotions>? promotions;

  Data(
      {this.id,
      this.skuData,
      this.paymentMethod,
      this.deliveryMethod,
      this.creditline,
      this.spcreditline,
      this.templates,
      this.drafts,
      this.tmpCnt,
      this.draftCnt,
      this.wholesalerCurrency,
      this.wholesalerId,
      this.storeId,
      this.promotions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sku_data'] != null) {
      skuData = <SkuData>[];
      json['sku_data'].forEach((v) {
        skuData!.add(SkuData.fromJson(v));
      });
    }
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(PaymentMethod.fromJson(v));
      });
    }
    if (json['delivery_method'] != null) {
      deliveryMethod = <DeliveryMethod>[];
      json['delivery_method'].forEach((v) {
        deliveryMethod!.add(DeliveryMethod.fromJson(v));
      });
    }
    creditline = json['creditline'] != null
        ? Creditline.fromJson(json['creditline'])
        : null;
    spcreditline = json['spcreditline'] != null
        ? Spcreditline.fromJson(json['spcreditline'])
        : null;
    if (json['templates'] != null) {
      templates = <Templates>[];
      json['templates'].forEach((v) {
        templates!.add(Templates.fromJson(v));
      });
    }
    if (json['drafts'] != null) {
      drafts = <Drafts>[];
      json['drafts'].forEach((v) {
        drafts!.add(Drafts.fromJson(v));
      });
    }
    tmpCnt = json['tmpCnt'];
    draftCnt = json['draftCnt'];
    if (json['wholesaler_currency'] != null) {
      wholesalerCurrency = <WholesalerCurrency>[];
      json['wholesaler_currency'].forEach((v) {
        wholesalerCurrency!.add(WholesalerCurrency.fromJson(v));
      });
    }
    wholesalerId = json['wholesaler_id'];
    storeId = json['store_id'];
    if (json['promotions'] != null) {
      promotions = <Promotions>[];
      json['promotions'].forEach((v) {
        promotions!.add(Promotions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (skuData != null) {
      data['sku_data'] = skuData!.map((v) => v.toJson()).toList();
    }
    if (paymentMethod != null) {
      data['payment_method'] = paymentMethod!.map((v) => v.toJson()).toList();
    }
    if (deliveryMethod != null) {
      data['delivery_method'] = deliveryMethod!.map((v) => v.toJson()).toList();
    }
    if (creditline != null) {
      data['creditline'] = creditline!.toJson();
    }
    if (spcreditline != null) {
      data['spcreditline'] = spcreditline!.toJson();
    }
    if (templates != null) {
      data['templates'] = templates!.map((v) => v.toJson()).toList();
    }
    if (drafts != null) {
      data['drafts'] = drafts!.map((v) => v.toJson()).toList();
    }
    data['tmpCnt'] = tmpCnt;
    data['draftCnt'] = draftCnt;
    if (wholesalerCurrency != null) {
      data['wholesaler_currency'] =
          wholesalerCurrency!.map((v) => v.toJson()).toList();
    }
    data['wholesaler_id'] = wholesalerId;
    data['store_id'] = storeId;
    if (promotions != null) {
      data['promotions'] = promotions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkuData {
  String? productId;
  String? sku;
  String? productDescription;
  double? unitPrice;
  String? currency;
  String? unit;
  double? tax;
  String? productImage;

  SkuData(
      {this.productId,
      this.sku,
      this.productDescription,
      this.unitPrice,
      this.currency,
      this.unit,
      this.tax,
      this.productImage});

  SkuData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    sku = json['sku'];
    productDescription = json['product_description'];
    unitPrice = makeDouble(json['unit_price']);
    currency = json['currency'];
    unit = json['unit'];
    tax = json['tax'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['sku'] = sku;
    data['product_description'] = productDescription;
    data['unit_price'] = unitPrice;
    data['currency'] = currency;
    data['unit'] = unit;
    data['tax'] = tax;
    data['product_image'] = productImage;
    return data;
  }
}

class PaymentMethod {
  dynamic uniqueId;
  String? paymentMethod;

  PaymentMethod({this.uniqueId, this.paymentMethod});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['payment_method'] = paymentMethod;
    return data;
  }
}

class DeliveryMethod {
  String? uniqueId;
  String? deliveryMethod;
  int? shippingAndHandlingCost;

  DeliveryMethod(
      {this.uniqueId, this.deliveryMethod, this.shippingAndHandlingCost});

  DeliveryMethod.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    deliveryMethod = json['delivery_method'];
    shippingAndHandlingCost = json['shipping_and_handling_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['delivery_method'] = deliveryMethod;
    data['shipping_and_handling_cost'] = shippingAndHandlingCost;
    return data;
  }
}

class Creditline {
  String? uniqueId;
  int? status;
  String? statusDescription;
  String? currency;

  Creditline(
      {this.uniqueId, this.status, this.statusDescription, this.currency});

  Creditline.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    status = json['status'];
    statusDescription = json['status_description'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['status'] = status;
    data['status_description'] = statusDescription;
    data['currency'] = currency;
    return data;
  }
}

class Spcreditline {
  String? uniqueId;
  double? amount;
  double? consumedAmount;
  double? creditlineAvailableAmount;

  Spcreditline(
      {this.uniqueId,
      this.amount,
      this.consumedAmount,
      this.creditlineAvailableAmount});

  Spcreditline.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    amount = makeDouble(json['amount']);
    consumedAmount = makeDouble(json['consumed_amount']);
    creditlineAvailableAmount = makeDouble(json['creditline_available_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['amount'] = amount;
    data['consumed_amount'] = consumedAmount;
    data['creditline_available_amount'] = creditlineAvailableAmount;
    return data;
  }
}

class Templates {
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
  List<OrderLogs>? orderLogs;

  Templates(
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
      this.orderLogs});

  Templates.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    bpIdR = json['bp_id_r'];
    retailerName = json['retailer_name'];
    bpIdW = json['bp_id_w'];
    wholesalerName = json['wholesaler_name'];
    clId = json['cl_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    orderDescription = json['order_description'] ?? "";
    dateOfTransaction = json['date_of_transaction'];
    promocode = json['promocode'];
    itemsQty = json['items_qty'];
    subTotal = json['sub_total'];
    totalTax = double.parse((json['total_tax'] ?? 0.0).toString());
    total = double.parse((json['total'] ?? 0.0).toString());
    deliveryDate = json['delivery_date'];
    deliveryMethod = json['delivery_method'];
    deliveryMethodId = json['delivery_method_id'];
    shippingCost = json['shipping_cost'];
    grandTotal = double.parse((json['grand_total'] ?? 0.0).toString());
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    country = json['country'];
    status = json['status'];
    statusDescription = json['status_description'];
    orderType = json['order_type'];
    orderTypeDescription = json['order_type_description'];
    isClIncrease = json['is_cl_increase'];
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
  double? unitPrice;
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
    unitPrice = makeDouble(json['unit_price']);
    currency = json['currency'];
    qty = json['qty'];
    unit = json['unit'];
    tax = json['tax'];
    amount = makeDouble(json['amount']);
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

class Promotions {
  String? uniqueId;
  String? name;
  String? banner;

  Promotions({this.uniqueId, this.name, this.banner});

  Promotions.fromJson(Map<String, dynamic> json) {
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

class Drafts {
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
  List<OrderLogs>? orderLogs;

  Drafts(
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
      this.orderLogs});

  Drafts.fromJson(Map<String, dynamic> json) {
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
    subTotal = json['sub_total'];
    totalTax = json['total_tax'].toDouble();
    total = json['total'].toDouble();
    deliveryDate = json['delivery_date'] ?? "";
    deliveryMethod = json['delivery_method'] ?? "";
    deliveryMethodId = json['delivery_method_id'] ?? "";
    shippingCost = json['shipping_cost'];
    grandTotal = json['grand_total'].toDouble();
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    country = json['country'];
    status = json['status'];
    statusDescription = json['status_description'];
    orderType = json['order_type'];
    orderTypeDescription = json['order_type_description'];
    isClIncrease = json['is_cl_increase'];
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
    if (orderLogs != null) {
      data['order_logs'] = orderLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WholesalerCurrency {
  String? currency;

  WholesalerCurrency({this.currency});

  WholesalerCurrency.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    return data;
  }
}
