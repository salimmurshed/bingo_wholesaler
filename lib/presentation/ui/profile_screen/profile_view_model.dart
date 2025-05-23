import '../../../data_models/enums/user_type_for_web.dart';
import '/app/router.dart';
import '/const/utils.dart';
import '/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../app/app_secrets.dart';
import '../../../app/locator.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/navigation/navigation_service.dart';

class ProfileViewModel extends ReactiveViewModel {
  ProfileViewModel() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      profilePreField();
    });
    print(user.data!.profileImage!);
  }

  final _authService = locator<AuthService>();
  final _nav = locator<NavigationService>();

  UserModel get user => _authService.user.value;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isRetypePasswordVisible = false;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  double lat = 0.0;
  double long = 0.0;

  void picImage() async {
    _nav.pushNamed(Routes.pickImage);
  }

  profilePreField() {
    print(user.data!.address!);
    fNameController.text = user.data!.firstName!;
    lNameController.text = user.data!.lastName!;
    emailController.text = user.data!.email!;
    addressController.text = user.data!.address!;
  }

  Future<void> addAddress(context) async {
    // _navigationService.animatedDialog(MapScreen());
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "us",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: AppSecrets.kGoogleApiKey,
      // sessionToken: sessionToken,
      // components: [new Component(Component.country, "bd")],
      components: [],
      types: ["(cities)"],
      hint: AppLocalizations.of(context)!.selectCity,
      // startText: city == null || city == "" ? "" : city,
    );
    addressController.text = p!.description!;
    await displayPrediction(p);
  }

  Future displayPrediction(Prediction pos) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: AppSecrets.kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(pos.placeId!);

    lat = detail.result.geometry!.location.lat;
    long = detail.result.geometry!.location.lng;
  }

  void changeCurrentPsswordVisibility() {
    isCurrentPasswordVisible = !isCurrentPasswordVisible;
    print(isCurrentPasswordVisible);
    notifyListeners();
  }

  void changeNewPsswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    notifyListeners();
  }

  void changeRetypePasswordVisibility() {
    isRetypePasswordVisible = !isRetypePasswordVisible;
    notifyListeners();
  }

  String errorPasswordMessage = "";
  String firstnameErrorMessage = "";
  String lastNameErrorMessage = "";
  String addressPasswordMessage = "";

  bool isPassError = false;

  checkPassword() {
    if (newPasswordController.text.isEmpty &&
        currentPasswordController.text.isEmpty &&
        retypePasswordController.text.isEmpty) {
      errorPasswordMessage = "";
      isPassError = false;
      notifyListeners();
    } else {
      if (newPasswordController.text == retypePasswordController.text) {
        if (currentPasswordController.text.isNotEmpty) {
          isPassError = false;
          errorPasswordMessage =
              AppLocalizations.of(activeContext)!.passwordMatch;
        } else {
          errorPasswordMessage = "";
          isPassError = true;
        }
      } else if (newPasswordController.text.isEmpty &&
          retypePasswordController.text.isEmpty &&
          currentPasswordController.text.isNotEmpty) {
        errorPasswordMessage = "";
        isPassError = true;
      } else {
        errorPasswordMessage =
            AppLocalizations.of(activeContext)!.passwordNotMatch;
        isPassError = true;
      }
    }
    notifyListeners();
  }

  checkOtherFields() {}

  updateProfile() async {
    if (isPassError == true) {
      Utils.toast(
          isBottom: true, AppLocalizations.of(activeContext)!.passwordRecheck);
    } else if (fNameController.text.isEmpty) {
      firstnameErrorMessage =
          AppLocalizations.of(activeContext)!.firstnameErrorMessage;
    } else if (lNameController.text.isEmpty) {
      lastNameErrorMessage =
          AppLocalizations.of(activeContext)!.lastNameErrorMessage;
    } else if (addressController.text.isEmpty) {
      addressPasswordMessage =
          AppLocalizations.of(activeContext)!.addressPasswordMessage;
    } else {
      setBusy(true);
      notifyListeners();
      await _authService.update(
          fNameController.text,
          lNameController.text,
          addressController.text,
          lat,
          long,
          currentPasswordController.text,
          newPasswordController.text);
      setBusy(false);
      notifyListeners();
    }
    notifyListeners();

    // if(newPasswordController.){}
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];
}
