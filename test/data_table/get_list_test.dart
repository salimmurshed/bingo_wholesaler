import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'data_type_checker.dart';
import 'expected_data_type_api_response.dart';
import 'utils.dart';

Future<Map<String, dynamic>> postListVerify<T>({
  required String url,
  required String token,
  Map<String, String>? body,
}) async {
  var head = ({
    'Accept': 'application/json',
    'Connection': 'Keep-Alive',
    'X-Route-Id': '',
    'X-Zone-Id': '',
    'Authorization': token,
    'X-localization': 'en'
  });
  Response response =
      await http.post(Uri.parse(url), headers: head, body: body);

  Map<String, dynamic> responseBody = jsonDecode(response.body);
  //check success
  expect(responseBody['success'], true);
  print('api connect success');

  return responseBody;
}

Future<Map<String, dynamic>> getListVerify<T>({
  required String url,
  required String token,
  Map<String, String>? body,
}) async {
  var head = ({
    'Accept': 'application/json',
    'Connection': 'Keep-Alive',
    'X-Route-Id': '',
    'X-Zone-Id': '',
    'Authorization': token,
    'X-localization': 'en'
  });
  Response response = await http.get(Uri.parse(url), headers: head);
  print(response.body);
  Map<String, dynamic> responseBody = jsonDecode(response.body);
  //check success

  expect(responseBody['success'], true);
  print('api connect success');

  return responseBody;
}
