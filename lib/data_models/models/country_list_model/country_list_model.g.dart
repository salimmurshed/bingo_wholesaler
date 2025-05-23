// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListModel _$CountryListModelFromJson(Map<String, dynamic> json) =>
    CountryListModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryListModelToJson(CountryListModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  return val;
}

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      id: (json['id'] as num?)?.toInt() ?? 0,
      country: json['country'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
      glId: (json['gl_id'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      date: json['date'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      branchLegal: json['branch_legal'] as String? ?? '',
      address: json['address'] as String? ?? '',
      taxid: json['taxid'] as String? ?? '',
      taxIdType: json['tax_id_type'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      language: json['language'] as String? ?? '',
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('country', instance.country);
  writeNotNull('timezone', instance.timezone);
  writeNotNull('gl_id', instance.glId);
  writeNotNull('status', instance.status);
  writeNotNull('date', instance.date);
  writeNotNull('currency', instance.currency);
  writeNotNull('branch_legal', instance.branchLegal);
  writeNotNull('address', instance.address);
  writeNotNull('taxid', instance.taxid);
  writeNotNull('tax_id_type', instance.taxIdType);
  writeNotNull('country_code', instance.countryCode);
  writeNotNull('language', instance.language);
  return val;
}
