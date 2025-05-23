// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_request_wholesaler_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationRequestWholesalerModel _$AssociationRequestWholesalerModelFromJson(
        Map<String, dynamic> json) =>
    AssociationRequestWholesalerModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssociationRequestWholesalerData.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssociationRequestWholesalerModelToJson(
    AssociationRequestWholesalerModel instance) {
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

AssociationRequestWholesalerData _$AssociationRequestWholesalerDataFromJson(
        Map<String, dynamic> json) =>
    AssociationRequestWholesalerData(
      uniqueId: json['unique_id'] as String?,
      associationUniqueId: json['association_unique_id'] as String? ?? '',
      retailerName: json['retailer_name'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$AssociationRequestWholesalerDataToJson(
    AssociationRequestWholesalerData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('association_unique_id', instance.associationUniqueId);
  writeNotNull('retailer_name', instance.retailerName);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('status', instance.status);
  return val;
}
