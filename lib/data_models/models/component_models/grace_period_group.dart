class GracePeriodGroupModel {
  bool? success;
  String? message;
  List<Data>? data;

  GracePeriodGroupModel({this.success, this.message, this.data});

  GracePeriodGroupModel.fromJson(Map<String, dynamic> json) {
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
  String? uniqueId;
  String? gracePeriodGroup;
  String? gracePeriodName;
  String? date;
  int? gracePeriodDays;
  Data(
      {this.gracePeriodGroup,
      this.uniqueId,
      this.gracePeriodName,
      this.date,
      this.gracePeriodDays});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    gracePeriodGroup = json['grace_period_group'] ?? "";
    gracePeriodName = json['grace_period_name'] ?? "";
    date = json['date'] ?? "";
    gracePeriodDays = json['grace_period_days'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['grace_period_group'] = gracePeriodGroup;
    data['grace_period_name'] = gracePeriodName;
    data['date'] = date;
    data['grace_period_days'] = gracePeriodDays;
    return data;
  }
}
