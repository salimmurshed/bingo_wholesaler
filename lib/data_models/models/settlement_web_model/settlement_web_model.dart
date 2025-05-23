class SettlementWebModel {
  bool? success;
  String? message;
  Data? data;

  SettlementWebModel({this.success, this.message, this.data});

  SettlementWebModel.fromJson(Map<String, dynamic> json) {
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
  List<SettlementWebModelData>? data;
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
      data = <SettlementWebModelData>[];
      json['data'].forEach((v) {
        data!.add(SettlementWebModelData.fromJson(v));
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

class SettlementWebModelData {
  String? postingDate;
  String? lotId;
  int? lotType;
  int? type;
  String? currency;
  double? amount;
  int? status;
  String? statusDescription;

  SettlementWebModelData(
      {this.postingDate,
      this.lotId,
      this.lotType,
      this.type,
      this.currency,
      this.amount,
      this.status,
      this.statusDescription});

  SettlementWebModelData.fromJson(Map<String, dynamic> json) {
    postingDate = json['posting_date'] ?? '';
    lotId = json['lot_id'] ?? '';
    type = json['type'] ?? 0;
    lotType = int.tryParse(json['lot_type'].toString() ?? '0');
    currency = json['currency'] ?? '';
    amount =
        double.parse((json['amount'] ?? '0.0').toString().replaceAll(",", ''));
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posting_date'] = postingDate;
    data['lot_id'] = lotId;
    data['lot_type'] = lotType;
    data['type'] = type;
    data['currency'] = currency;
    data['amount'] = amount;
    data['status'] = status;
    data['status_description'] = statusDescription;
    return data;
  }
}

class RetailerSettlementWebModel {
  bool? success;
  String? message;
  List<SettlementWebModelData>? data;

  RetailerSettlementWebModel({this.success, this.message, this.data});

  RetailerSettlementWebModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SettlementWebModelData>[];
      json['data'].forEach((v) {
        data!.add(SettlementWebModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
