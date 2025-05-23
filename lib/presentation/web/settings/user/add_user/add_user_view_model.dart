import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bingo/app/web_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import '../../../../../app/locator.dart';
import '../../../../../const/email_validator.dart';
import '../../../../../const/special_key.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/response_model.dart';
import '../../../../../data_models/models/component_models/retailer_role_model.dart';
import '../../../../../data_models/models/component_models/tax_id_type_model.dart';
import '../../../../../data_models/models/store_model/store_model.dart';
import '../../../../../data_models/models/user_details_model/user_details_model.dart';
import '../../../../../repository/repository_retailer.dart';
import '../../../../../repository/repository_website_settings.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../../services/web_basic_service/WebBasicService.dart';

class AddUserViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositoryWebsiteSettings _settings =
      locator<RepositoryWebsiteSettings>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  ScrollController scrollController = ScrollController();

  bool isButtonBusy = false;

  String get tabNumber => _webBasicService.tabNumber.value;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController idDocumentNameController = TextEditingController();

  String errorFirstNameMessage = "";
  String errorLastNameMessage = "";
  String errorEmailNameMessage = "";
  String errorIdDocNameMessage = "";
  String errorIdTypeMessage = "";
  String errorStoreMessage = "";
  String errorRoleMessage = "";

  List status = ["Inactive", "Active"];
  String? selectedStatus;
  List<RetailerRolesData> selectedRoleList = [];
  List<RetailerRolesData> roleList = [];

  List<StoreData> selectedStoreList = [];
  List<StoreData> storeList = [];

  TaxIdTypeData? selectedTaxIdType;
  List<TaxIdTypeData> taxIdTypeData = [];
  bool isEdit = false;
  String uId = '';

  void editUserCheck(String? id) {
    isEdit = id == null ? false : true;

    notifyListeners();
    if (isEdit) {
      getRetailerRolesListEdit(id: id);
      uId = id!;
    } else {
      getRetailerRolesListAdd();
    }
  }

  getRetailerRolesListAdd() async {
    setBusy(true);
    notifyListeners();

    roleList = await _settings.getRetailerRolesList();
    if (enrollment == UserTypeForWeb.retailer) {
      storeList = await _settings.getStores();
    }
    taxIdTypeData = (await _settings.getTaxIdType()).data!;

    setBusy(false);
    notifyListeners();
  }

  getRetailerRolesListEdit({String? id}) async {
    setBusy(true);
    notifyListeners();

    UserDetailsModel userDetailsModel = await _settings.getUserDetails(id);

    roleList = await _settings.getRetailerRolesList();
    if (enrollment == UserTypeForWeb.retailer) {
      storeList = await _settings.getStores();
    }
    taxIdTypeData = (await _settings.getTaxIdType()).data!;

    preFill(userDetailsModel.data!);

    setBusy(false);
    notifyListeners();
  }

  List dataStore = [];
  List dataRole = [];

  preFill(UserDetailsData? retailerUsersData) {
    List stores = retailerUsersData!.storeNameList!;
    List role = retailerUsersData.role!.split(",");

    String idTypeGet = "RNC";
    selectedStoreList =
        (storeList.where((e) => stores.any((i) => i == e.uniqueId)).toList());

    selectedRoleList =
        (roleList.where((e) => role.any((i) => i == e.roleName)).toList());
    for (int i = 0; i < selectedStoreList.length; i++) {
      dataStore.add(
          {'parameter': 'unique_id', 'value': selectedStoreList[i].uniqueId});
    }
    for (int i = 0; i < selectedRoleList.length; i++) {
      dataRole.add(
          {'parameter': 'role_name', 'value': selectedRoleList[i].roleName!});
    }

    notifyListeners();
    selectedStatus = status[retailerUsersData.status!];
    selectedTaxIdType =
        taxIdTypeData.where((element) => element.taxIdType == idTypeGet).first;
    firstNameController.text = retailerUsersData.firstName!;
    lastNameController.text = retailerUsersData.lastName!;
    emailNameController.text = retailerUsersData.email!;
    idDocumentNameController.text = "12123123123123123";
    notifyListeners();
  }

  selectID(TaxIdTypeData v) {
    selectedTaxIdType = v;
    notifyListeners();
  }

  selectStatus(String v) {
    selectedStatus = v;
    notifyListeners();
  }

  putSelectedRoleList(List v) {
    selectedRoleList = List<RetailerRolesData>.from(jsonDecode(jsonEncode(v))
        .map((model) => RetailerRolesData.fromJson(model)));

    notifyListeners();
  }

  putSelectedUserList(List v) {
    selectedStoreList = List<StoreData>.from(
        jsonDecode(jsonEncode(v)).map((model) => StoreData.fromJson(model)));

    notifyListeners();
  }

  void removeRoleItem(String item) {
    int index =
        selectedRoleList.indexWhere((element) => element.roleName == item);
    selectedRoleList.removeAt(index);
    notifyListeners();
  }

  void removeStoreItem(String item) {
    int index = selectedStoreList
        .indexWhere((element) => element.name == item.split('-')[0]);
    selectedStoreList.removeAt(index);

    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.userList, pathParameters: {'page': '1'});
  }

  addEditUser(BuildContext context) async {
    if (firstNameController.text.isEmpty) {
      errorFirstNameMessage =
          AppLocalizations.of(context)!.firstnameErrorMessage;
    } else {
      errorFirstNameMessage = "";
    }
    if (lastNameController.text.isEmpty) {
      errorLastNameMessage = AppLocalizations.of(context)!.lastNameErrorMessage;
    } else {
      errorLastNameMessage = "";
    }
    if (emailNameController.text.isEmpty) {
      errorEmailNameMessage =
          AppLocalizations.of(context)!.emptyEmailValidationTextForUser;
    } else if (!EmailValidator.validate(emailNameController.text)) {
      errorEmailNameMessage =
          AppLocalizations.of(context)!.wrongEmailFormatValidationText;
    } else {
      errorEmailNameMessage = "";
    }
    if (idDocumentNameController.text.isEmpty) {
      errorIdDocNameMessage = AppLocalizations.of(context)!.idDocErrorMessage;
    } else {
      errorIdDocNameMessage = "";
    }
    if (selectedTaxIdType == null) {
      errorIdTypeMessage = AppLocalizations.of(context)!.idTypeErrorMessage;
    } else {
      errorIdTypeMessage = "";
    }
    if (enrollment == UserTypeForWeb.retailer) {
      if (selectedStoreList.isEmpty) {
        errorStoreMessage = AppLocalizations.of(context)!.storeErrorMessage;
      } else {
        errorStoreMessage = "";
      }
    }
    if (selectedRoleList.isEmpty) {
      errorRoleMessage = AppLocalizations.of(context)!.roleErrorMessage;
    } else {
      errorRoleMessage = "";
    }

    notifyListeners();
    List storeUniqueIds = selectedStoreList.map((e) => e.uniqueId).toList();
    List rolesUniqueIds = selectedRoleList.map((e) => e.roleName).toList();
    if (errorFirstNameMessage.isEmpty &&
        errorLastNameMessage.isEmpty &&
        errorEmailNameMessage.isEmpty &&
        errorIdDocNameMessage.isEmpty &&
        errorIdTypeMessage.isEmpty &&
        errorStoreMessage.isEmpty &&
        errorRoleMessage.isEmpty) {
      isButtonBusy = true;
      notifyListeners();
      var body = {
        SpecialKeys.firstName: firstNameController.text,
        SpecialKeys.lastName: lastNameController.text,
        SpecialKeys.email: emailNameController.text,
        SpecialKeys.idType: selectedTaxIdType!.taxIdType!,
        SpecialKeys.idDocument: idDocumentNameController.text,
        SpecialKeys.roles: rolesUniqueIds
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        SpecialKeys.status:
            selectedStatus!.toLowerCase() == "active" ? "1" : "0"
      };
      if (enrollment == UserTypeForWeb.retailer) {}
      body.addAll({
        SpecialKeys.storeIds: storeUniqueIds
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", "")
      });
      if (isEdit) {
        body.addAll({SpecialKeys.uniqueId: uId});
      }
      ResponseMessages response =
          await _repositoryRetailer.addEditUser(body, isEdit);

      if (response.success!) {
        if (context.mounted) {
          goBack(context);
        }
      }
    } else {
      isButtonBusy = false;
      notifyListeners();
    }
    isButtonBusy = false;
    notifyListeners();
  }
}
