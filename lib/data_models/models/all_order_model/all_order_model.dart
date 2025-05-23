class AllOrderModel {
  bool? success;
  String? message;
  Data? data;

  AllOrderModel({this.success, this.message, this.data});

  AllOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<AllOrderModelData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    if (json['data'] != null) {
      data = <AllOrderModelData>[];
      json['data'].forEach((v) {
        data!.add(AllOrderModelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? "";
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? "";
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }
}

class AllOrderModelData {
  String? uniqueId;
  String? grandTotal;
  String? deliveryDate;
  String? dateOfTransaction;
  int? status;
  int? orderType;
  String? retailerName;
  String? wholesalerName;
  String? storeName;
  String? currency;
  String? wholesalerUniqueId;
  String? storeUniqueId;
  String? salesId;
  String? statusDescription;
  String? orderTypeDescription;
  String? orderId;
  String? orderAmount;
  String? orderDate;
  String? orderFrom;
  String? orderTo;
  int? orderQty;
  String? paymentMethodName;
  int? paymentMethod;
  String? invoiceNumber;

  AllOrderModelData(
      {this.uniqueId,
      this.grandTotal,
      this.deliveryDate,
      this.dateOfTransaction,
      this.status,
      this.orderType,
      this.retailerName,
      this.wholesalerName,
      this.storeName,
      this.currency,
      this.wholesalerUniqueId,
      this.storeUniqueId,
      this.salesId,
      this.statusDescription,
      this.orderTypeDescription,
      this.orderId,
      this.orderAmount,
      this.orderDate,
      this.orderFrom,
      this.orderTo,
      this.orderQty,
      this.paymentMethodName,
      this.paymentMethod,
      this.invoiceNumber});

  AllOrderModelData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    grandTotal = (json['grand_total'] ?? 0.00).toString();
    deliveryDate = json['delivery_date'] ?? "";
    dateOfTransaction = json['date_of_transaction'] ?? "";
    status = json['status'] ?? 0;
    orderType = json['order_type'] ?? 0;
    retailerName = json['RetailerName'] ?? "";
    wholesalerName = json['WholesalerName'] ?? "";
    storeName = json['storeName'] ?? "";
    currency = json['currency'] ?? "";
    wholesalerUniqueId = json['wholesaler_unique_id'] ?? "";
    storeUniqueId = json['store_unique_id'] ?? "";
    salesId = json['sales_id'] ?? "";
    statusDescription = json['status_description'] ?? "";
    orderTypeDescription = json['order_type_description'] ?? "";
    orderId = json['order_id'] ?? "";
    orderAmount = (json['order_amount'] ?? '0.0').toString();
    orderDate = json['order_date'] ?? "";
    orderFrom = json['orderFrom'] ?? "";
    orderTo = json['orderTo'] ?? "";
    orderQty = json['order_qty'] ?? 0;
    paymentMethodName = json['payment_method_name'] ?? "";
    paymentMethod = json['payment_method'] ?? 0;
    invoiceNumber = json['invoice_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['grand_total'] = grandTotal;
    data['delivery_date'] = deliveryDate;
    data['date_of_transaction'] = dateOfTransaction;
    data['status'] = status;
    data['order_type'] = orderType;
    data['RetailerName'] = retailerName;
    data['WholesalerName'] = wholesalerName;
    data['storeName'] = storeName;
    data['currency'] = currency;
    data['wholesaler_unique_id'] = wholesalerUniqueId;
    data['store_unique_id'] = storeUniqueId;
    data['sales_id'] = salesId;
    data['status_description'] = statusDescription;
    data['order_type_description'] = orderTypeDescription;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
