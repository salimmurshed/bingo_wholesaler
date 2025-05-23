// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_credit_line_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerCreditLineRequestModel _$RetailerCreditLineRequestModelFromJson(
        Map<String, dynamic> json) =>
    RetailerCreditLineRequestModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetailerCreditLineRequestModelToJson(
    RetailerCreditLineRequestModel instance) {
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
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => RetailerCreditLineRequestData.fromJson(
                  e as Map<String, dynamic>))
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

RetailerCreditLineRequestData _$RetailerCreditLineRequestDataFromJson(
        Map<String, dynamic> json) =>
    RetailerCreditLineRequestData(
      creditlineUniqueId: json['creditline_unique_id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      dateRequested: json['date_requested'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      fieName: json['fie_name'] as String? ?? '',
      wholesalerName: json['wholesaler_name'] as String? ?? '',
      fieUniqueId: json['fie_unique_id'] as String? ?? '',
      wholesalerUniqueId: json['wholesaler_unique_id'] as String? ?? '',
      associationUniqueId: json['association_unique_id'] as String? ?? '',
      requestedAmount: json['requested_amount'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      statusDescription: json['status_description'] as String? ?? '',
    );

Map<String, dynamic> _$RetailerCreditLineRequestDataToJson(
    RetailerCreditLineRequestData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('creditline_unique_id', instance.creditlineUniqueId);
  writeNotNull('type', instance.type);
  writeNotNull('date_requested', instance.dateRequested);
  writeNotNull('status', instance.status);
  writeNotNull('fie_name', instance.fieName);
  writeNotNull('wholesaler_name', instance.wholesalerName);
  writeNotNull('fie_unique_id', instance.fieUniqueId);
  writeNotNull('wholesaler_unique_id', instance.wholesalerUniqueId);
  writeNotNull('association_unique_id', instance.associationUniqueId);
  writeNotNull('status_description', instance.statusDescription);
  writeNotNull('requested_amount', instance.requestedAmount);
  writeNotNull('currency', instance.currency);
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
