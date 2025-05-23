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

  group('PathProvider full implementation', () {
    test("Check sale list", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerSalesList,
        token: token,
        body: {'per_page': '10', 'page': '1'},
      );
      AllSalesModel allSales = AllSalesModel.fromJson(responseBody);
      //check model without data list
      expect(checkDataTypesSimple(jsonDecode(jsonEncode(allSales))),
          ExpectedDataTypeApiResponse.paginationDataResponse);
      Utils.itemSuccess('pagination checked success');
      Utils.itemSuccess(
          'checking page ${allSales.data!.currentPage ?? 0} data');
      for (int i = 0; i < allSales.data!.data!.length; i++) {
        AllSalesData allSalesData = allSales.data!.data![i];
        Map<String, dynamic> saleDataList =
            checkDataTypesSimple((allSalesData.toJson()));

        //check data list
        saleDataList.forEach((key, value) {
          expect(saleDataList[key], ExpectedDataTypeApiResponse.saleList[key]);
          Utils.itemCheck(allSales.data!.currentPage ?? 0, i, key);
        });
        Utils.itemSuccess("index $i: success");
      }
      Utils.successTest(
          'Check sale list page ${allSales.data!.currentPage} data:');
    });

    test("Check sale details", () async {
      // getData();
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerSalesDetails,
        token: token,
        body: {
          'unique_id': '1719209168tZsx516rtXNuxUHuQQdEgEBbNbmUStB2qBqktAMBX3'
        },
      );

      //check model without data list
      var saleDataList = checkDataTypesSimple(responseBody['data'][0]);
      saleDataList.forEach((key, value) {
        expect(
          saleDataList[key],
          ExpectedDataTypeApiResponse.saleDetailsRetailer[key],
        );
        Utils.singleItemSuccess("$key:");
      });

      Utils.successTest("Check sale details: ");

      for (int i = 0;
          i < responseBody['data'][0]['tranction_details'].length;
          i++) {
        var saleDataTransList = checkDataTypesSimple(
            responseBody['data'][0]['tranction_details'][i]);
        saleDataTransList.forEach((key, value) {
          expect(saleDataTransList[key],
              ExpectedDataTypeApiResponse.saleDetailsTransactionRetailer[key]);
          Utils.singleItemSuccess("$key:");
        });
        Utils.itemSuccess("index $i: success");
      }
      Utils.successTest("Check sale transaction: ");
    });
  });
}

Future<void> getData() async {
  var data = {
    "wholesaler_name": "Wholesaler Dummy",
    "fie_name": "FIE Dummy",
    "sale_date": "2024-06-24 02:06:08",
    "due_date": "2024-07-03 23:59:59",
    "currency": "DOP",
    "amount": "10.0000",
    "invoice_number": "INV00060",
    "order_number": "-",
    "bingo_store_id": "1696444849vMABjfxSDDsNI8MY82nMTqp1Uyk93LjKvfesbiGzTL",
    "sales_step": "1S",
    "description": "Retest",
    "status": 1,
    "status_description": "Sale Approved/Delivered",
    "is_start_payment": 1,
    "tranction_details": []
  };
  var data1 = {
    "sale_unique_id": "1719209168tZsx516rtXNuxUHuQQdEgEBbNbmUStB2qBqktAMBX3",
    "invoice": "INV00060",
    "currency": "DOP",
    "document_type": "Sale",
    "document_id": "1719209193KvneRbcq5arH37pY4W6G5hX4d7xAyxLh3colOS3WJX",
    "settlement_unique_id": null,
    "collection_lot_id": null,
    "posting_date": "2024-06-24 06:06:33",
    "store_name": "Colmado Alcantara",
    "retailer_name": "Colmado Alcantara",
    "status": 2,
    "date_generated": "2024-06-24 02:06:33",
    "due_date": "2024-07-03 23:59:59",
    "amount": "10.0000",
    "open_balance": "10.0000",
    "applied_amount": "0.0000",
    "status_description": "Over Due",
    "contract_account": "Retailer"
  };
  print(jsonEncode(checkDataTypesSimple(data)));
  print(jsonEncode(checkDataTypesSimple(data1)));
}
