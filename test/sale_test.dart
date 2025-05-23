import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/database_helper.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/services/network/network_urls.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'helper/test_helper.mocks.dart';
import 'helper/test_helper.dart';

MockConnectivity? mockConnectivity;
void setupSqfliteForTest() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future<Database> openInMemoryDatabase() async {
  setupSqfliteForTest();
  return await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final webService = MockWebService();
  ConstantEnvironment.setEnvironment(Environment.qa);
  setupSqfliteForTest();
  await locatorSetup();
  MockDatabaseHelper database;
  group('Sale functions', () {
    final service = MockRepositorySales();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("add sale", () async {
      Map<String, dynamic> body = {
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

      when(service.addSales(body)).thenAnswer((data) {
        print(data);
        return Future<AllSalesModel>.value(
          AllSalesModel(
            success: true,
          ),
        );
      });
    });
    test("edit sale", () async {
      Map<String, String> body = {
        DataBaseHelperKeys.uniqueId:
            '0xKtW0NgQSpQIt3fScQ3aWiDmGuLmA07HPKamtW1hPQf',
        DataBaseHelperKeys.invoiceNumber: 'test',
        DataBaseHelperKeys.orderNumber: 'test',
        DataBaseHelperKeys.amount: '1',
        DataBaseHelperKeys.description: 'test',
        DataBaseHelperKeys.routeZone: "0",
      };

      when(service.updateSales(body))
          .thenAnswer((realInvocation) => Future<AllSalesData>.value(
                AllSalesData(),
              ));
    });
    test("get sale details", () async {
      when(service.getWholesalersSalesData(1))
          .thenAnswer((realInvocation) => Future<AllSalesModel>.value(
                AllSalesModel(),
              ));
    });
    test("get sale & transaction details", () async {
      when(service.getSaleTransactionDetails(
              '0xKtW0NgQSpQIt3fScQ3aWiDmGuLmA07HPKamtW1hPQf'))
          .thenAnswer((realInvocation) => Future<List<TranctionDetails>>.value(
                [],
              ));
    });
    test("add sale model test", () async {
      Map<String, dynamic> body = {
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
      when(webService.postRequest(url, body)).thenAnswer((data) {
        print(data);
        return Future<Response>.value(Response(
            {
              "success": true,
              "message": "Sales created successfully.",
              "data": "kucRLM4Tu1XV6tv4v5bCC1YHf50bMb6Ed9X7kHoyTP"
            } as String,
            500));
      });
    });
  });
}
