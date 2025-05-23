import 'dart:convert';
import 'dart:io';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_html/html.dart' show AnchorElement;

import '../app/locator.dart';
import '../const/connectivity.dart';
import '../const/utils.dart';
import '../data_models/enums/user_type_for_web.dart';
import '../data_models/models/download_xml_cvs/download_xml_cvs.dart';
import '../data_models/models/fie_account_model/fie_account_model.dart';
import '../data_models/models/fie_lot_details_model/fie_lot_details_model.dart';
import '../data_models/models/settlement_details_model/settlement_details_model.dart';
import '../data_models/models/settlement_details_model/settlement_details_model_fie.dart';
import '../data_models/models/settlement_web_model/settlement_web_model.dart';
import '../main.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';
import '../services/storage/db.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

@lazySingleton
class RepositorySettlement with ListenableServiceMixin {
  final WebService _webService = locator<WebService>();
  ReactiveValue<SettlementDetailsModelFie> settlementListFie =
      ReactiveValue<SettlementDetailsModelFie>(SettlementDetailsModelFie());
  SettlementWebModel? settlementFieModel;
  ReactiveValue<List<SettlementWebModelData>> settlementList =
      ReactiveValue<List<SettlementWebModelData>>([]);

  List<FieAccountModelData> fieAccountList = [];

  Future getRetailerSettlementList(UserTypeForWeb user, {String? page}) async {
    try {
      if (user == UserTypeForWeb.fie) {
        Response response = await _webService
            .getRequest("${NetworkUrls.fieSettlementList}$page");
        SettlementDetailsModelFie responseData =
            SettlementDetailsModelFie.fromJson(jsonDecode(response.body));

        settlementListFie.value = responseData;
      } else {
        String url = (user == UserTypeForWeb.retailer)
            ? "${NetworkUrls.retailerSettlementList}$page"
            : "${NetworkUrls.wholesalerSettlementList}$page";
        Response response = await _webService.getRequest(url);
        SettlementWebModel responseData =
            SettlementWebModel.fromJson(jsonDecode(response.body));

        settlementFieModel = responseData;
      }

      notifyListeners();
    } catch (e) {
      Utils.fPrint('response.error $e');
    }
  }

  // FieLotDetailsModel fieLotList = FieLotDetailsModel();
  // final UserTypeForWeb enroll =
  // (prefs.getString(DataBase.userType))!.toLowerCase() == "retailer"
  //     ? UserTypeForWeb.retailer
  //     : (prefs.getString(DataBase.userType))!.toLowerCase() == "wholesaler"
  //     ? UserTypeForWeb.wholesaler
  //     : UserTypeForWeb.fie;
  Future<FieLotDetailsModel?> getFieLotList(String? id, String? type) async {
    UserTypeForWeb clientType = (prefs.getString(DataBase.userType))!
                .toLowerCase() ==
            "retailer"
        ? UserTypeForWeb.retailer
        : (prefs.getString(DataBase.userType))!.toLowerCase() == "wholesaler"
            ? UserTypeForWeb.wholesaler
            : UserTypeForWeb.fie;
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        var body = {"lot_id": id, "type": type};
        String url = clientType == UserTypeForWeb.retailer
            ? NetworkUrls.viewRetailerLotDetails
            : clientType == UserTypeForWeb.wholesaler
                ? NetworkUrls.viewWholeSalerLotDetails
                : NetworkUrls.viewLotDetails;

        Response response = await _webService.postRequest(url, body);

        FieLotDetailsModel fieLotList =
            FieLotDetailsModel.fromJson(jsonDecode(response.body));

        notifyListeners();
        return fieLotList;
      } catch (_) {
        return null;
      }
    } else {
      Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
      return null;
    }
  }

  Future getAccountList(String date) async {
    bool connection = await checkConnectivity();
    if (connection) {
      try {
        String url = NetworkUrls.fieAccountingList;
        Response response =
            await _webService.postRequest(url, {"effective_date": date});
        FieAccountModel responseData =
            FieAccountModel.fromJson(jsonDecode(response.body));

        fieAccountList = responseData.data!;

        notifyListeners();
      } catch (_) {}
    } else {
      Utils.toast(AppLocalizations.of(activeContext)!.noInternet);
    }
  }

  Future<ResponseMessageModel> addPaymentCollectionLot(bool isPayment) async {
    String url =
        isPayment ? NetworkUrls.addPaymentLot : NetworkUrls.addCollectionLot;
    Response response = await _webService.postRequest(url, {});
    ResponseMessageModel responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));

    return responseData;
  }

  // downloadXmlCvsData = [];

  Future<File?> downloadSettlement(bool isCsv, String date) async {
    if (isCsv) {
      String url = NetworkUrls.downloadCSV;
      Response response =
          await _webService.postRequest(url, {"effective_date": date});

      DownloadXmlCvs responseData =
          DownloadXmlCvs.fromJson(jsonDecode(response.body));
      List<DownloadXmlCvsData> downloadXmlCvsData = responseData.data!;

      List<String> header = [];
      header.add('Sequence');
      header.add('Effective Date');
      header.add('Account Type');
      header.add('Account Number');
      header.add('Cost Center');
      header.add('Debit Credit');
      header.add('Currency');
      header.add('Amount');

      List<List<String>> listOfLists = [];
      for (int i = 0; i < downloadXmlCvsData.length; i++) {
        listOfLists.add([
          '${i + 1}',
          downloadXmlCvsData[i].effectiveDate!,
          downloadXmlCvsData[i].accountType!,
          downloadXmlCvsData[i].accountNumber.toString(),
          downloadXmlCvsData[i].costCenter!,
          downloadXmlCvsData[i].debitCredit!,
          downloadXmlCvsData[i].currency!,
          downloadXmlCvsData[i].amount!,
        ]);
      }

      exportCSV.myCSV(header, listOfLists);
    } else {
      String url = NetworkUrls.downloadXML;
      Response response =
          await _webService.postRequest(url, {"effective_date": date});
      String fileName = DateFormat('dd-MM-yyyy-HH-mm-ss').format(
          DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch));
      AnchorElement()
        ..href =
            '${Uri.dataFromString(response.body, mimeType: 'application/xml', encoding: utf8)}'
        ..download = 'export_accounting_information_$fileName.xml'
        ..style.display = 'none'
        ..click();
    }

    return null;
  }

  Future<ResponseMessageModel> downloadSettlementXML(bool isPayment) async {
    String url =
        isPayment ? NetworkUrls.addPaymentLot : NetworkUrls.addCollectionLot;
    Response response = await _webService.postRequest(url, {});
    ResponseMessageModel responseData =
        ResponseMessageModel.fromJson(jsonDecode(response.body));

    return responseData;
  }

  RepositorySettlement() {
    listenToReactiveValues([settlementListFie, settlementList]);
  }

  Future<Response> downloadService(String uri, jsonBody) async {
    final http.Client client = http.Client();
    try {
      Response response = await client.post(
        Uri.parse(uri),
        headers: {
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        },
        body: jsonBody,
      );

      return response;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
