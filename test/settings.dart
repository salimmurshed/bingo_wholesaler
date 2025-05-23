import 'dart:convert';

import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/special_key.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:bingo/data_models/models/component_models/response_model.dart';
import 'package:bingo/data_models/models/failure.dart';
import 'package:bingo/data_models/models/retailer_bank_account_balance_model/retailer_bank_account_balance_model.dart';
import 'package:bingo/services/network/network_urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final webService = MockWebService();
  ConstantEnvironment.setEnvironment(Environment.qa);
  setupSqfliteForTest();
  await locatorSetup();
  MockDatabaseHelper database;
  group('User', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Add: User", () async {
      var body = {
        SpecialKeys.firstName: "firstNameController.text",
        SpecialKeys.lastName: "lastNameController.text",
        SpecialKeys.email: "emailNameController.text",
        SpecialKeys.idType: "selectedTaxIdType!.taxIdType!",
        SpecialKeys.idDocument: "idDocumentNameController.text",
        SpecialKeys.storeIds: 'storeUniqueIds',
        SpecialKeys.roles: 'rolesUniqueIds',
        SpecialKeys.status: "0"
      };

      when(service.addEditUser(body, true)).thenAnswer((data) {
        // print(data);
        return Future<ResponseMessages>.value(
          ResponseMessages(success: true),
        );
      });
      Utils.itemSuccess("Test add/edit new: success");
    });

    test("User: Get list", () async {
      when(service.getRetailersUser(1))
          .thenAnswer((realInvocation) => Future<dynamic>.value());
      Utils.itemSuccess("Test get list: success");
    });
    test("Check user api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: "${NetworkUrls.retailerUsersList}1",
        token: Utils.token,
      );

      //check model without data list

      for (int i = 0; i < responseBody['data']['data'].length; i++) {
        Map<String, dynamic> userModel =
            checkDataTypesSimple(responseBody['data']['data'][i]);

        //check data list
        userModel.forEach((key, value) {
          expect(userModel[key],
              ExpectedDataTypeApiResponse.retailerSettingUserList[key]);
          Utils.itemCheck(responseBody['data']['current_page'] ?? 0, i, key);
        });
        Utils.itemSuccess("index $i: success");
      }

      Utils.successTest("Check user list model: ");
    });
  });
  group('Roles', () {
    final service = MockRepositoryComponents();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });

    test("Role: Get list", () async {
      when(service.getRetailerRolesList())
          .thenAnswer((realInvocation) => Future<dynamic>.value());
      Utils.itemSuccess("Test get list: success");
    });
    test("Check role api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.retailerRolesList,
        token: Utils.token,
      );

      //check model without data list

      for (int i = 0; i < responseBody['data'].length; i++) {
        Map<String, dynamic> userModel =
            checkDataTypesSimple(responseBody['data'][i]);

        //check data list
        userModel.forEach((key, value) {
          expect(userModel[key],
              ExpectedDataTypeApiResponse.retailerSettingRoleList[key]);
        });
        Utils.itemSuccess("index $i: success");
      }

      Utils.successTest("Check user list model: ");
    });
  });
  group('Stores', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('stringUrl'),
    );
    request.fields["name"] = 'locationNameController';
    request.fields["city"] = 'selectedCity';
    request.fields["address"] = 'addressController';
    request.fields["lattitude"] = 'lat';
    request.fields["longitude"] = 'long';
    request.fields["country"] = 'selectedCountry';
    request.fields["remark"] = 'remarkController';
    test("Create function: store", () async {
      when(service.addStoreRequests(
              request, 'frontBusinessPhoto', 'signBoardPhoto'))
          .thenAnswer((realInvocation) =>
              Future<http.Response>.value(http.Response("success", 200)));
      Utils.itemSuccess("Create store: success");
    });
    test("Update function: store", () async {
      when(service.updateStoreRequests(request)).thenAnswer((realInvocation) =>
          Future<http.Response>.value(http.Response("success", 200)));
      Utils.itemSuccess("Update store: success");
    });
    test("Active/Inactive: store", () async {
      var body = {"unique_id": 'testId'};
      when(service.changeRetailerStoreStatus(body)).thenAnswer(
          (realInvocation) =>
              Future<http.Response>.value(http.Response("success", 200)));
      Utils.itemSuccess("Active/Inactive store: success");
    });

    test("Check Store api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.storeUrl,
        token: Utils.token,
      );

      //check model without data list

      for (int i = 0; i < responseBody['data'].length; i++) {
        Map<String, dynamic> storeModel =
            checkDataTypesSimple(responseBody['data'][i]);

        //check data list
        storeModel.forEach((key, value) {
          expect(storeModel[key],
              ExpectedDataTypeApiResponse.retailerSettingStoreList[key]);
          Utils.itemSuccess("$key: success");
        });
      }

      Utils.successTest("Check user list model: ");
    });
  });
  group('Manage Account', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });
    var body = {
      "bank_account_type": 'selectedBankAccountType',
      "bank_name": 'selectedBankName',
      "bank_unique_id": 'selectedBankName',
      "currency": 'selectedCurrency',
      "bank_account_number": 'bankAccountController',
      "iban": 'ibanController',
    };
    test("Manage account: create function", () async {
      when(service.addRetailerBankAccounts(body))
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Manage Account Create: success");
    });
    test("Manage account: update function", () async {
      body.addAll({"unique_id": "unique_id"});

      when(service.addRetailerBankAccounts(body))
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Manage Account Update: success");
    });
    test("Manage account: get list function", () async {
      body.addAll({"unique_id": "unique_id"});

      when(service.getRetailerFieList(1))
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Manage Account Get List: success");
    });

    test("Check Manage Account api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.retailerBankAccountList,
        token: Utils.token,
      );

      //check model without data list

      for (int i = 0; i < responseBody['data'].length; i++) {
        Map<String, dynamic> manageAccountModel =
            checkDataTypesSimple(responseBody['data'][i]);

        //check data list
        manageAccountModel.forEach((key, value) {
          expect(manageAccountModel[key],
              ExpectedDataTypeApiResponse.retailerSettingBankAccountList[key]);
          Utils.itemSuccess("$key: success");
        });
        Utils.itemSuccess("index $i: success");
      }

      Utils.successTest("Check user list model: ");
    });
  });
  group('Company Account', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });
    Map<String, String> body = {};
    test("Company account: create function", () async {
      when(service.addRetailerBankAccounts(body))
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Manage Account Create: success");
    });
    test("Company account: get data function", () async {
      body.addAll({"unique_id": "unique_id"});

      when(service.getCompanyProfile())
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Manage Account Get List: success");
    });

    test("Check Company account api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.getCompanyProfile,
        token: Utils.token,
      );

      //check model without data list

      Map<String, dynamic> companyAccountModel =
          checkDataTypesSimple(responseBody['data']);

      //check data list
      companyAccountModel.forEach((key, value) {
        ExpectedDataTypeApiResponse.retailerSettingCompanyAccountList
            .forEach((keyE, valueE) {
          if (companyAccountModel[keyE] == null) {
            Utils.errorTest(keyE);
          }
        });

        expect(companyAccountModel[key],
            ExpectedDataTypeApiResponse.retailerSettingCompanyAccountList[key]);
        Utils.itemSuccess("$key: success");
      });

      Utils.successTest("Check user list model: ");
    });
  });
  group('Account Balance', () {
    final service = MockRepositoryRetailer();
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      database = MockDatabaseHelper();
    });
    Map<String, String> body = {};
    test("Account Balance: create function", () async {
      when(service.getRetailerBankAccountBalance())
          .thenAnswer((realInvocation) => Future<Failure>.value(Failure()));
      Utils.itemSuccess("Account Balance Get: success");
    });

    test("Check Account Balance api model", () async {
      Map<String, dynamic> responseBody = await getListVerify(
        url: NetworkUrls.getRetailerBankAccountBalance,
        token: Utils.token,
      );
      RetailerBankAccountBalanceModel data =
          RetailerBankAccountBalanceModel.fromJson(responseBody);
      Map<String, dynamic> checkedData = jsonDecode(jsonEncode(data));
      //check data list
      for (int i = 0; i < checkedData['data'].length; i++) {
        Map<String, dynamic> accountBalanceModel =
            checkDataTypesSimple(checkedData['data'][i]);

        //check data list
        accountBalanceModel.forEach((key, value) {
          // ExpectedDataTypeApiResponse.retailerAccountBalanceList
          //     .forEach((keyE, valueE) {
          //   // if (accountBalanceModel.containsKey(keyE)) {
          //   //   Utils.errorTest(keyE);
          //   // }
          //   if (accountBalanceModel.containsKey('bank_name')) {
          //     Utils.errorTest(keyE);
          //   }
          // });
          expect(accountBalanceModel[key],
              ExpectedDataTypeApiResponse.retailerAccountBalanceList[key]);
          Utils.itemCheck(0, i, key);
        });
        Utils.itemSuccess("index $i: success");
      }

      Utils.successTest("Check user list model: ");
    });
  });
}
