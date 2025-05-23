// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wholesaler_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholeSalerOrFiaListModel _$WholeSalerOrFiaListModelFromJson(
        Map<String, dynamic> json) =>
    WholeSalerOrFiaListModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              WholeSalerOrFiaListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WholeSalerOrFiaListModelToJson(
    WholeSalerOrFiaListModel instance) {
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

WholeSalerOrFiaListData _$WholeSalerOrFiaListDataFromJson(
        Map<String, dynamic> json) =>
    WholeSalerOrFiaListData(
      uniqueId: json['unique_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$WholeSalerOrFiaListDataToJson(
    WholeSalerOrFiaListData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('name', instance.name);
  return val;
}
