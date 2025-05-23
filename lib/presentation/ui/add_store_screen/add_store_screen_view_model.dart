import 'dart:convert';

import '../../../data_models/enums/user_roles_files.dart';
import '/data_models/models/store_model/store_model.dart';
import '/presentation/widgets/alert/alert_dialog.dart';
import '/repository/repository_retailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_secrets.dart';
import '../../../app/locator.dart';
import '../../../data/data_source/country_code.dart';
import '../../../data_models/models/component_models/response_model.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../widgets/alert/confirmation_dialog.dart';
import '../../widgets/cards/gMap.dart';

class AddStoreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  AddStoreViewModel() {
    getCity();
    getCountry();
  }

  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  String allCountryData = "";
  List<String> allCityData = [];
  final ImagePicker _picker = ImagePicker();
  XFile? frontBusinessPhoto;
  XFile? signBoardPhoto;
  StoreData storeData = StoreData();
  String? selectedCountry;
  String? selectedCity;
  String? uniqueId;
  String title = AppLocalizations.of(activeContext)!.addStore;
  String submitButton = AppLocalizations.of(activeContext)!.addStore;
  String? frontImage;
  String? signBoardImage;
  double lat = 0.0;
  double long = 0.0;
  bool isEdit = false;
  String status = "";

  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  // bool get isUserAdminRole {
  //   return userRoles.contains(UserRoles.admin) ||
  //       userRoles.contains(UserRoles.master);
  // }

  void pickFrontBusinessPhoto() async {
    frontBusinessPhoto = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void pickSignBoardPhoto() async {
    signBoardPhoto = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void removeRequest() async {
    _navigationService.pop();
  }

  void requestInactive() async {
    var body = {"unique_id": uniqueId};
    bool confirm = (await _navigationService.animatedDialog(ConfirmationDialog(
          title: !(status.toLowerCase() == "active")
              ? AppLocalizations.of(activeContext)!.sendActiveRequestHead
              : AppLocalizations.of(activeContext)!.sendInactiveRequestHead,
          content: !(status.toLowerCase() == "active")
              ? AppLocalizations.of(activeContext)!.sendActiveRequestBody
              : AppLocalizations.of(activeContext)!.sendInactiveRequestBody,
          submitButtonText: !(status.toLowerCase() == "active")
              ? AppLocalizations.of(activeContext)!.makeActive
              : AppLocalizations.of(activeContext)!.makeInactive,
        ))) ??
        false;
    if (confirm) {
      makeButtonBusy(true);
      //, (status.toLowerCase() == "active")
      await _repositoryRetailer.changeRetailerStoreStatus(body);
      makeButtonBusy(false);
    }
  }

  void getCity() async {
    setBusy(true);
    notifyListeners();
    await _repositoryComponents.getCity();
    // .catchError((_) {
    //   setBusy(false);
    //   notifyListeners();
    // });
    allCityData = (_repositoryComponents.allCityData.value)
        .data!
        .map((e) => e.city!)
        .toList();
  }

  void getCountry() async {
    setBusy(true);
    notifyListeners();
    await _repositoryComponents.getCountry();
    // .catchError(() {
    //   setBusy(false);
    //   notifyListeners();
    // });
    allCountryData =
        (_repositoryComponents.allCountryData.value).data!.country!;
    setBusy(false);
    notifyListeners();
  }

  void changeCountry(String data) {
    selectedCountry = data;
    notifyListeners();
  }

  void changeCity(String data) {
    selectedCity = data;
    notifyListeners();
  }

  void setDetails(StoreData arguments) {
    storeData = arguments;
    preFix(arguments);
    notifyListeners();
  }

  void preFix(StoreData data) {
    isEdit = true;
    locationNameController.text = data.name!;
    addressController.text = data.address!;
    remarkController.text = data.remarks!;
    uniqueId = data.uniqueId;
    title = AppLocalizations.of(activeContext)!.editStore;
    submitButton = AppLocalizations.of(activeContext)!.editStore;
    selectedCity = data.city;
    selectedCountry = _authService.user.value.data!.country; //data.country;
    frontImage = data.storeLogo;
    signBoardImage = data.signBoardPhoto;
    status = data.status!;
    notifyListeners();
  }

  String getCountryShortCode(String country) {
    int index = countryCode.indexWhere((element) => element.name == country);
    return countryCode[index].code!;
  }

  String get country => _authService.user.value.data!.country!;

  callPlace() {}

  Future displayPrediction(Prediction pos) async {
    try {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: AppSecrets.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      setBusy(true);
      notifyListeners();
      print(pos.toJson());
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(pos.placeId!);

      placeName = detail.result.formattedAddress!;
      addressController.text = detail.result.formattedAddress!;
      setBusy(true);
      notifyListeners();
      var v = await _navigationService.push(MaterialPageRoute(
          builder: (context) => MapSample(
              lat: detail.result.geometry!.location.lat,
              long: detail.result.geometry!.location.lng)));
      setBusy(false);
      notifyListeners();
      if (v == null) {
        lat = detail.result.geometry!.location.lat;
        long = detail.result.geometry!.location.lat;
        addressController.text = detail.result.formattedAddress!;
      } else {
        lat = v['lat'];
        long = v['lng'];
        addressController.text = v['place'];
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
    // callMap(lat, long);
  }

  String locationNameValidation = "";
  String selectedCityValidation = "";
  String addressValidation = "";
  String selectedCountryValidation = "";
  String frontPhotoValidation = "";
  String signBoardPhotoValidation = "";
  String remarksValidation = "";

  void checkValidation() {
    if (locationNameController.text.isEmpty) {
      locationNameValidation =
          AppLocalizations.of(activeContext)!.locationNameValidationMessage;
    } else {
      locationNameValidation = "";
    }
    if (selectedCity == null) {
      selectedCityValidation =
          AppLocalizations.of(activeContext)!.selectedCityValidationMessage;
    } else {
      selectedCityValidation = "";
    }
    if (addressController.text.isEmpty) {
      addressValidation =
          AppLocalizations.of(activeContext)!.addressValidationMessage;
    } else {
      addressValidation = "";
    }
    if (remarkController.text.isEmpty) {
      remarksValidation =
          AppLocalizations.of(activeContext)!.remarksValidationMessage;
    } else {
      remarksValidation = "";
    }
    if (selectedCountry == null) {
      selectedCountryValidation =
          AppLocalizations.of(activeContext)!.selectedCountryValidationMessage;
    } else {
      selectedCountryValidation = "";
    }
    if (frontBusinessPhoto == null) {
      frontPhotoValidation =
          AppLocalizations.of(activeContext)!.frontPhotoValidationMessage;
    } else {
      frontPhotoValidation = "";
    }
    if (signBoardPhoto == null) {
      signBoardPhotoValidation =
          AppLocalizations.of(activeContext)!.signBoardPhotoValidationMessage;
    } else {
      signBoardPhotoValidation = "";
    }
    notifyListeners();
  }

  bool isButtonBusy = false;

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void addStore() async {
    checkValidation();

    if (lat.toString().isEmpty || long.toString().isEmpty) {
      _navigationService.animatedDialog(AlertDialogMessage(
          AppLocalizations.of(activeContext)!.internalServerError));
    } else if (!isEdit) {
      if (locationNameController.text.isNotEmpty &&
          remarkController.text.isNotEmpty &&
          selectedCity != null &&
          addressController.text.isNotEmpty &&
          selectedCountry != null &&
          frontBusinessPhoto != null &&
          signBoardPhoto != null) {
        MultipartRequest request =
            _repositoryRetailer.requestAddStoreResponse();

        request.fields["name"] = locationNameController.text;
        request.fields["city"] = selectedCity!;
        request.fields["address"] = addressController.text;
        request.fields["lattitude"] = lat.toString();
        request.fields["longitude"] = long.toString();
        request.fields["country"] = selectedCountry!;
        request.fields["remark"] = remarkController.text;
        print(request.fields);
        makeButtonBusy(true);
        Response response;

        response = await _repositoryRetailer.addStoreRequests(
            request, frontBusinessPhoto!.path, signBoardPhoto!.path);

        ResponseMessages body =
            ResponseMessages.fromJson(jsonDecode(response.body));
        if (body.success!) {
          _repositoryRetailer.getStores();
          makeButtonBusy(false);
          _navigationService.pop();
        } else {
          makeButtonBusy(false);
          _navigationService.animatedDialog(AlertDialogMessage(body.message!));
        }
      }
    } else {
      if (locationNameController.text.isNotEmpty &&
          remarkController.text.isNotEmpty &&
          selectedCity != null &&
          addressController.text.isNotEmpty &&
          selectedCountry != null) {
        MultipartRequest request =
            _repositoryRetailer.requestAddStoreResponse();

        request.fields["unique_id"] = uniqueId!;
        request.fields["name"] = locationNameController.text;
        request.fields["city"] = selectedCity!;
        request.fields["address"] = addressController.text;
        request.fields["lattitude"] = lat.toString();
        request.fields["longitude"] = long.toString();
        request.fields["country"] = selectedCountry!;
        request.fields["remark"] = remarkController.text;
        print(request.fields);
        makeButtonBusy(true);
        Response response;

        response = await _repositoryRetailer.addStoreRequests(
            request, frontBusinessPhoto?.path, signBoardPhoto?.path);

        ResponseMessages body =
            ResponseMessages.fromJson(jsonDecode(response.body));
        if (body.success!) {
          _repositoryRetailer.getStores();
          makeButtonBusy(false);
          _navigationService.pop();
        } else {
          makeButtonBusy(false);
          _navigationService.animatedDialog(AlertDialogMessage(body.message!));
        }
      }
    }
  }
}
