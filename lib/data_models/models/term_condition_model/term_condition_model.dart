class TermConditionModel {
  bool? success;
  String? message;
  List<TermConditionData>? data;

  TermConditionModel({this.success, this.message, this.data});

  TermConditionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TermConditionData>[];
      json['data'].forEach((v) {
        data!.add(TermConditionData.fromJson(v));
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

class TermConditionData {
  String? termsCondition;
  String? country;
  String? termsConditionFor;

  TermConditionData(
      {this.termsCondition, this.country, this.termsConditionFor});

  TermConditionData.fromJson(Map<String, dynamic> json) {
    termsCondition = json['terms_condition'];
    country = json['country'];
    termsConditionFor = json['terms_condition_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['terms_condition'] = termsCondition;
    data['country'] = country;
    data['terms_condition_for'] = termsConditionFor;
    return data;
  }
}
