// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wholesaler_credit_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholesalerCreditLineModel _$WholesalerCreditLineModelFromJson(
        Map<String, dynamic> json) =>
    WholesalerCreditLineModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WholesalerCreditLineModelToJson(
    WholesalerCreditLineModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data?.toJson());
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  WholesalerCreditLineData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      firstPageUrl: json['first_page_url'] as String? ?? '',
      from: (json['from'] as num?)?.toInt() ?? 0,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 0,
      lastPageUrl: json['last_page_url'] as String? ?? '',
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nextPageUrl: json['next_page_url'] as String? ?? '',
      path: json['path'] as String? ?? '',
      perPage: (json['per_page'] as num?)?.toInt() ?? 0,
      prevPageUrl: json['prev_page_url'] as String? ?? '',
      to: (json['to'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('current_page', instance.currentPage);
  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  writeNotNull('first_page_url', instance.firstPageUrl);
  writeNotNull('from', instance.from);
  writeNotNull('last_page', instance.lastPage);
  writeNotNull('last_page_url', instance.lastPageUrl);
  writeNotNull('links', instance.links?.map((e) => e.toJson()).toList());
  writeNotNull('next_page_url', instance.nextPageUrl);
  writeNotNull('path', instance.path);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('prev_page_url', instance.prevPageUrl);
  writeNotNull('to', instance.to);
  writeNotNull('total', instance.total);
  return val;
}

WholesalerCreditLineData _$WholesalerCreditLineDataFromJson(
        Map<String, dynamic> json) =>
    WholesalerCreditLineData(
      id: (json['id'] as num?)?.toInt() ?? 0,
      uniqueId: json['unique_id'] as String? ?? '',
      associationId: (json['association_id'] as num?)?.toInt() ?? 0,
      fieId: json['fie_id'] as String? ?? '',
      bpIdF: (json['bp_id_f'] as num?)?.toInt() ?? 0,
      bpIdR: (json['bp_id_r'] as num?)?.toInt() ?? 0,
      monthlyPurchase: json['monthly_purchase'] as String? ?? '',
      averagePurchaseTickets: json['average_purchase_tickets'] as String? ?? '',
      requestedAmount: json['requested_amount'] as String? ?? '',
      customerSinceDate: json['customer_since_date'] as String? ?? '',
      monthlySales: json['monthly_sales'] as String? ?? '',
      averageSalesTicket: json['average_sales_ticket'] as String? ?? '',
      rcCrlineAmt: json['rc_crline_amt'] as String? ?? '',
      visitFrequency: (json['visit_frequency'] as num?)?.toInt() ?? 0,
      creditOfficerGroup: json['credit_officer_group'] as String? ?? '',
      commercialName1: json['commercial_name_1'] as String? ?? '',
      commercialPhone1: json['commercial_phone_1'] as String? ?? '',
      commercialName2: json['commercial_name_2'] as String? ?? '',
      commercialPhone2: json['commercial_phone_2'] as String? ?? '',
      commercialName3: json['commercial_name_3'] as String? ?? '',
      commercialPhone3: json['commercial_phone_3'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      financialStatements: json['financial_statements'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      country: json['country'] as String? ?? '',
      statusFie: (json['status_fie'] as num?)?.toInt() ?? 0,
      approvedCreditLineAmount:
          (json['approved_credit_line_amount'] as num?)?.toDouble() ?? 0.0,
      approvedCreditLineCurrency:
          json['approved_credit_line_currency'] as String? ?? '',
      clInternalId: json['cl_internal_id'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      expirationDate: json['expiration_date'] as String? ?? '',
      clApprovedDate: json['cl_approved_date'] as String? ?? '',
      clType: (json['cl_type'] as num?)?.toInt() ?? 0,
      isForward: (json['is_forward'] as num?)?.toInt() ?? 0,
      actionBy: json['action_by'] as String? ?? '',
      actionEnrollement: json['action_enrollement'] as String? ?? '',
      authorizationDate: json['authorization_date'] as String? ?? '',
      isFieRespond: (json['is_fie_respond'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      parentClId: (json['parent_cl_id'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      fieName: json['fie_name'] as String? ?? '',
      retailerName: json['retailer_name'] as String? ?? '',
      fieUniqueId: json['fie_unique_id'] as String? ?? '',
      wholesalerUniqueId: json['wholesaler_unique_id'] as String? ?? '',
      associationUniqueId: json['association_unique_id'] as String? ?? '',
      statusDescription: json['status_description'] as String? ?? '',
      dateRequested: json['date_requested'] as String? ?? '',
    );

Map<String, dynamic> _$WholesalerCreditLineDataToJson(
    WholesalerCreditLineData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('association_id', instance.associationId);
  writeNotNull('fie_id', instance.fieId);
  writeNotNull('bp_id_f', instance.bpIdF);
  writeNotNull('bp_id_r', instance.bpIdR);
  writeNotNull('monthly_purchase', instance.monthlyPurchase);
  writeNotNull('average_purchase_tickets', instance.averagePurchaseTickets);
  writeNotNull('requested_amount', instance.requestedAmount);
  writeNotNull('customer_since_date', instance.customerSinceDate);
  writeNotNull('monthly_sales', instance.monthlySales);
  writeNotNull('average_sales_ticket', instance.averageSalesTicket);
  writeNotNull('rc_crline_amt', instance.rcCrlineAmt);
  writeNotNull('visit_frequency', instance.visitFrequency);
  writeNotNull('credit_officer_group', instance.creditOfficerGroup);
  writeNotNull('commercial_name_1', instance.commercialName1);
  writeNotNull('commercial_phone_1', instance.commercialPhone1);
  writeNotNull('commercial_name_2', instance.commercialName2);
  writeNotNull('commercial_phone_2', instance.commercialPhone2);
  writeNotNull('commercial_name_3', instance.commercialName3);
  writeNotNull('commercial_phone_3', instance.commercialPhone3);
  writeNotNull('currency', instance.currency);
  writeNotNull('financial_statements', instance.financialStatements);
  writeNotNull('status', instance.status);
  writeNotNull('country', instance.country);
  writeNotNull('status_fie', instance.statusFie);
  writeNotNull(
      'approved_credit_line_amount', instance.approvedCreditLineAmount);
  writeNotNull(
      'approved_credit_line_currency', instance.approvedCreditLineCurrency);
  writeNotNull('cl_internal_id', instance.clInternalId);
  writeNotNull('start_date', instance.startDate);
  writeNotNull('expiration_date', instance.expirationDate);
  writeNotNull('cl_approved_date', instance.clApprovedDate);
  writeNotNull('cl_type', instance.clType);
  writeNotNull('is_forward', instance.isForward);
  writeNotNull('action_by', instance.actionBy);
  writeNotNull('action_enrollement', instance.actionEnrollement);
  writeNotNull('authorization_date', instance.authorizationDate);
  writeNotNull('is_fie_respond', instance.isFieRespond);
  writeNotNull('type', instance.type);
  writeNotNull('parent_cl_id', instance.parentClId);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('fie_name', instance.fieName);
  writeNotNull('retailer_name', instance.retailerName);
  writeNotNull('fie_unique_id', instance.fieUniqueId);
  writeNotNull('wholesaler_unique_id', instance.wholesalerUniqueId);
  writeNotNull('association_unique_id', instance.associationUniqueId);
  writeNotNull('status_description', instance.statusDescription);
  writeNotNull('date_requested', instance.dateRequested);
  return val;
}

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      url: json['url'] as String? ?? '',
      label: json['label'] as String? ?? '',
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$LinksToJson(Links instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('label', instance.label);
  writeNotNull('active', instance.active);
  return val;
}
