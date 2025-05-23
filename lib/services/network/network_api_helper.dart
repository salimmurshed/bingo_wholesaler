import 'dart:convert';

import 'package:http/http.dart' as http;

dynamic apiResponse({required http.Response response}) {
  // if (response == null) return null;

  if (response.body.isEmpty) return null;
  switch (response.statusCode) {
    case 200:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;

    case 400:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;

    case 401:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;

    case 403:
      return null;

    case 404:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;

    default:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;
  }
}
