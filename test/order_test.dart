import 'dart:convert';

import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/database_helper.dart';
import 'package:bingo/data_models/models/all_order_model/all_order_model.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/order_details/order_details.dart';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
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
    final service = MockRepositoryOrder();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Order: list", () async {
      when(service.getAllOrder(1))
          .thenAnswer((realInvocation) => Future<dynamic>.value(
                [],
              ));
      Utils.itemSuccess("Order: list get success");
    });
    test("Order: details", () async {
      when(service.getDetails('1')).thenAnswer((realInvocation) =>
          Future<OrderDetail>.value(OrderDetail(success: true)));
      Utils.itemSuccess("Order: details get success");
    });

    test("Order: create", () async {
      when(service.createOrder({})).thenAnswer((realInvocation) =>
          Future<ResponseMessageModel>.value(
              ResponseMessageModel(success: true)));
      Utils.itemSuccess("Order: create success");
    });

    test("Check order api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.retailerOrderList,
        token: Utils.token,
      );
      AllOrderModel data = AllOrderModel.fromJson(responseBody);
      List<dynamic> checkedData = jsonDecode(jsonEncode(data.data!.data!));
      //check data list
      for (int i = 0; i < checkedData.length; i++) {
        Map<String, dynamic> accountBalanceModel =
            checkDataTypesSimple(checkedData[i]);

        //check data list
        accountBalanceModel.forEach((key, value) {
          expect(accountBalanceModel[key],
              ExpectedDataTypeApiResponse.retailerOrderList[key]);
          Utils.itemCheck(0, i, key);
        });
        Utils.itemSuccess("index $i: success");
      }

      Utils.successTest("Check order list model: ");
    });

    test("Check order details api model", () async {
      Map<String, dynamic> responseBody = await postListVerify(
          url: NetworkUrls.retailerOrderDetails,
          token: Utils.token,
          body: {"unique_id": "V1NbBllTYiXcxbGzjkTXE8xz700ZGosEuMkSsQtwFZ"});
      OrderDetail data = OrderDetail.fromJson(responseBody);
      Map<String, dynamic> checkedData = checkDataTypesSimple(
          jsonDecode(jsonEncode(data.data!.orderDetails![0])));

      //check data list
      checkedData.forEach((key, value) {
        expect(checkedData[key],
            ExpectedDataTypeApiResponse.retailerOrderDetails[key]);
        Utils.itemSuccess("$key: success");
      });
      for (int i = 0; i < data.data!.orderDetails![0].orderLogs!.length; i++) {
        Map<String, dynamic> orderLogs = checkDataTypesSimple(
            jsonDecode(jsonEncode(data.data!.orderDetails![0].orderLogs![i])));

        //check data list
        orderLogs.forEach((key, value) {
          expect(orderLogs[key],
              ExpectedDataTypeApiResponse.retailerOrderDetailsOrderLogs[key]);
          Utils.itemSuccess("Order log $key: success");
        });
      }

      Utils.successTest("Check Order list model: ");
    });
  });
}
