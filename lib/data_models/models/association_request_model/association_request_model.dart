import 'package:json_annotation/json_annotation.dart';
part 'association_request_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssociationRequestModel {
  bool? success;
  String? message;
  List<AssociationRequestData>? data;

  AssociationRequestModel({this.success, this.message, this.data});

  factory AssociationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AssociationRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssociationRequestData {
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: "", name: "association_unique_id")
  String? associationUniqueId;
  @JsonKey(defaultValue: "", name: "wholesaler_name")
  String? wholesalerName;
  @JsonKey(defaultValue: "", name: "fie_name")
  String? fieName;
  @JsonKey(defaultValue: "", name: "phone_number")
  String? phoneNumber;
  @JsonKey(defaultValue: "", name: "id")
  String? id;
  @JsonKey(defaultValue: "", name: "email")
  String? email;
  @JsonKey(defaultValue: "", name: "status")
  String? status;
  @JsonKey(defaultValue: "", name: "status_fie")
  String? statusFie;

  AssociationRequestData(
      {this.uniqueId,
      this.associationUniqueId,
      this.wholesalerName,
      this.fieName,
      this.phoneNumber,
      this.id,
      this.email,
      this.status,
      this.statusFie});

  factory AssociationRequestData.fromJson(Map<String, dynamic> json) =>
      _$AssociationRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationRequestDataToJson(this);
}
