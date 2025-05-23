import '../../../const/utils.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bingo/data_models/models/user_model/user_model.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../const/utils.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../main.dart';
import '../../../services/web_basic_service/WebBasicService.dart';

class EditProfileViewModel extends ReactiveViewModel {
  EditProfileViewModel() {
    prefill();
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _auth = locator<AuthService>();
  UserModel get user => _auth.user.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  UserTypeForWeb get enrollment => _auth.enrollment.value;

  ScrollController scrollController = ScrollController();
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isRetypePasswordVisible = false;
  String img = "";
  String platformImageName = "";
  double lat = 0.0;
  double long = 0.0;
  Uint8List? platformImage;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  String errorPasswordMessage = "";
  String firstnameErrorMessage = "";
  String lastNameErrorMessage = "";
  String addressErrorMessage = "";

  bool isPassError = false;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  prefill() {
    Utils.fPrint('user.data');
    Utils.fPrint(user.data.toString());
    fNameController.text = user.data!.firstName!;
    lNameController.text = user.data!.lastName!;
    emailController.text = user.data!.email!;
    addressController.text = user.data!.address!;
    img = user.data!.profileImage!;
    lat = double.parse(
        user.data!.latitude!.isEmpty ? "0.0" : user.data!.latitude!);
    long = double.parse(
        user.data!.longitude!.isEmpty ? "0.0" : user.data!.longitude!);
    notifyListeners();
  }

  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      onFileLoading: (status) => Utils.fPrint(status.toString()),
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (result != null) {
      platformImage = result.files.first.bytes;
      platformImageName = result.files.first.name;
    } else {
      platformImage = null;
    }
    notifyListeners();
  }

  void changeCurrentPasswordVisibility() {
    isCurrentPasswordVisible = !isCurrentPasswordVisible;
    notifyListeners();
  }

  void changeNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    notifyListeners();
  }

  void changeRetypePasswordVisibility() {
    isRetypePasswordVisible = !isRetypePasswordVisible;
    notifyListeners();
  }

  checkPassword(BuildContext context) {
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
          errorPasswordMessage = AppLocalizations.of(context)!.passwordMatch;
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
        errorPasswordMessage = AppLocalizations.of(context)!.passwordNotMatch;
        isPassError = true;
      }
    }
    notifyListeners();
  }

  updateProfile() async {
    if (isPassError == true) {
      Utils.toast(
          isBottom: true, AppLocalizations.of(activeContext)!.passwordRecheck);
    }
    if (fNameController.text.isEmpty) {
      firstnameErrorMessage =
          AppLocalizations.of(activeContext)!.firstnameErrorMessage;
    } else {
      firstnameErrorMessage = "";
    }
    if (lNameController.text.isEmpty) {
      lastNameErrorMessage =
          AppLocalizations.of(activeContext)!.lastNameErrorMessage;
    } else {
      lastNameErrorMessage = "";
    }
    if (addressController.text.isEmpty) {
      addressErrorMessage =
          AppLocalizations.of(activeContext)!.addressPasswordMessage;
    } else {
      addressErrorMessage = "";
    }
    notifyListeners();
    Utils.fPrint('isPassError');
    Utils.fPrint((firstnameErrorMessage.isNotEmpty &&
            lastNameErrorMessage.isNotEmpty &&
            addressErrorMessage.isNotEmpty &&
            !isPassError)
        .toString());
    if (firstnameErrorMessage.isEmpty &&
        lastNameErrorMessage.isEmpty &&
        addressErrorMessage.isEmpty &&
        !isPassError) {
      setBusy(true);
      notifyListeners();

      await _auth.updateProfileWeb(
          fNameController.text,
          lNameController.text,
          addressController.text,
          lat,
          long,
          currentPasswordController.text,
          newPasswordController.text,
          img: platformImage);

      setBusy(false);
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_auth];
}
