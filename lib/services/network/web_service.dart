import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import '../../app/locator.dart';
import '../../data_models/models/user_model/user_model.dart';
import '../storage/db.dart';
import '../storage/device_storage.dart';
import 'network_info.dart';

@lazySingleton
class WebService {
  final http.Client _client = http.Client();
  String language = "en";

  String getLang() {
    if (_storage.getString(DataBase.userLanguage) == "") {
      Locale deviceLocale = window.locale;
      return deviceLocale.languageCode;
    } else {
      return _storage.getString(DataBase.userLanguage);
    }
  }

  Map<String, String> get headers {
    if (_storage.getString(DataBase.userType).toLowerCase() == "wholesaler") {
      if (_storage.getBool(DataBase.zoneRouterHeaderOption)) {
        if (_storage.getString(DataBase.selectedZoneRoute).isNotEmpty) {
          UserZoneRouteModel data = UserZoneRouteModel.fromJson(
              jsonDecode(_storage.getString(DataBase.selectedZoneRoute)));

          return {
            "Accept": "application/json",
            "HttpHeaders.contentTypeHeader": "application/json",
            "Connection": "Keep-Alive",
            "X-Route-Id": data.type == 2 ? data.uid! : '',
            "X-Zone-Id": data.type == 1 ? data.uid! : '',
            "Authorization": "Bearer ${_storage.getString(DataBase.userToken)}",
            "X-localization": getLang()
          };
        } else {
          return {
            "Accept": "application/json",
            "HttpHeaders.contentTypeHeader": "application/json",
            "Connection": "Keep-Alive",
            "X-Route-Id": '',
            "X-Zone-Id": '',
            "Authorization": "Bearer ${_storage.getString(DataBase.userToken)}",
            "X-localization": getLang()
          };
        }
      } else {
        return {
          "Accept": "application/json",
          "HttpHeaders.contentTypeHeader": "application/json",
          "Connection": "Keep-Alive",
          "X-Route-Id": '',
          "X-Zone-Id": '',
          "Authorization": "Bearer ${_storage.getString(DataBase.userToken)}",
          "X-localization": getLang()
        };
      }
    } else {
      var body = {
        "Accept": "application/json",
        "HttpHeaders.contentTypeHeader": "application/json",
        "Connection": "Keep-Alive",
        "Authorization": "Bearer ${_storage.getString(DataBase.userToken)}",
        "X-localization": getLang()
      };
      print('_storage.getString(DataBase.userStoreId)');
      print(_storage.getString(DataBase.userStoreId));
      if (_storage.getString(DataBase.userStoreId).isNotEmpty) {
        body.addAll({
          "X-Store-Id": _storage.getString(DataBase.userStoreId),
        });
      }
      return body;
    }
  }

  // Map<String, String> get headers2 =>
  //     _storage.getString(DataBase.userType).toLowerCase() == "wholesaler"
  //         ? {
  //             "Accept": "application/json",
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             "Authorization":
  //                 "Bearer ${_storage.getString(DataBase.userToken)}",
  //             "X-Route-Id": data.type == 2 ? data.id! : '',
  //             "X-Zone-Id": data.type == 1 ? data.id! : '',
  //             "X-localization": getLang()
  //           }
  //         : {
  //             "Accept": "application/json",
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             "Authorization":
  //                 "Bearer ${_storage.getString(DataBase.userToken)}",
  //             "X-Store-Id": _storage.getString(DataBase.userStoreId),
  //             "X-localization": getLang()
  //           };

  //service
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();

  // final http.Client _client = http.Client();
  NetworkInfoService networkInfo = locator<NetworkInfoService>();

  Future<Response> postRequest(String uri, jsonBody) async {
    log('headersAuthorization $headers["Authorization"]');
    try {
      Response response = await _client.post(
        Uri.parse(uri),
        headers: headers,
        body: jsonBody,
      );
      if (kIsWeb) {
        if (response.statusCode == 401) {
          await _storage.clearData();
        }
      }
      return response;
    } on Exception catch (e) {
      debugPrint("$e$uri");
      rethrow;
    }
  }

  Future<Response> getRequest(String uri) async {
    debugPrint(uri);
    if (await networkInfo.isConnected) {
      try {
        Response response = await _client.get(Uri.parse(uri), headers: headers);
        if (kIsWeb) {
          if (response.statusCode == 401) {
            await _storage.clearData();
          }
        }

        return response;
      } on Exception catch (e) {
        debugPrint("$e$uri");
        rethrow;
      }
    } else {
      throw Exception('BarException');
    }
  }

  Future<Response> deleteRequest(String uri) async {
    debugPrint(uri);
    if (await networkInfo.isConnected) {
      try {
        Response response =
            await _client.delete(Uri.parse(uri), headers: headers);
        return response;
      } on Exception catch (e) {
        // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
        debugPrint("$e$uri");
        rethrow;
      }
    } else {
      throw Exception('BarException');
    }
  }

  Future<Response> putRequest(String uri, jsonBody) async {
    debugPrint(uri);
    if (await networkInfo.isConnected) {
      try {
        Response response = await _client.put(
          Uri.parse(uri),
          headers: headers,
          body: jsonBody,
        );
        return response;
      } on Exception catch (e) {
        debugPrint("$e$uri");
        rethrow;
      }
    } else {
      throw Exception('BarException');
    }
  }

  http.MultipartRequest getResponse(String uri) {
    MultipartRequest request = http.MultipartRequest("POST", Uri.parse(uri));
    return request;
  }

  Future<http.Response> sendMultiPartRequest(
      String uri, MultipartRequest requests, List files) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri));
    request = requests;
    request.headers.addAll(headers);
    request.headers.addAll(
      {'Content-Type': 'multipart/form-data'},
    );
    try {
      List<http.MultipartFile> multipartFiles = [];
      if (files.isNotEmpty) {
        for (File file in files) {
          var f = await http.MultipartFile.fromPath("documents", file.path);
          multipartFiles.add(f);
        }
      }
      request.files.addAll(multipartFiles);
      http.Response response =
          await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      // debugPrint(responseData);
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<http.Response> sendImage(
      String uri, String fieldName, String files) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri));

    request.headers.addAll(headers);
    request.headers.addAll(
      {'Content-Type': 'multipart/form-data'},
    );

    try {
      List<http.MultipartFile> multipartFiles = [];
      var f = await http.MultipartFile.fromPath(fieldName, files);
      multipartFiles.add(f);
      request.files.addAll(multipartFiles);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<http.Response> sendMultiPartRequestForMultipleFile(
      String uri,
      MultipartRequest requests,
      List<http.MultipartFile> multipartFiles) async {
    var request = http.MultipartRequest("POST", Uri.parse(uri));
    request = requests;
    request.headers.addAll(headers);
    request.headers.addAll(
      {'Content-Type': 'multipart/form-data'},
    );

    try {
      request.files.addAll(multipartFiles);
      http.Response response =
          await http.Response.fromStream(await request.send());
      // final responseData = json.decode(response.body);
      // // debugPrint(responseData);
      // print('responseresponse');
      // print(response);
      return response;
    } on Exception catch (_) {
      rethrow;
    }
    // debugPrint('Uploaded! ${} ++ ${response.statusCode}');
  }
}
