import 'dart:convert';

import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/database_helper.dart';
import 'package:bingo/data_models/models/all_order_model/all_order_model.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/order_details/order_details.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/data_models/models/retailer_associated_wholesaler_list/retailer_associated_wholesaler_list.dart';
import 'package:bingo/data_models/models/retailer_association_fie_list/retailer_association_fie_list.dart';
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
  ConstantEnvironment.setEnvironment(Environment.qa);
  setupSqfliteForTest();
  await locatorSetup();
  MockDatabaseHelper database;
  group('Wholesaler', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Wholesaler: list", () async {
      when(service.getWholesaler())
          .thenAnswer((realInvocation) => Future<dynamic>.value(
                [],
              ));
      Utils.itemSuccess("Wholesaler: list get success");
    });
    test("Check Wholesaler api model", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerAssociatedWholesalerList,
        token: Utils.token,
      );
      RetailerAssociatedWholesalerList data =
          RetailerAssociatedWholesalerList.fromJson(responseBody);

      for (int i = 0; i < data.data!.length; i++) {
        Map<String, dynamic> checkedData =
            checkDataTypesSimple(jsonDecode(jsonEncode(data.data![i])));

        //check data list
        checkedData.forEach((key, value) {
          expect(checkedData[key],
              ExpectedDataTypeApiResponse.wholesalerListWithDetails[key]);
          Utils.itemSuccess("Wholesaler log $key: success");
        });
      }

      Utils.successTest("Check Wholesaler list model: ");
    });
  });
  group('Fie', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Fie: list", () async {
      when(service.getFia())
          .thenAnswer((realInvocation) => Future<dynamic>.value(
                [],
              ));
      Utils.itemSuccess("Fie: list get success");
    });
    test("Check Fie api model", () async {
      Map<String, dynamic> responseBody = await postListVerify(
        url: NetworkUrls.retailerAssociatedFieList,
        token: Utils.token,
      );
      RetailerAssociationFieList data =
          RetailerAssociationFieList.fromJson(responseBody);
      expect(checkDataTypesSimple(jsonDecode(jsonEncode(data))),
          ExpectedDataTypeApiResponse.paginationDataResponse);
      Utils.itemSuccess('pagination checked success');
      for (int i = 0; i < data.data!.data!.length; i++) {
        Map<String, dynamic> checkedData =
            checkDataTypesSimple(jsonDecode(jsonEncode(data.data!.data![i])));

        //check data list
        checkedData.forEach((key, value) {
          expect(checkedData[key],
              ExpectedDataTypeApiResponse.fieListWithDetails[key]);
          Utils.itemSuccess("Fie log $key: success");
        });
      }

      Utils.successTest("Check Wholesaler list model: ");
    });
  });
}
