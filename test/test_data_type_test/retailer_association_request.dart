import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/sale_details_transection_model/sale_details_transection_model.dart';
import 'package:bingo/services/network/network_urls.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:bingo/app/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:bingo/repository/repository_sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_table/data_type_checker.dart';
import '../data_table/expected_data_type_api_response.dart';
import '../data_table/get_list_test.dart';
import '../data_table/utils.dart';
import '../helper/mock_path_provider.dart';
import '../helper/test_helper.config.dart';
import '../helper/test_helper.mocks.dart';
import '../helper/test_helper.dart';

MockConnectivity? mockConnectivity;

Future<void> locatorSetup() => locator.testInit();
Future<void> main() async {
  const MethodChannel connectivityChannel =
      MethodChannel('dev.fluttercommunity.plus/connectivity');
  String token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiYTYxN2JhNTM2YmI0NWEyYzFkYWNkNjNkM2MzMzNiZjI4NmU1OTdjN2QzMTg1YTQ1MzFhZGFlYTAwZjllMDdjY2M5NGNhMTViYjYwZDI2ZjUiLCJpYXQiOjE3MjA0NDIyNzAuNDkyODY3LCJuYmYiOjE3MjA0NDIyNzAuNDkyODcxLCJleHAiOjE3NTE5NzgyNzAuNDg2NTUxLCJzdWIiOiIyMzQiLCJzY29wZXMiOltdfQ.MKxu7mOVtBCOpAVCx0AbNZUxmrriyof5q0gDQxYCwV-xDDbPvdXxHBzuHUfOQxrS35qdlkQWyWP24utyXOSSWLCUFh790KAYeSneJddVxlGmT7lhaH_0U9XxUh2pK1untSYUsBtSAqjJtPRDo_eXZJpWsjGIqgpgxAmRvAnyyCbW5imkM-2-0e3lBSlkHP1-6zC9GqHuG_KEXTQwG0qkjD9qttMXpH8px5j7KZ_opyOBXGlpIglKn4ACn3XtJM-7gXb5RcFVP95HpMD4nYfYWjZ2utCVtssgLdYIr_EJHMfZb66BO-y2RJWAwBaC-LmcGDWSQ53RWsskcD_Es-DR575bO-iq-nqbiOnjpqHWNl5aZmLwJT6ZuXJKbyJ3-k9jM5SM3YJWHOGC_5MfkNqBmbzGvmdY6NToSa8CIcqCh_9LuLsM9NlaZ2ySkQ6c1IGrhxcEz-2AhWix0UKC09FHo_QgKwEBh11LdBVxZiH02Ffh9kCm3RFlY6lHPlrYAnzwnEC-F4YMkiTs4fnVa1FddHWp2hP0hzDt1llSpKsnfoeptpP8qqAFRAGBieOIYp1fKf3Uf1_7L6KUBq8PpNdrMaSg0zHutPth2-aOyixwUVaBq2lqwWa9uR4P4ORc8Ht3D1tJcrTPVNJm32Q_U7C8MYqUFVF4Rbru8b6xDWE8Jh4';

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await locatorSetup();
  });
  SharedPreferences.setMockInitialValues({});
  tearDown(() async {
    unregisterServices();
  });
  ConstantEnvironment.setEnvironment(Environment.qa);
  PathProviderPlatform.instance = FakePathProviderPlatform();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final path = join('test', 'your_database.db');

  Directory directory = Directory(path);

  // final databaseService = MockDatabaseHelper();
  if (await directory.exists()) {
    await directory.create(recursive: true);
  }

  group('Association request', () {
    test("Wholesaler association request list", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.requestAssociationList,
        token: token,
        // body: {'per_page': '10', 'page': '1'},
      );

      //check model without data list
      for (int i = 0; i < responseBody['data'].length; i++) {
        var saleDataTransList = checkDataTypesSimple(responseBody['data'][i]);
        saleDataTransList.forEach((key, value) {
          expect(saleDataTransList[key],
              ExpectedDataTypeApiResponse.retailerAssociationList[key]);
          Utils.singleItemSuccess("$key:");
        });
        Utils.successTest("index $i");
      }

      Utils.successTest('Wholesaler association request list success');
    });

    test("Wholesaler association request details", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.viewRetailerWholesalerAssociationRequest,
        token: token,
        body: {'unique_id': 'b1dN9xH8fAfuOhwmfBHmVIhSA2lSsrLLd4L2gIl6XI'},
      );

      var companyInformation = checkDataTypesSimple(
          responseBody['data'][0]['company_information'][0]);
      var contactInformation = checkDataTypesSimple(
          responseBody['data'][0]['contact_information'][0]);
      companyInformation.forEach((key, value) {
        expect(
          companyInformation[key],
          ExpectedDataTypeApiResponse
              .retailerAssociationListDetails['company_information'][key],
        );
        Utils.singleItemSuccess("$key:");
      });
      Utils.successTest("Check company information: ");

      contactInformation.forEach((key, value) {
        expect(
          contactInformation[key],
          ExpectedDataTypeApiResponse
              .retailerAssociationListDetails['contact_information'][key],
        );
        Utils.singleItemSuccess("$key:");
      });
      Utils.successTest("Check contact information: ");
    });

    test("Fie association request list", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.requestFieAssociationList,
        token: token,
        // body: {'per_page': '10', 'page': '1'},
      );

      //check model without data list
      for (int i = 0; i < responseBody['data'].length; i++) {
        var singleReq = checkDataTypesSimple(responseBody['data'][i]);

        singleReq.forEach((key, value) {
          expect(singleReq[key],
              ExpectedDataTypeApiResponse.retailerFieAssociationList[key]);
          Utils.singleItemSuccess("$key:");
        });
        Utils.successTest("index $i");
      }

      Utils.successTest('Fie association request list test');
    });

    test("Fie association request details", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.viewRetailerFieAssociationRequest,
        token: token,
        body: {'unique_id': 'XxV6nOPO7A1Mv0pH8098Dcu2zDlnXj9MV7GzeiajJK'},
      );

      var companyInformation = checkDataTypesSimple(
          responseBody['data'][0]['company_information'][0]);
      var contactInformation = checkDataTypesSimple(
          responseBody['data'][0]['contact_information'][0]);
      companyInformation.forEach((key, value) {
        expect(
            companyInformation[key],
            ExpectedDataTypeApiResponse
                .retailerFieAssociationListDetails['company_information'][key]);
        Utils.singleItemSuccess("$key:");
      });
      Utils.successTest("Check company information: ");

      contactInformation.forEach((key, value) {
        expect(
          contactInformation[key],
          ExpectedDataTypeApiResponse
              .retailerFieAssociationListDetails['contact_information'][key],
        );
        Utils.singleItemSuccess("$key:");
      });
      Utils.successTest("Check contact information: ");
    });
  });
}

Future<void> getData() async {
  var data = {
    "unique_id": "b1dN9xH8fAfuOhwmfBHmVIhSA2lSsrLLd4L2gIl6XI",
    "bp_id_w": "0xBXi2ebP2D0BwkPpindC7JJhVBdCLxEueOlBrdLnzP1",
    "company_name": "Macmillian Stores",
    "tax_id": "7777665665",
    "association_date": "2024-06-28 08:55:34",
    "company_address": "",
    "status": "Pending",
    "status_fie": "Pending"
  };
  var data1 = {
    "first_name": "Preston",
    "last_name": "Gamella",
    "position": null,
    "id": "777776565556",
    "phone_number": "9877767876543",
    "company_document": [
      {"url": "", "name": ""}
    ]
  };
  print(jsonEncode(checkDataTypesSimple(data)));
  print(jsonEncode(checkDataTypesSimple(data1)));
}
