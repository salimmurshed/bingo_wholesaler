// part 'store_model.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class StoreModel {
//   bool? success;
//   String? message;
//   List<StoreData>? data;
//
//   StoreModel({this.success, this.message, this.data});
//
//   factory StoreModel.fromJson(Map<String, dynamic> json) =>
//       _$StoreModelFromJson(json);
//   Map<String, dynamic> toJson() => _$StoreModelToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class StoreData {
//   @JsonKey(name: "unique_id")
//   String? uniqueId;
//   @JsonKey(defaultValue: '', name: "name")
//   String? name;
//   @JsonKey(defaultValue: '', name: "city")
//   String? city;
//   @JsonKey(defaultValue: '', name: "country")
//   String? country;
//   @JsonKey(defaultValue: '', name: "address")
//   String? address;
//   @JsonKey(defaultValue: '', name: "remarks")
//   String? remarks;
//   @JsonKey(defaultValue: '', name: "status")
//   String? status;
//   @JsonKey(defaultValue: '', name: "store_logo")
//   String? storeImage;
//   @JsonKey(defaultValue: '', name: "sign_board_photo")
//   String? signBoard;
//
//   StoreData(
//       {this.uniqueId,
//       this.name,
//       this.city,
//       this.country,
//       this.address,
//       this.remarks,
//       this.status,
//       this.storeImage,
//       this.signBoard});
//
//   factory StoreData.fromJson(Map<String, dynamic> json) =>
//       _$StoreDataFromJson(json);
//   Map<String, dynamic> toJson() => _$StoreDataToJson(this);
// }

class StoreModel {
  bool? success;
  String? message;
  List<StoreData>? data;

  StoreModel({this.success, this.message, this.data});

  StoreModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreData>[];
      json['data'].forEach((v) {
        data!.add(new StoreData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreData {
  String? uniqueId;
  String? name;
  String? city;
  String? address;
  String? remarks;
  String? status;
  String? country;
  String? storeLogo;
  String? signBoardPhoto;
  String? lat;
  String? long;

  StoreData(
      {this.uniqueId,
      this.name,
      this.city,
      this.address,
      this.remarks,
      this.status,
      this.country,
      this.storeLogo,
      this.signBoardPhoto,
      this.lat,
      this.long});

  StoreData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    name = json['name'] ?? "";
    city = json['city'] ?? "";
    address = json['address'] ?? "";
    remarks = json['remarks'] ?? "";
    status = json['status'] ?? "";
    country = json['country'] ?? "";
    storeLogo = json['store_logo'] ?? "";
    signBoardPhoto = json['sign_board_photo'] ?? "";
    lat = json['lattitude'] ?? "";
    long = json['longitude'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['address'] = this.address;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['country'] = this.country;
    data['store_logo'] = this.storeLogo;
    data['sign_board_photo'] = this.signBoardPhoto;
    data['lattitude'] = this.lat;
    data['longitude'] = this.long;
    return data;
  }
}
