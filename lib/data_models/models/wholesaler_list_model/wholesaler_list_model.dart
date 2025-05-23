import 'package:json_annotation/json_annotation.dart';
part 'wholesaler_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WholeSalerOrFiaListModel {
  bool? success;
  String? message;
  List<WholeSalerOrFiaListData>? data;

  WholeSalerOrFiaListModel({this.success, this.message, this.data});

  factory WholeSalerOrFiaListModel.fromJson(Map<String, dynamic> json) =>
      _$WholeSalerOrFiaListModelFromJson(json);
  Map<String, dynamic> toJson() => _$WholeSalerOrFiaListModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WholeSalerOrFiaListData {
  @JsonKey(defaultValue: '', name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: '', name: "name")
  String? name;

  WholeSalerOrFiaListData({this.uniqueId, this.name});

  factory WholeSalerOrFiaListData.fromJson(Map<String, dynamic> json) =>
      _$WholeSalerOrFiaListDataFromJson(json);
  Map<String, dynamic> toJson() => _$WholeSalerOrFiaListDataToJson(this);
}
