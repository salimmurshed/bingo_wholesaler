class PaymentMethodsModel {
  bool? success;
  String? message;
  List<Data>? data;

  PaymentMethodsModel({this.success, this.message, this.data});

  PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? uniqueId;
  String? paymentMethod;
  String? country;

  Data({this.id, this.uniqueId, this.paymentMethod, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    paymentMethod = json['payment_method'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['payment_method'] = paymentMethod;
    data['country'] = country;
    return data;
  }
}
