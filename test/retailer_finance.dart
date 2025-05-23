import 'dart:convert';

import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/database_helper.dart';
import 'package:bingo/data_models/models/all_order_model/all_order_model.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/order_details/order_details.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import 'package:bingo/data_models/models/retailer_fiancial_statement_model/retailer_fiancial_statement_model.dart';
import 'package:bingo/data_models/models/retailer_settlement_list_model/retailer_settlement_list_model.dart';
import 'package:bingo/services/network/network_urls.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'data_table/data_type_checker.dart';
import 'data_table/expected_data_type_api_response.dart';
import 'data_table/get_list_test.dart';
import 'data_table/utils.dart';
import 'helper/test_helper.mocks.dart';
import 'helper/test_helper.dart';
import 'retailer_request_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final webService = MockWebService();
  ConstantEnvironment.setEnvironment(Environment.qa);
  setupSqfliteForTest();
  await locatorSetup();
  MockDatabaseHelper database;
  group('Sale functions', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Finance: list function", () async {
      when(service.getRetailerFinancialStatements(1, []))
          .thenAnswer((realInvocation) => Future<dynamic>.value(
                [],
              ));
      Utils.itemSuccess("Finance: list get success");
    });
    test("CreditLine: list function", () async {
      when(service.getRetailerCreditlineList()).thenAnswer((realInvocation) =>
          Future<RetailerApproveCreditlineRequest>.value(
              RetailerApproveCreditlineRequest(success: true)));
      Utils.itemSuccess("CreditLine: list get success");
    });
    test("Settlement: list function", () async {
      when(service.getRetailerSettlementList('1'))
          .thenAnswer((realInvocation) => Future<dynamic>.value(
                [],
              ));
      Utils.itemSuccess("Settlement: list get success");
    });

    test("Check CreditLine api model", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerApprovedCreditLinesList,
        token: Utils.token,
      );
      RetailerApproveCreditlineRequest data =
          RetailerApproveCreditlineRequest.fromJson(responseBody);

      for (int i = 0; i < data.data!.length; i++) {
        Map<String, dynamic> financialApproveCreditline =
            checkDataTypesSimple(jsonDecode(jsonEncode(data.data![i])));

        //check data list
        financialApproveCreditline.forEach((key, value) {
          print(key);
          expect(financialApproveCreditline[key],
              ExpectedDataTypeApiResponse.financeCreditlineList[key]);
          Utils.itemSuccess("Finance Creditline log $key: success");
        });
      }

      Utils.successTest("Check Finance Creditline list model: ");
    });

    test("Check Finance Statement api model", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerFinancialStatementsList,
        token: Utils.token,
      );
      RetailerFinancialStatementModel data =
          RetailerFinancialStatementModel.fromJson(responseBody);

      for (int i = 0; i < data.data!.financialStatements!.data!.length; i++) {
        Map<String, dynamic> financialStatements = checkDataTypesSimple(
            jsonDecode(jsonEncode(data.data!.financialStatements!.data![i])));

        //check data list
        financialStatements.forEach((key, value) {
          print(key);
          expect(financialStatements[key],
              ExpectedDataTypeApiResponse.financeStatementList[key]);
          Utils.itemSuccess("Finance Statement log $key: success");
        });
      }

      Utils.successTest("Check Finance Statement list model: ");
    });

    test("Check Finance Settlement api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: '${NetworkUrls.retailerSettlementList}/1',
        token: Utils.token,
      );
      List<SettlementsListData> data = responseBody['data']['data']
          .map((d) => SettlementsListData.fromJson(d))
          .toList();
      // value.map((d) => SettlementsListData.fromJson(d)).toList()
      //     SettlementsListData.fromJson(responseBody['data']['data']);

      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> financialSettlement =
            checkDataTypesSimple(jsonDecode(jsonEncode(data[i])));

        //check data list
        financialSettlement.forEach((key, value) {
          print(key);
          expect(financialSettlement[key],
              ExpectedDataTypeApiResponse.financeSettlementList[key]);
          Utils.itemSuccess("Finance Settlement log $key: success");
        });
      }

      Utils.successTest("Check Finance Settlement list model: ");
    });
  });
}
