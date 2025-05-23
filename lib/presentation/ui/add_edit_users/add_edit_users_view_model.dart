import '../../../data_models/enums/user_roles_files.dart';
import '/app/locator.dart';
import '/repository/repository_components.dart';
import '/services/auth_service/auth_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/email_validator.dart';
import '../../../const/special_key.dart';
import '../../../data_models/models/component_models/retailer_role_model.dart';
import '../../../data_models/models/component_models/tax_id_type_model.dart';
import '../../../data_models/models/retailer_users_model/retailer_users_model.dart';
import '../../../data_models/models/store_model/store_model.dart';
import '../../../main.dart';
import '../../../repository/repository_retailer.dart';

class AddEditUsersViewModel extends BaseViewModel {
  AddEditUsersViewModel() {
    status = allStatus[0];
    if (_repositoryComponents.taxIdType.data == null) {
      getTaxIdType();
    }
  }

  getTaxIdType() async {
    setBusy(true);
    notifyListeners();
    await _repositoryComponents.getTaxIdType();
    setBusy(false);
    notifyListeners();
  }

  //services
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  //services variables
  List<TaxIdTypeData>? get taxIdType => _repositoryComponents.taxIdType.data;

  List<StoreData> get storeList => _repositoryRetailer.storeList;

  String get language => _authService.user.value.data!.languageCode!;

  List<RetailerRolesData> get retailerRolesList =>
      _repositoryComponents.retailerRolesList.value.data!;

  //local variables
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController idDocumentNameController = TextEditingController();

  List<String> get allStatus {
    if (language.toLowerCase() == "en") {
      return ["Active", "Inactive"];
    } else {
      return ["Activar", "Desactivar"];
    }
  }

  String? status;
  TaxIdTypeData? selectedTaxIdType;
  List<StoreData> selectedStoreList = [];
  List<RetailerRolesData> selectedRetailerRoles = [];
  bool isButtonBusy = false;
  bool isEdit = false;
  String uId = "";

  String title = AppLocalizations.of(activeContext)!.addUser;

  String addButtonText = AppLocalizations.of(activeContext)!.add;

  String errorFirstNameMessage = "";
  String errorLastNameMessage = "";
  String errorEmailNameMessage = "";
  String errorIdDocNameMessage = "";
  String errorIdTypeMessage = "";
  String errorStoreMessage = "";
  String errorRoleMessage = "";

  // bool get isUserHaveAccess => _authService.isUserHaveAccess.value;
  bool isUserHaveAccess(UserRolesFiles userRolesFiles) {
    return _authService.isUserHaveAccess(userRolesFiles);
  }

  // bool get isUserAdminRole {
  //   return userRoles.contains(UserRoles.admin) ||
  //       userRoles.contains(UserRoles.master);
  // }

  void getSelectedStore(List<StoreData> v) {
    selectedStoreList = v;
    notifyListeners();
  }

  void getSelectedRoles(List<RetailerRolesData> v) {
    selectedRetailerRoles = v;
    notifyListeners();
  }

  void changeIdType(TaxIdTypeData? v) {
    selectedTaxIdType = v;
    notifyListeners();
  }

  void changeStatus(String? v) {
    status = v!;
    notifyListeners();
  }

  addEditUser() async {
    if (firstNameController.text.isEmpty) {
      errorFirstNameMessage =
          AppLocalizations.of(activeContext)!.firstnameErrorMessage;
    } else {
      errorFirstNameMessage = "";
    }
    if (lastNameController.text.isEmpty) {
      errorLastNameMessage =
          AppLocalizations.of(activeContext)!.lastNameErrorMessage;
    } else {
      errorLastNameMessage = "";
    }
    if (emailNameController.text.isEmpty) {
      errorEmailNameMessage =
          AppLocalizations.of(activeContext)!.emptyEmailValidationTextForUser;
    } else if (!EmailValidator.validate(emailNameController.text)) {
      errorEmailNameMessage =
          AppLocalizations.of(activeContext)!.wrongEmailFormatValidationText;
    } else {
      errorEmailNameMessage = "";
    }
    if (idDocumentNameController.text.isEmpty) {
      errorIdDocNameMessage =
          AppLocalizations.of(activeContext)!.idDocErrorMessage;
    } else {
      errorIdDocNameMessage = "";
    }
    if (selectedTaxIdType == null) {
      errorIdTypeMessage =
          AppLocalizations.of(activeContext)!.idTypeErrorMessage;
    } else {
      errorIdTypeMessage = "";
    }
    if (selectedStoreList.isEmpty) {
      errorStoreMessage = AppLocalizations.of(activeContext)!.storeErrorMessage;
    } else {
      errorStoreMessage = "";
    }
    if (selectedRetailerRoles.isEmpty) {
      errorRoleMessage = AppLocalizations.of(activeContext)!.roleErrorMessage;
    } else {
      errorRoleMessage = "";
    }

    notifyListeners();
    List storeUniqueIds = selectedStoreList.map((e) => e.uniqueId).toList();
    List rolesUniqueIds = selectedRetailerRoles.map((e) => e.roleName).toList();
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
        SpecialKeys.storeIds: storeUniqueIds
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        SpecialKeys.roles: rolesUniqueIds
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        SpecialKeys.status: status!.toLowerCase() == "active" ? "1" : "0"
      };

      if (isEdit) {
        body.addAll({SpecialKeys.uniqueId: uId});
      }
      await _repositoryRetailer.addEditUser(body, isEdit);
    } else {
      isButtonBusy = false;
      notifyListeners();
    }
    isButtonBusy = false;
    notifyListeners();
  }

  void setDetails(RetailerUsersData arguments) {
    uId = arguments.uniqueId!;
    isEdit = true;
    notifyListeners();

    title = AppLocalizations.of(activeContext)!.editUser;
    addButtonText = AppLocalizations.of(activeContext)!.edit;
    List stores = arguments.storeNameList!.split(',');
    List roles = arguments.role!.split(',');
    print('taxIdType');
    print(taxIdType);
    firstNameController.text = arguments.firstName!;
    lastNameController.text = arguments.lastName!;
    emailNameController.text = arguments.email!;
    idDocumentNameController.text = arguments.docId!;
    selectedTaxIdType = taxIdType!
        .firstWhereOrNull((element) => (element.taxIdType == arguments.idType));

    for (var element in storeList) {
      if (stores.contains(element.name)) {
        selectedStoreList.add(element);
      } else {}
    }
    for (var element in retailerRolesList) {
      if (roles.contains(element.roleName)) {
        selectedRetailerRoles.add(element);
      } else {}
    }
    notifyListeners();
  }

// String statusCheckUser(status) {
//   if (user.data!.languageCode!.toLowerCase() == 'en') {
//     return status!;
//   } else {
//     switch (status!.toLowerCase()) {
//       case "active":
//         return "Activa";
//       case "inactive":
//         return "Inactiva";
//     }
//     return "";
//   }
// }
}
