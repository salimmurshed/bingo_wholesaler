class CustomerList {
  bool? success;
  String? message;
  Data? data;

  CustomerList({success, message, data});

  CustomerList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  int? currentPage;
  List<CustomerData>? data;
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
      {currentPage,
      data,
      firstPageUrl,
      from,
      lastPage,
      lastPageUrl,
      links,
      nextPageUrl,
      path,
      perPage,
      prevPageUrl,
      to,
      total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(CustomerData.fromJson(v));
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
    data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class CustomerData {
  String? uniqueId;
  String? retailerName;
  String? wholeSalerName;
  String? phoneNumber;
  String? taxId;
  String? email;
  String? retailerEmail;
  String? status;
  String? tempTxAddress;
  String? customerSinceDate;

  CustomerData(
      {uniqueId,
      retailerName,
      wholeSalerName,
      phoneNumber,
      taxId,
      email,
      retailerEmail,
      status,
      tempTxAddress,
      customerSinceDate});

  CustomerData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    retailerName = json['retailer_name'] ?? "";
    wholeSalerName = json['wholesaler_name'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    taxId = json['tax_id'] ?? "";
    email = json['email'] ?? "";
    retailerEmail = json['retailer_email'] ?? json['bp_email'] ?? "";
    status = json['status'] ?? "";
    tempTxAddress = json['temp_tx_address'] ?? "";
    customerSinceDate = json['customer_since_date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['retailer_name'] = retailerName;
    data['wholesaler_name'] = wholeSalerName;
    data['phone_number'] = phoneNumber;
    data['tax_id'] = taxId;
    data['email'] = email;
    data['retailer_email'] = retailerEmail;
    data['status'] = status;
    data['temp_tx_address'] = tempTxAddress;
    data['customer_since_date'] = customerSinceDate;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({url, label, active});

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
