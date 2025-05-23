import 'dart:typed_data';

import 'package:bingo/app/locator.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/get_company_profile/get_company_profile.dart';
import '../../../../services/auth_service/auth_service.dart';
// import '../../../widgets/web_widgets/html_editor_enhanced/src/html_editor_controller_mobile.dart'
//     as p;
import '../../../widgets/web_widgets/html_editor_enhanced/src/html_editor_controller_unsupported.dart'
    if (dart.library.html) '../../../widgets/web_widgets/html_editor_enhanced/src/html_editor_controller_web.dart'
    if (dart.library.io) '../../../widgets/web_widgets/html_editor_enhanced/src/html_editor_controller_mobile.dart';

class CompanyProfileViewModel extends BaseViewModel {
  CompanyProfileViewModel() {
    getCompanyProfile();
  }

  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _retailer = locator<RepositoryRetailer>();
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;
  // HtmlEditorController aboutUsController = HtmlEditorController();
  String get tabNumber => _webBasicService.tabNumber.value;
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController mainProductController = TextEditingController();
  TextEditingController dateFoundedController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  String serverImage = '';
  String aboutUs = '';
  bool buttonBusy = false;

  ScrollController scrollController = ScrollController();
  GetCompanyProfile? userCompanyProfile;
  String logoImageName = '';
  Uint8List? logoImage;
  Future getCompanyProfile() async {
    setBusy(true);
    notifyListeners();
    await _retailer.getCompanyProfile();
    userCompanyProfile = _retailer.userCompanyProfile.value;
    commercialNameController.text = userCompanyProfile!.data!.commercialName!;
    mainProductController.text = userCompanyProfile!.data!.mainProducts!;
    dateFoundedController.text = userCompanyProfile!.data!.dateFounded!;
    informationController.text = userCompanyProfile!.data!.information!;
    urlController.text = userCompanyProfile!.data!.websiteUrl!;
    aboutUs = userCompanyProfile!.data!.aboutUs!;
    serverImage = userCompanyProfile!.data!.logo!;
    setBusy(false);
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      onFileLoading: (status) => Utils.fPrint(status.toString()),
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      logoImage = result.files.first.bytes;
      logoImageName = result.files.first.name;
    } else {
      logoImage = null;
    }

    notifyListeners();
  }

  String commercialNameError = "";
  String informationError = "";
  String mainProductError = "";
  String webUrlError = "";
  String dateFoundedError = "";
  String aboutUsError = "";
  updateCompanyProfile(BuildContext context) async {
    if (commercialNameController.text.isEmpty) {
      commercialNameError =
          AppLocalizations.of(context)!.commercialNameValidationCompanyProfile;
    } else {
      commercialNameError = "";
    }
    if (informationController.text.isEmpty) {
      informationError =
          AppLocalizations.of(context)!.informationValidationCompanyProfile;
    } else {
      informationError = "";
    }
    if (mainProductController.text.isEmpty) {
      mainProductError =
          AppLocalizations.of(context)!.mainProductValidationCompanyProfile;
    } else {
      mainProductError = "";
    }
    if (urlController.text.isEmpty) {
      webUrlError =
          AppLocalizations.of(context)!.websiteUrlValidationCompanyProfile;
    } else {
      webUrlError = "";
    }
    if (dateFoundedController.text.isEmpty) {
      dateFoundedError =
          AppLocalizations.of(context)!.dateFoundedValidationCompanyProfile;
    } else {
      dateFoundedError = "";
    }

    // if ((await aboutUsController.getText()).isEmpty) {
    //   if (context.mounted) {
    //     aboutUsError =
    //         AppLocalizations.of(context)!.aboutUsValidationCompanyProfile;
    //   }
    // } else {
    //   aboutUsError = "";
    // }
    if (commercialNameError.isEmpty &&
        informationError.isEmpty &&
        mainProductError.isEmpty &&
        webUrlError.isEmpty &&
        dateFoundedError.isEmpty &&
        aboutUsError.isEmpty) {
      var body = {
        "commercialName": commercialNameController.text,
        "information": informationController.text,
        "mainProduct": mainProductController.text,
        "url": urlController.text,
        "dateFounded": dateFoundedController.text,
        // "aboutUs": await aboutUsController.getText(),
      };
      setBusyForObject(buttonBusy, true);
      notifyListeners();
      await _retailer.updateCompanyProfile(body, logoImage);
      setBusyForObject(buttonBusy, false);
      notifyListeners();

      notifyListeners();
    }
  }
}
