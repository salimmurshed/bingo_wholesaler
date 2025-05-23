import 'dart:convert';

import 'package:bingo/const/utils.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../data_models/models/component_models/all_city_model.dart';
import '../data_models/models/component_models/all_country_model.dart';
import '../data_models/models/component_models/retailer_role_model.dart';
import '../data_models/models/component_models/tax_id_type_model.dart';
import '../data_models/models/retailer_users_model/retailer_users_model.dart';

import '../data_models/models/store_model/store_model.dart';
import '../data_models/models/user_details_model/user_details_model.dart';
import '../services/network/network_urls.dart';
import '../services/network/web_service.dart';

@lazySingleton
class RepositoryWebsiteSettings with ListenableServiceMixin {
  final WebService _webService = locator<WebService>();

  Future<RetailerUsersModel?> getRetailerUserList(String page) async {
    try {
      Response response =
          await _webService.getRequest(NetworkUrls.retailerUsersList + page);
      RetailerUsersModel responseData =
          RetailerUsersModel.fromJson(jsonDecode(response.body));
      return responseData;
    } on Exception catch (_) {
      return null;
      // _navigationService.displayDialog(AlertDialogMessage(e.toString()));
    }
    notifyListeners();
  }

  Future<List<RetailerRolesData>> getRetailerRolesList() async {
    Response response =
        await _webService.getRequest(NetworkUrls.retailerRolesList);
    if (response.statusCode == 200) {
      RetailerRolesModel retailerRolesList =
          RetailerRolesModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return retailerRolesList.data!;
    } else {
      return [];
    }
  }

  Future<List<StoreData>> getStores() async {
    try {
      Response response = await _webService.getRequest(NetworkUrls.storeUrl);
      Utils.fPrint('response.body');
      Utils.fPrint(response.body);
      final responseData = StoreModel.fromJson(jsonDecode(response.body));
      return responseData.data!;
    } on Exception catch (_) {
      return [];
    }
  }

  Future<TaxIdType> getTaxIdType() async {
    Response response = await _webService.getRequest(NetworkUrls.taxIdType);
    return TaxIdType.fromJson(jsonDecode(response.body));
  }

  Future<List<StoreData>> getStoreList() async {
    Response response = await _webService.getRequest(NetworkUrls.storeUrl);
    final responseData = StoreModel.fromJson(jsonDecode(response.body));
    return responseData.data!;
  }

  Future<UserDetailsModel> getUserDetails(String? id) async {
    Response response = await _webService
        .postRequest(NetworkUrls.getRetailerUserDetails, {'unique_id': id});
    return UserDetailsModel.fromJson(jsonDecode(response.body));
  }

  Future<List<AllCityDataModel>> getCity() async {
    Response response = await _webService.getRequest(NetworkUrls.cityUri);
    AllCityModel allCityData = AllCityModel.fromJson(jsonDecode(response.body));
    return allCityData.data!;
  }

  Future<AllCountryDataModel> getCountry() async {
    Response response = await _webService.getRequest(NetworkUrls.countryUri);
    AllCountryModel allCountryData =
        AllCountryModel.fromJson(jsonDecode(response.body));
    return allCountryData.data!;
  }

  Future<StoreData> getStoreDetails(String? id) async {
    Response response = await _webService
        .postRequest(NetworkUrls.getRetailerStore, {"store_unique_id": id});
    var data = jsonDecode(response.body);
    StoreData storeData = StoreData.fromJson(data['data']);
    return storeData;
  }
}
