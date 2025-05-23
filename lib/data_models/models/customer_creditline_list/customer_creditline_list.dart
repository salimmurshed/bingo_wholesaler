class CustomerCreditlineList {
  bool? success;
  String? message;
  Data? data;

  CustomerCreditlineList({this.success, this.message, this.data});

  CustomerCreditlineList.fromJson(Map<String, dynamic> json) {
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
  List<CustomerCreditlineData>? data;
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
      data = <CustomerCreditlineData>[];
      json['data'].forEach((v) {
        data!.add(CustomerCreditlineData.fromJson(v));
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

class CustomerCreditlineData {
  int? id;
  String? uniqueId;
  int? associationId;
  String? fieId;
  int? bpIdF;
  int? bpIdR;
  String? monthlyPurchase;
  String? averagePurchaseTickets;
  String? averagePurchasePerMonth;
  String? requestedAmount;
  String? customerSinceDate;
  String? monthlySales;
  String? averageSalesTicket;
  String? rcCrlineAmt;
  int? visitFrequency;
  String? creditOfficerGroup;
  String? commercialName1;
  String? commercialPhone1;
  String? commercialName2;
  String? commercialPhone2;
  String? commercialName3;
  String? commercialPhone3;
  String? currency;
  String? financialStatements;
  int? status;
  String? country;
  int? statusFie;
  String? approvedCreditLineAmount;
  String? approvedCreditLineCurrency;
  String? consumedAmount;
  String? clInternalId;
  String? startDate;
  String? expirationDate;
  String? clApprovedDate;
  int? clType;
  int? isForward;
  String? actionBy;
  String? actionEnrollement;
  String? authorizationDate;
  int? parentCrId;
  int? bankAccountId;
  String? minimumCommitmentDate;
  String? invoiceId;
  String? financialEntriesUniqueId;
  int? isFieRespond;
  int? clOperationalStatus;
  String? type;
  int? parentClId;
  String? createdAt;
  String? updatedAt;
  String? fieName;
  String? retailerName;
  String? fieUniqueId;
  String? retailerUniqueId;
  String? associationUniqueId;
  String? statusDescription;
  String? dateRequested;

  CustomerCreditlineData(
      {this.id,
      this.uniqueId,
      this.associationId,
      this.fieId,
      this.bpIdF,
      this.bpIdR,
      this.monthlyPurchase,
      this.averagePurchaseTickets,
      this.averagePurchasePerMonth,
      this.requestedAmount,
      this.customerSinceDate,
      this.monthlySales,
      this.averageSalesTicket,
      this.rcCrlineAmt,
      this.visitFrequency,
      this.creditOfficerGroup,
      this.commercialName1,
      this.commercialPhone1,
      this.commercialName2,
      this.commercialPhone2,
      this.commercialName3,
      this.commercialPhone3,
      this.currency,
      this.financialStatements,
      this.status,
      this.country,
      this.statusFie,
      this.approvedCreditLineAmount,
      this.approvedCreditLineCurrency,
      this.consumedAmount,
      this.clInternalId,
      this.startDate,
      this.expirationDate,
      this.clApprovedDate,
      this.clType,
      this.isForward,
      this.actionBy,
      this.actionEnrollement,
      this.authorizationDate,
      this.parentCrId,
      this.bankAccountId,
      this.minimumCommitmentDate,
      this.invoiceId,
      this.financialEntriesUniqueId,
      this.isFieRespond,
      this.clOperationalStatus,
      this.type,
      this.parentClId,
      this.createdAt,
      this.updatedAt,
      this.fieName,
      this.retailerName,
      this.fieUniqueId,
      this.retailerUniqueId,
      this.associationUniqueId,
      this.statusDescription,
      this.dateRequested});

  CustomerCreditlineData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    uniqueId = json['unique_id'] ?? "";
    associationId = json['association_id'] ?? 0;
    fieId = json['fie_id'] ?? "";
    bpIdF = json['bp_id_f'] ?? 0;
    bpIdR = json['bp_id_r'] ?? 0;
    monthlyPurchase = json['monthly_purchase'] ?? "";
    averagePurchaseTickets = json['average_purchase_tickets'] ?? "";
    averagePurchasePerMonth = json['average_purchase_per_month'] ?? "";
    requestedAmount = json['requested_amount'] ?? "";
    customerSinceDate = json['customer_since_date'] ?? "";
    monthlySales = json['monthly_sales'] ?? "";
    averageSalesTicket = json['average_sales_ticket'] ?? "";
    rcCrlineAmt = json['rc_crline_amt'] ?? "";
    visitFrequency = json['visit_frequency'] ?? 0;
    creditOfficerGroup = json['credit_officer_group'] ?? "";
    commercialName1 = json['commercial_name_1'] ?? "";
    commercialPhone1 = json['commercial_phone_1'] ?? "";
    commercialName2 = json['commercial_name_2'] ?? "";
    commercialPhone2 = json['commercial_phone_2'] ?? "";
    commercialName3 = json['commercial_name_3'] ?? "";
    commercialPhone3 = json['commercial_phone_3'] ?? "";
    currency = json['currency'] ?? "";
    financialStatements = json['financial_statements'] ?? "";
    status = json['status'] ?? 0;
    country = json['country'] ?? "";
    statusFie = json['status_fie'] ?? 0;
    approvedCreditLineAmount = json['approved_credit_line_amount'] ?? "";
    approvedCreditLineCurrency = json['approved_credit_line_currency'] ?? "";
    consumedAmount = (json['consumed_amount'] ?? 0.0).toString();
    clInternalId = json['cl_internal_id'] ?? "";
    startDate = json['start_date'] ?? "";
    expirationDate = json['expiration_date'] ?? "";
    clApprovedDate = json['cl_approved_date'] ?? "";
    clType = json['cl_type'] ?? 0;
    isForward = json['is_forward'] ?? 0;
    actionBy = json['action_by'] ?? "";
    actionEnrollement = json['action_enrollement'] ?? "";
    authorizationDate = json['authorization_date'] ?? "";
    parentCrId = json['parent_cr_id'] ?? 0;
    bankAccountId = json['bank_account_id'] ?? 0;
    minimumCommitmentDate = json['minimum_commitment_date'] ?? "";
    invoiceId = json['invoice_id'] ?? "";
    financialEntriesUniqueId = json['financial_entries_unique_id'] ?? "";
    isFieRespond = json['is_fie_respond'] ?? 0;
    clOperationalStatus = json['cl_operational_status'] ?? 0;
    type = json['type'] ?? "";
    parentClId = json['parent_cl_id'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    fieName = json['fie_name'] ?? "";
    retailerName = json['retailer_name'] ?? "";
    fieUniqueId = json['fie_unique_id'] ?? "";
    retailerUniqueId = json['retailer_unique_id'] ?? "";
    associationUniqueId = json['association_unique_id'] ?? "";
    statusDescription = json['status_description'] ?? "";
    dateRequested = json['date_requested'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['association_id'] = associationId;
    data['fie_id'] = fieId;
    data['bp_id_f'] = bpIdF;
    data['bp_id_r'] = bpIdR;
    data['monthly_purchase'] = monthlyPurchase;
    data['average_purchase_tickets'] = averagePurchaseTickets;
    data['average_purchase_per_month'] = averagePurchasePerMonth;
    data['requested_amount'] = requestedAmount;
    data['customer_since_date'] = customerSinceDate;
    data['monthly_sales'] = monthlySales;
    data['average_sales_ticket'] = averageSalesTicket;
    data['rc_crline_amt'] = rcCrlineAmt;
    data['visit_frequency'] = visitFrequency;
    data['credit_officer_group'] = creditOfficerGroup;
    data['commercial_name_1'] = commercialName1;
    data['commercial_phone_1'] = commercialPhone1;
    data['commercial_name_2'] = commercialName2;
    data['commercial_phone_2'] = commercialPhone2;
    data['commercial_name_3'] = commercialName3;
    data['commercial_phone_3'] = commercialPhone3;
    data['currency'] = currency;
    data['financial_statements'] = financialStatements;
    data['status'] = status;
    data['country'] = country;
    data['status_fie'] = statusFie;
    data['approved_credit_line_amount'] = approvedCreditLineAmount;
    data['approved_credit_line_currency'] = approvedCreditLineCurrency;
    data['consumed_amount'] = consumedAmount;
    data['cl_internal_id'] = clInternalId;
    data['start_date'] = startDate;
    data['expiration_date'] = expirationDate;
    data['cl_approved_date'] = clApprovedDate;
    data['cl_type'] = clType;
    data['is_forward'] = isForward;
    data['action_by'] = actionBy;
    data['action_enrollement'] = actionEnrollement;
    data['authorization_date'] = authorizationDate;
    data['parent_cr_id'] = parentCrId;
    data['bank_account_id'] = bankAccountId;
    data['minimum_commitment_date'] = minimumCommitmentDate;
    data['invoice_id'] = invoiceId;
    data['financial_entries_unique_id'] = financialEntriesUniqueId;
    data['is_fie_respond'] = isFieRespond;
    data['cl_operational_status'] = clOperationalStatus;
    data['type'] = type;
    data['parent_cl_id'] = parentClId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fie_name'] = fieName;
    data['retailer_name'] = retailerName;
    data['fie_unique_id'] = fieUniqueId;
    data['retailer_unique_id'] = retailerUniqueId;
    data['association_unique_id'] = associationUniqueId;
    data['status_description'] = statusDescription;
    data['date_requested'] = dateRequested;
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
