class AllCityModel {
  bool? success;
  String? message;
  List<AllCityDataModel>? data;

  AllCityModel({this.success, this.message, this.data});

  AllCityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllCityDataModel>[];
      json['data'].forEach((v) {
        data!.add(AllCityDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCityDataModel {
  String? city;

  AllCityDataModel({this.city});

  AllCityDataModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    return data;
  }
}
