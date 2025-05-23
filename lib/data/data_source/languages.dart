import '/const/app_assets.dart';

List<AllLanguage> allLanguages = [
  AllLanguage(language: "English", code: "en", file: AppAsset.englishFlag),
  AllLanguage(language: "Spanish", code: "es", file: AppAsset.spanishFlag)
];

class AllLanguage {
  String? language;
  String? code;
  String? file;

  AllLanguage({this.language, this.code, this.file});

  AllLanguage.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    code = json['code'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['language'] = language;
    data['code'] = code;
    data['file'] = file;
    return data;
  }
}
