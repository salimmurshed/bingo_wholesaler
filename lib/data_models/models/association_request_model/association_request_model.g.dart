// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationRequestModel _$AssociationRequestModelFromJson(
        Map<String, dynamic> json) =>
    AssociationRequestModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => AssociationRequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssociationRequestModelToJson(
    AssociationRequestModel instance) {
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

AssociationRequestData _$AssociationRequestDataFromJson(
        Map<String, dynamic> json) =>
    AssociationRequestData(
      uniqueId: json['unique_id'] as String?,
      associationUniqueId: json['association_unique_id'] as String? ?? '',
      wholesalerName: json['wholesaler_name'] as String? ?? '',
      fieName: json['fie_name'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      status: json['status'] as String? ?? '',
      statusFie: json['status_fie'] as String? ?? '',
    );

Map<String, dynamic> _$AssociationRequestDataToJson(
    AssociationRequestData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('association_unique_id', instance.associationUniqueId);
  writeNotNull('wholesaler_name', instance.wholesalerName);
  writeNotNull('fie_name', instance.fieName);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('status', instance.status);
  writeNotNull('status_fie', instance.statusFie);
  return val;
}
