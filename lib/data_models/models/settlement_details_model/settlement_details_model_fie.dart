class SettlementDetailsModelFie {
  bool? success;
  String? message;
  Data? data;

  SettlementDetailsModelFie({this.success, this.message, this.data});

  SettlementDetailsModelFie.fromJson(Map<String, dynamic> json) {
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
  List<SettlementDetailsModelFieData>? data;
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
      data = <SettlementDetailsModelFieData>[];
      json['data'].forEach((v) {
        data!.add(SettlementDetailsModelFieData.fromJson(v));
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

class SettlementDetailsModelFieData {
  String? dateGenerated;
  String? postingDate;

  String? currency;
  int? status;
  int? paymentStatus;
  int? type;
  String? effectiveDate;
  String? lotType;
  String? lotId;
  String? amount;
  String? statusDescription;

  SettlementDetailsModelFieData(
      {this.dateGenerated,
      this.postingDate,
      this.currency,
      this.status,
      this.paymentStatus,
      this.type,
      this.effectiveDate,
      this.lotType,
      this.lotId,
      this.amount,
      this.statusDescription});

  SettlementDetailsModelFieData.fromJson(Map<String, dynamic> json) {
    dateGenerated = json['date_generated'] ?? "";
    postingDate = json['posting_date'] ?? '';

    currency = json['currency'] ?? "";
    status = json['status'] ?? 0;
    paymentStatus = json['payment_status'] ?? 0;
    type = json['type'] ?? 0;
    effectiveDate = json['effective_date'] ?? "";
    lotType = json['lot_type'] ?? "";
    lotId = json['lot_id'] ?? "";
    amount = json['amount'] ?? "";
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_generated'] = dateGenerated;
    data['posting_date'] = postingDate;

    data['currency'] = currency;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['type'] = type;
    data['effective_date'] = effectiveDate;
    data['lot_type'] = lotType;
    data['lot_id'] = lotId;
    data['amount'] = amount;
    data['status_description'] = statusDescription;
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

class PaymentDetails {
  String? lotId;
  String? documentId;
  String? documentType;
  String? invoice;
  String? openBalance;
  String? amountApplied;
  String? businessPartnerId;
  String? creditLineId;
  int? status;
  String? clInternalId;
  String? statusDescription;

  PaymentDetails(
      {this.lotId,
      this.documentId,
      this.documentType,
      this.invoice,
      this.openBalance,
      this.amountApplied,
      this.businessPartnerId,
      this.creditLineId,
      this.status,
      this.clInternalId,
      this.statusDescription});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    lotId = json['lot_id'] ?? '';
    documentId = json['document_id'] ?? '';
    documentType = json['document_type'] ?? '';
    invoice = json['invoice'] ?? '';
    openBalance = json['open_balance'] ?? '';
    amountApplied = json['amount_applied'] ?? '';
    businessPartnerId = json['business_partner_id'] ?? '';
    creditLineId = json['credit_line_id'] ?? '';
    status = json['status'] ?? 0;
    clInternalId = json['cl_internal_id'] ?? "";
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lot_id'] = lotId;
    data['document_id'] = documentId;
    data['document_type'] = documentType;
    data['invoice'] = invoice;
    data['open_balance'] = openBalance;
    data['amount_applied'] = amountApplied;
    data['business_partner_id'] = businessPartnerId;
    data['credit_line_id'] = creditLineId;
    data['status'] = status;
    data['cl_internal_id'] = this.clInternalId;
    data['status_description'] = statusDescription;
    return data;
  }
}
