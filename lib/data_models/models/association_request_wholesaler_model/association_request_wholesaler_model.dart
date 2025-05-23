import 'package:json_annotation/json_annotation.dart';
part 'association_request_wholesaler_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssociationRequestWholesalerModel {
  bool? success;
  String? message;
  List<AssociationRequestWholesalerData>? data;

  AssociationRequestWholesalerModel({this.success, this.message, this.data});

  factory AssociationRequestWholesalerModel.fromJson(
          Map<String, dynamic> json) =>
      _$AssociationRequestWholesalerModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AssociationRequestWholesalerModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssociationRequestWholesalerData {
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: "", name: "association_unique_id")
  String? associationUniqueId;
  @JsonKey(defaultValue: "", name: "retailer_name")
  String? retailerName;
  @JsonKey(defaultValue: "", name: "phone_number")
  String? phoneNumber;
  @JsonKey(defaultValue: "", name: "id")
  String? id;
  @JsonKey(defaultValue: "", name: "email")
  String? email;
  @JsonKey(defaultValue: "", name: "status")
  String? status;

  AssociationRequestWholesalerData(
      {this.uniqueId,
      this.associationUniqueId,
      this.retailerName,
      this.phoneNumber,
      this.id,
      this.email,
      this.status});

  factory AssociationRequestWholesalerData.fromJson(
          Map<String, dynamic> json) =>
      _$AssociationRequestWholesalerDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AssociationRequestWholesalerDataToJson(this);
}
