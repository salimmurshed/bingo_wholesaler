import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
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
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMWI3OWQwMGM0ZDU1NWQyNTE5ZGRiZDhlZWNjNDM2ZmU1M2E2MmI3YmViOWEyNjA5YTcwYzRkNTIyZjQxOWJkOTEyZGFhNTcyZTE4ZTg2NjIiLCJpYXQiOjE3MjAwNjg5MjUuMzkzOTQzLCJuYmYiOjE3MjAwNjg5MjUuMzkzOTQ2LCJleHAiOjE3NTE2MDQ5MjUuMzg3MjY0LCJzdWIiOiIyMTkiLCJzY29wZXMiOltdfQ.LY4YqxgKtvnbKB3vY_R5AANx_gvaIuZUZqinOfztar-UuJjOgvrvNxaWUO_3fv8WqR_gVPRRqCPK0pMb4bky_hnt3UdlXjwOkDXAOL80smKPtV67Kg9DlsXWMsn9yQH5fHeMhBTP5KvYceXE4c3tHrsPvpGa32FKIEsEjdWVpEj_pyn-UZQNy1gOKQY1E8BavPgC5LvMEO1N7U1YkewCvbXpx3fPPI3LQqgK50pLvK_Cs6zD1gN30pFcGNBY5DkvxfHzaua2_A6a2ElU0qNo8wT1ocxmM7hBRO9ZNso0q_AMw0ZLUf1kfODVNXjMvVELObIEEVZhM9P0xuxZnEHr9UTwJ6LT1WB6L5qq9L4ih2dyxE-j8rw5EbFcpkgAeXWgKfRwU5MCsB1l51VXZBFsnq6NMA2nAL3J_IejLx4P8n-zZ50qTW2WhYhvmMxsk5s9S27F4wkByUu910Wa3282FkCI2Ju6iCeSn4xaMlpcJKTRjXWJjupQAhjvWkRS1F2dA5SsnRzc7eBRfOOdrZYE8MwZ6rBkWUadE1lhPzRzJaU2e-CamlhBn9jbzuzkal5fbpFx8iED7VWCvO2N6TcHeJ9HjldqXVKCty2lA-oJhnQTSrSLGu8-niHkuD2FwzXDCpa1YwxFj2Z4R0oxG8uyPa1l12wxABVX-kftqO-BwRM';

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await locatorSetup();
    // await registerServices();
    // final mockLocalData = MockLocalData();
    // locator.registerSingleton<LocalData>((mockLocalData));
    // TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
    //     .setMockMethodCallHandler(
    //         MethodChannel('dev.fluttercommunity.plus/connectivity'),
    //         (MethodCall methodCall) {});
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
    test('insert and retrieve data', () async {
      Database db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE sale ("
            "name TEXT  NOT NULL"
            ")");
      });

      int id = await db.insert("sale", {'name': 'Test Item'});
      final items = await db.query("sale");

      // expect(id, 3);
      expect(items.isNotEmpty, true);
      expect(items.first['name'], 'Test Item');
    });
    test("add sale", () async {
      Map<String, String> body = {
        'bp_id_r': '0xKtW0NgQSpQIt3fScQ3aWiDmGuLmA07HPKamtW1hPQf',
        'store_id': '1696444849vMABjfxSDDsNI8MY82nMTqp1Uyk93LjKvfesbiGzTL',
        'wholesaler_store_id':
            '1687516866HezV3fkcXrrcYieQiYVYbNzw5UaHIojb3YIFFGRY3W',
        'sale_type': '1S',
        'invoice_number': 'test',
        'order_number': '',
        'currency': 'DOP',
        'amount': '1',
        'description': '',
        'w_route_zone_id': '0'
      };
      String url = NetworkUrls.addSales;
      final client = MockClient();
      String token =
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMWI3OWQwMGM0ZDU1NWQyNTE5ZGRiZDhlZWNjNDM2ZmU1M2E2MmI3YmViOWEyNjA5YTcwYzRkNTIyZjQxOWJkOTEyZGFhNTcyZTE4ZTg2NjIiLCJpYXQiOjE3MjAwNjg5MjUuMzkzOTQzLCJuYmYiOjE3MjAwNjg5MjUuMzkzOTQ2LCJleHAiOjE3NTE2MDQ5MjUuMzg3MjY0LCJzdWIiOiIyMTkiLCJzY29wZXMiOltdfQ.LY4YqxgKtvnbKB3vY_R5AANx_gvaIuZUZqinOfztar-UuJjOgvrvNxaWUO_3fv8WqR_gVPRRqCPK0pMb4bky_hnt3UdlXjwOkDXAOL80smKPtV67Kg9DlsXWMsn9yQH5fHeMhBTP5KvYceXE4c3tHrsPvpGa32FKIEsEjdWVpEj_pyn-UZQNy1gOKQY1E8BavPgC5LvMEO1N7U1YkewCvbXpx3fPPI3LQqgK50pLvK_Cs6zD1gN30pFcGNBY5DkvxfHzaua2_A6a2ElU0qNo8wT1ocxmM7hBRO9ZNso0q_AMw0ZLUf1kfODVNXjMvVELObIEEVZhM9P0xuxZnEHr9UTwJ6LT1WB6L5qq9L4ih2dyxE-j8rw5EbFcpkgAeXWgKfRwU5MCsB1l51VXZBFsnq6NMA2nAL3J_IejLx4P8n-zZ50qTW2WhYhvmMxsk5s9S27F4wkByUu910Wa3282FkCI2Ju6iCeSn4xaMlpcJKTRjXWJjupQAhjvWkRS1F2dA5SsnRzc7eBRfOOdrZYE8MwZ6rBkWUadE1lhPzRzJaU2e-CamlhBn9jbzuzkal5fbpFx8iED7VWCvO2N6TcHeJ9HjldqXVKCty2lA-oJhnQTSrSLGu8-niHkuD2FwzXDCpa1YwxFj2Z4R0oxG8uyPa1l12wxABVX-kftqO-BwRM';
      var head = ({
        'Accept': 'application/json',
        // 'content-type': 'application/json',
        'Connection': 'Keep-Alive',
        'X-Route-Id': '',
        'X-Zone-Id': '',
        'Authorization': token,
        'X-localization': 'en'
      });
      Response response =
          await http.post(Uri.parse(url), headers: head, body: body);

      ResponseMessageModel data =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      var responseRunType = {
        "success": data.success.runtimeType,
        "message": data.message.runtimeType,
        "data": data.data.runtimeType
      };

      var actual = (responseRunType).toString();

      expect(actual, ExpectedDataTypeApiResponse.addSaleDataType);
    });

    test("Check sale list", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.salesList,
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
        url: NetworkUrls.getSaleDetails,
        token: token,
        body: {'unique_id': 'i98liq8HwjLBxw9uzgvbRHxs5s6FfKztEYH0ZlOMWC'},
      );

      //check model without data list
      var saleDataList = checkDataTypesSimple(responseBody['data'][0]);
      saleDataList.forEach((key, value) {
        expect(
          saleDataList[key],
          ExpectedDataTypeApiResponse.saleDataDetails[key],
        );
        Utils.singleItemSuccess("$key:");
      });

      Utils.successTest("Check sale details: ");
    });
  });
}

Future<void> getData() async {
  // var data = {
  //   "success": true,
  //   "message": "Sales List.",
  //   "data": {
  //     "current_page": 1,
  //     "first_page_url": "http://100.27.47.144/api/sales-list?page=1",
  //     "from": 1,
  //     "last_page": 9,
  //     "last_page_url": "http://100.27.47.144/api/sales-list?page=9",
  //     "next_page_url": "http://100.27.47.144/api/sales-list?page=2",
  //     "path": "http://100.27.47.144/api/sales-list",
  //     "per_page": "10",
  //     "prev_page_url": null,
  //     "to": 10,
  //     "total": 88
  //   }
  // };
  print(checkDataTypesSimple(({"sub_sales": []})));
}
