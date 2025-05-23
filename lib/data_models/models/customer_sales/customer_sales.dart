class CustomerSales {
  bool? success;
  String? message;
  Data? data;

  CustomerSales({this.success, this.message, this.data});

  CustomerSales.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<CustomerSalesData>? data;
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
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CustomerSalesData>[];
      json['data'].forEach((v) {
        data!.add(CustomerSalesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class CustomerSalesData {
  String? uniqueId;
  String? invoiceNumber;
  String? orderNumber;
  String? saleDate;
  String? dueDate;
  String? currency;
  String? saleType;
  String? amount;
  String? bingoOrderId;
  int? status;
  String? description;
  String? retailerName;
  String? fieName;
  String? wholesalerTempTxAddress;
  String? retailerTempTxAddress;
  String? wholesalerStoreId;
  String? statusDescription;
  String? balance;

  CustomerSalesData(
      {this.uniqueId,
      this.invoiceNumber,
      this.orderNumber,
      this.saleDate,
      this.dueDate,
      this.currency,
      this.saleType,
      this.amount,
      this.bingoOrderId,
      this.status,
      this.description,
      this.retailerName,
      this.fieName,
      this.wholesalerTempTxAddress,
      this.retailerTempTxAddress,
      this.wholesalerStoreId,
      this.statusDescription,
      this.balance});

  CustomerSalesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? '';
    invoiceNumber = json['invoice_number'] ?? '';
    orderNumber = json['order_number'] ?? '';
    saleDate = json['sale_date'] ?? '';
    dueDate = json['due_date'] ?? '';
    currency = json['currency'] ?? '';
    saleType = json['sale_type'] ?? '';
    amount = json['amount'] ?? '';
    bingoOrderId = json['bingo_order_id'] ?? '';
    status = json['status'] ?? 0;
    description = json['description'] ?? '';
    retailerName = json['retailer_name'] ?? '';
    fieName = json['fie_name'] ?? '';
    wholesalerTempTxAddress = json['wholesaler_temp_tx_address'] ?? '';
    retailerTempTxAddress = json['retailer_temp_tx_address'] ?? '';
    wholesalerStoreId = json['wholesaler_store_id'] ?? '';
    statusDescription = json['status_description'] ?? '';
    balance = json['balance'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['invoice_number'] = invoiceNumber;
    data['order_number'] = orderNumber;
    data['sale_date'] = saleDate;
    data['due_date'] = dueDate;
    data['currency'] = currency;
    data['sale_type'] = saleType;
    data['amount'] = amount;
    data['bingo_order_id'] = bingoOrderId;
    data['status'] = status;
    data['description'] = description;
    data['retailer_name'] = retailerName;
    data['fie_name'] = fieName;
    data['wholesaler_temp_tx_address'] = wholesalerTempTxAddress;
    data['retailer_temp_tx_address'] = retailerTempTxAddress;
    data['wholesaler_store_id'] = wholesalerStoreId;
    data['status_description'] = statusDescription;
    data['balance'] = balance;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
