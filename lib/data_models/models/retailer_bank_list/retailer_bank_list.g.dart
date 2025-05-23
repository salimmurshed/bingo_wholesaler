// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_bank_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerBankList _$RetailerBankListFromJson(Map<String, dynamic> json) =>
    RetailerBankList(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RetailerBankListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RetailerBankListToJson(RetailerBankList instance) {
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

RetailerBankListData _$RetailerBankListDataFromJson(
        Map<String, dynamic> json) =>
    RetailerBankListData(
      uniqueId: json['unique_id'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      bankAccountType: (json['bank_account_type'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? '',
      bankAccountNumber: json['bank_account_number'] as String? ?? '',
      iban: json['iban'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      fieId: json['fie_id'] as String? ?? '',
      fieName: json['fie_name'] as String? ?? '',
      statusDescription: json['status_description'] as String? ?? '',
      updatedAtDate: json['updated_at_date'] as String? ?? '',
      bankAccountTypeDescription:
          json['bank_account_type_description'] as String? ?? '',
    );

Map<String, dynamic> _$RetailerBankListDataToJson(
    RetailerBankListData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('status', instance.status);
  writeNotNull('bank_account_type', instance.bankAccountType);
  writeNotNull('currency', instance.currency);
  writeNotNull('bank_account_number', instance.bankAccountNumber);
  writeNotNull('iban', instance.iban);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('fie_id', instance.fieId);
  writeNotNull('fie_name', instance.fieName);
  writeNotNull('status_description', instance.statusDescription);
  writeNotNull('updated_at_date', instance.updatedAtDate);
  writeNotNull(
      'bank_account_type_description', instance.bankAccountTypeDescription);
  return val;
}
