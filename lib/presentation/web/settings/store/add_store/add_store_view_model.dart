import 'dart:convert';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/network/web_service.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:bingo/main.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:stacked/stacked.dart';
import '../../../../../app/app_secrets.dart';
import '../../../../../app/locator.dart';
import '../../../../../const/utils.dart';
import '../../../../../data/data_source/country_code.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/all_city_model.dart';
import '../../../../../data_models/models/component_models/all_country_model.dart';
import '../../../../../data_models/models/g_map_model.dart';
import '../../../../../data_models/models/store_model/store_model.dart';
import '../../../../../repository/repository_website_settings.dart';
import '../../../../../services/network/network_urls.dart';
import '../../../../../services/web_basic_service/WebBasicService.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/cards/gMap.dart';

class AddStoreViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();

  String get tabNumber => _webBasicService.tabNumber.value;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  final RepositoryWebsiteSettings _settings =
      locator<RepositoryWebsiteSettings>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  final WebService _webService = locator<WebService>();

  String get myCountry => _authService.user.value.data!.country!;
  bool isEdit = false;
  String uId = "";
  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String errorLocationNameController = "";
  String errorAddressMessage = "";
  String errorRemarksMessage = "";
  String selectedCityValidation = "";
  String selectedCountryValidation = "";
  String frontPhotoValidation = "";
  String signBoardPhotoValidation = "";

  String frontServerImage = "";
  String signServerImage = "";
  Uint8List? frontImage;
  String frontImageName = "";
  Uint8List? signImage;
  String signImageName = "";
  String? selectedCountry;
  AllCityDataModel? selectedCity;

  bool isButtonBusy = false;
  double lat = 0.0;
  double long = 0.0;
  double gLat = 0.0;
  double gLong = 0.0;
  String placeName = "";

  List<AllCityDataModel> cities = [];
  AllCountryDataModel country = AllCountryDataModel();
  ScrollController scrollController = ScrollController();
  StoreData storeData = StoreData();

  prefill(String? id) async {
    setBusy(true);
    if (id != null) {
      isEdit = true;
    }
    notifyListeners();
    cities = await _settings.getCity();
    country = await _settings.getCountry();
    if (id != null) {
      uId = id;
      storeData = await _settings.getStoreDetails(id);
      locationNameController.text = storeData.name!;
      selectedCity =
          cities.firstWhere((element) => element.city == storeData.city);
      if (country.country == myCountry) {
        selectedCountry = country.country;
      }
      {
        country = AllCountryDataModel(country: myCountry);
        selectedCountry = myCountry;
      }
      addressController.text = storeData.address!;
      frontServerImage = storeData.storeLogo!;
      signServerImage = storeData.signBoardPhoto!;
      remarksController.text = storeData.remarks!;
      Utils.fPrint("storeData.remarks");
      Utils.fPrint(storeData.remarks);
      lat = double.parse(storeData.lat ?? '0.0');
      long = double.parse(storeData.long ?? '0.0');
    }

    setBusy(false);
    notifyListeners();
  }

  Future uploadFile({isFrontImage = true}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      onFileLoading: (status) => Utils.fPrint(status.toString()),
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (isFrontImage) {
      if (result != null) {
        frontImage = result.files.first.bytes;
        frontImageName = result.files.first.name;
      } else {
        frontImage = null;
      }
    } else {
      if (result != null) {
        signImage = result.files.first.bytes;
        signImageName = result.files.first.name;
      } else {
        signImage = null;
      }
    }

    notifyListeners();
  }

  List<Predictions> addressList = [];

  Future<void> getPlaces(input) async {
    int index = countryCode.indexWhere((element) => element.name == myCountry);
    String cC = countryCode[index].code!;
    try {
      var red =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input"
          "&types=establishment&language=en&components=country:$cC&key=${AppSecrets.kGoogleApiKey}";

      final response = await http.get(Uri.parse(red));

      GMapModel result = GMapModel.fromJson(jsonDecode(response.body));
      addressList = result.predictions!;
      notifyListeners();
    } on Exception catch (e) {
      Utils.fPrint(e.toString());
    }
  }

  Future<void> openMap(String? description, String? placeId) async {
    addressList.clear();
    notifyListeners();
    var red =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppSecrets.kGoogleApiKey}";

    final response = await http.get(Uri.parse(red));
    PlaceIdToLatLong placeIdToLatLong =
        PlaceIdToLatLong.fromJson(jsonDecode(response.body));
    displayPrediction(placeIdToLatLong.result!.geometry!.location!.lat!,
        placeIdToLatLong.result!.geometry!.location!.lng!, description!);
  }

  Future displayPrediction(double lat, double lng, String description) async {
    try {
      setBusy(true);
      notifyListeners();
      var v = await _navigationService
          .displayDialog(MapSample(lat: lat, long: lng));
      setBusy(false);
      notifyListeners();

      if (v == null) {
        lat = lat;
        long = lng;
        addressController.text = description;
      } else {
        lat = v['lat'];
        long = v['lng'];
        var red =
            "https://maps.googleapis.com/maps/api/geocode/json?latlng=${v['lat']},${v['lng']}&key=${AppSecrets.kGoogleApiKey}";

        final response = await http.get(Uri.parse(red));

        addressController.text =
            (jsonDecode(response.body))["results"][0]['formatted_address'];
      }
      notifyListeners();
    } on Exception catch (e) {
      Utils.fPrint(e.toString());
    }
    // callMap(lat, long);
  }

  void checkValidation(BuildContext context) {
    if (locationNameController.text.isEmpty) {
      errorLocationNameController =
          AppLocalizations.of(context)!.locationNameValidationMessage;
    } else {
      errorLocationNameController = "";
    }
    if (selectedCity == null) {
      selectedCityValidation =
          AppLocalizations.of(context)!.selectedCityValidationMessage;
    } else {
      selectedCityValidation = "";
    }
    if (addressController.text.isEmpty) {
      errorAddressMessage =
          AppLocalizations.of(context)!.addressValidationMessage;
    } else {
      errorAddressMessage = "";
    }
    if (remarksController.text.isEmpty) {
      errorRemarksMessage =
          AppLocalizations.of(context)!.remarksValidationMessage;
    } else {
      errorRemarksMessage = "";
    }
    if (selectedCountry == null) {
      selectedCountryValidation =
          AppLocalizations.of(context)!.selectedCountryValidationMessage;
    } else {
      selectedCountryValidation = "";
    }
    if (frontImage != null || frontServerImage.isNotEmpty) {
      frontPhotoValidation = "";
    } else {
      frontPhotoValidation =
          AppLocalizations.of(context)!.frontPhotoValidationMessage;
    }
    if (signImage != null || signServerImage.isNotEmpty) {
      signBoardPhotoValidation = "";
    } else {
      signBoardPhotoValidation =
          AppLocalizations.of(context)!.signBoardPhotoValidationMessage;
    }
    notifyListeners();
  }

  void addStore(BuildContext context) async {
    checkValidation(context);

    if (lat.toString().isEmpty || long.toString().isEmpty) {
      _navigationService.animatedDialog(AlertDialogMessage(
          AppLocalizations.of(activeContext)!.internalServerError));
    } else {
      if (locationNameController.text.isNotEmpty &&
          remarksController.text.isNotEmpty &&
          selectedCity != null &&
          addressController.text.isNotEmpty &&
          selectedCountry != null &&
          (frontImage != null || frontServerImage.isNotEmpty) &&
          (signImage != null || signServerImage.isNotEmpty)) {
        makeButtonBusy(true);
        var formData = FormData();
        if (isEdit) {
          formData.fields.add(MapEntry('unique_id', uId));
        }
        formData.fields.add(MapEntry('name', locationNameController.text));
        formData.fields.add(MapEntry('city', selectedCity!.city!));
        formData.fields.add(MapEntry('address', addressController.text));
        formData.fields.add(MapEntry('lattitude', lat.toString()));
        formData.fields.add(MapEntry('longitude', long.toString()));
        formData.fields.add(MapEntry('country', selectedCountry!));
        formData.fields.add(MapEntry('remark', remarksController.text));

        Response response = await callWebService(
            formData, frontImage, frontImageName, signImage, signImageName);

        dynamic body = response.data;
        if (response.statusCode == 200) {
          if (context.mounted) {
            goBack(context);
          }
        } else {
          _navigationService.animatedDialog(AlertDialogMessage(body.message!));
        }
        makeButtonBusy(false);

        notifyListeners();
      }
    }
  }

  Future<Response> callWebService(FormData formData, Uint8List? passFrontImage,
      String fImageName, Uint8List? passSignImage, String sImageName) async {
    if (passFrontImage != null) {
      if (passFrontImage.isNotEmpty) {
        var fbp =
            dio.MultipartFile.fromBytes(passFrontImage, filename: fImageName);
        formData.files.add(MapEntry('store_logo', fbp));
      }
    }
    if (passSignImage != null) {
      if (passSignImage.isNotEmpty) {
        var sbp =
            dio.MultipartFile.fromBytes(passSignImage, filename: sImageName);
        formData.files.add(MapEntry('sign_board_photo', sbp));
      }
    }
    final response = await dio.Dio().post(NetworkUrls.addEditRetailerStore,
        data: formData, options: Options(headers: _webService.headers));
    Utils.fPrint('responseresponse');
    Utils.fPrint(response.data);
    return response;
  }

  String getCountryShortCode(String country) {
    int index = countryCode.indexWhere((element) => element.name == country);
    return countryCode[index].code!;
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.storeList);
  }

  void makeButtonBusy(bool v) {
    isButtonBusy = v;
    notifyListeners();
  }

  void selectCity(AllCityDataModel? v) {
    selectedCity = v!;
    notifyListeners();
  }

  void selectCountry(String? v) {
    selectedCountry = v!;
    notifyListeners();
  }
}
