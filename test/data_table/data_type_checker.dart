// Map<String, String> checkDataTypes(Map<String, dynamic> data) {
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';

Map<String, dynamic> checkDataTypes(dynamic data) {
  Map<String, dynamic> dataTypes = {};

  if (data is Map<String, dynamic>) {
    data.forEach((key, value) {
      dataTypes[key] = checkDataTypes(value);
    });
  } else if (data is List) {
    dataTypes['type'] = 'List';
    dataTypes['items'] = data.map((item) => checkDataTypes(item)).toList();
  } else {
    dataTypes['type'] = data.runtimeType.toString();
  }

  return dataTypes;
}

Map<String, dynamic> checkDataTypesSimple(Map<String, dynamic> data) {
  Map<String, dynamic> dataTypes = {};

  data.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      dataTypes[key] = checkDataTypesSimple(value);
    } else if (value is List<dynamic>) {
      dataTypes[key] = 'List<dynamic>';
    } else if (value is List<Map<String, dynamic>>) {
      dataTypes[key] = 'List<Map<String, dynamic>>';
    } else {
      if (value != null) {
        dataTypes[key] = value.runtimeType.toString();
      } else {
        print("\x1B[31mnull alert: $key \x1B[0m");
      }
    }
  });
  return dataTypes;
}
