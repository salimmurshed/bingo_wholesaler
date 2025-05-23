import 'dart:io';

import 'package:bingo/app/app_config.dart';
import 'package:bingo/services/network/network_urls.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:bingo/repository/repository_sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'data_table/data_type_checker.dart';
import 'data_table/expected_data_type_api_response.dart';
import 'data_table/get_list_test.dart';
import 'data_table/utils.dart';
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
  // sqfliteFfiInit();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final webService = MockWebService();
  ConstantEnvironment.setEnvironment(Environment.qa);
  setupSqfliteForTest();
  await locatorSetup();
  MockDatabaseHelper database;
  setUpAll(() async {
    // PathProviderPlatform.instance = FakePathProviderPlatform();

    mockConnectivity = MockConnectivity();
    database = MockDatabaseHelper();
  });
  group('Retailer', () {
    final service = MockRepositoryRetailer();
    test("Create: wholesaler request", () async {
      when(service.sendWholesalerRequest(["test"])).thenAnswer((data) {
        print(data);
        return Future<void>.value();
      });
    });

    test("Create: fie request", () async {
      when(service.sendFiaRequest(["test"])).thenAnswer((data) {
        print(data);
        return Future<void>.value();
      });
    });

    test("List: wholesaler association request", () async {
      when(service.getRetailersAssociationData())
          .thenAnswer((realInvocation) => Future<dynamic>.value([]));
    });
    test("List: fie association request", () async {
      when(service.getRetailersFieAssociationData())
          .thenAnswer((realInvocation) => Future<dynamic>.value([]));
    });

    test("Details: wholesaler association request", () async {
      when(service.getRetailerAssociationDetails("test"))
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });
    test("Details: fie association request", () async {
      when(service.getRetailerFieAssociationDetails("test"))
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });

    var body = {
      'wholesaler[]': '1655677386xfk2YJHszkQ85NwhlgiwsrPMWeRsAaQavPGcXlBxEj',
      'currency[]': 'USD',
      'monthly_purchase[]': '35000',
      'average_purchase_tickets[]': '1500',
      'visit_frequency[]': '1',
      'requested_amount[]': '5000',
      'commercial_name_one': 'Ramon Martinez',
      'commercial_phone_one': '8095864534',
      'commercial_name_two': '',
      'commercial_phone_two': '',
      'commercial_name_three': '',
      'commercial_phone_three': '',
      'fie[]': '0xgzaTlwiAsNExpdZ6Z1p6yTpTPdDBCZw764NjXiDjys',
      'send_cl': '0',
      'selectedfie': '0xFw6r6seaTrdEttirbvkK4dPJTqoYKXAgnnqifqESLk',
      'auth_check': '1'
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('stringUrl'),
    );
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    List<File> files = [];
    test("Create: creditline request", () async {
      when(service.addCreditlineRequests(request, files))
          .thenAnswer((realInvocation) => Future<http.Response>.value(
                http.Response("", 200),
              ));
    });
    test("List: creditline request", () async {
      when(service.getCreditLinesList())
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });
    test("Details: creditline request", () async {
      when(service.getCreditLinesDetails('id'))
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });
  });
  group('Wholesaler', () {
    final service = MockRepositoryWholesaler();

    test("List: retailer association request", () async {
      when(service.getWholesalersAssociationData())
          .thenAnswer((realInvocation) => Future<dynamic>.value([]));
    });

    test("Details: retailer association request", () async {
      when(service.getWholesalersAssociationDetails("test"))
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });
    test("List: creditline request", () async {
      when(service.getCreditLinesList())
          .thenAnswer((realInvocation) => Future<dynamic>.value());
    });
  });
}

RepositorySales _getModel() => RepositorySales();
