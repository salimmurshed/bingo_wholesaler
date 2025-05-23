class GetCompanyProfile {
  bool? success;
  String? message;
  Data? data;

  GetCompanyProfile({this.success, this.message, this.data});

  GetCompanyProfile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? commercialName;
  String? mainProducts;
  String? dateFounded;
  String? websiteUrl;
  String? aboutUs;
  String? information;
  String? logo;

  Data(
      {this.commercialName,
      this.mainProducts,
      this.dateFounded,
      this.websiteUrl,
      this.aboutUs,
      this.information,
      this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    commercialName = json['commercial_name'] ?? "";
    mainProducts = json['main_products'] ?? "";
    dateFounded = json['date_founded'] ?? "";
    websiteUrl = json['website_url'] ?? "";
    aboutUs = json['about_us'] ?? "";
    information = json['information'] ?? "";
    logo = json['logo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commercial_name'] = commercialName;
    data['main_products'] = mainProducts;
    data['date_founded'] = dateFounded;
    data['website_url'] = websiteUrl;
    data['about_us'] = aboutUs;
    data['information'] = information;
    data['logo'] = logo;
    return data;
  }
}
