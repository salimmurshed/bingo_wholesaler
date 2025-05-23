import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/retailer_wholesaler_association_request_model/retailer_wholesaler_association_request_model.dart';
import '../../../../repository/repository_customer.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../../widgets/web_widgets/alert_dialod.dart';

class WholesalerDetailsViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  int screenTab = 0;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController associateDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  RetailerAssociationRequestDetailsModel? data;

  void changeScreenTab(int v) {
    screenTab = v;
    notifyListeners();
  }

  nextItem() {
    screenTab += 1;
    notifyListeners();
  }

  previousItem() {
    screenTab -= 1;
    notifyListeners();
  }

  Future<void> getData(String? uid) async {
    setBusy(true);
    notifyListeners();
    data = await _customerRepository.getRetailerSideWholesalerDetails(uid!);
    companyNameController.text =
        data!.data![0].companyInformation![0].companyName!;
    taxIdController.text = data!.data![0].companyInformation![0].taxId!;
    associateDateController.text =
        data!.data![0].companyInformation![0].associationDate!;
    addressController.text =
        data!.data![0].companyInformation![0].companyAddress!;
    fNameController.text = data!.data![0].contactInformation![0].firstName!;
    lNameController.text = data!.data![0].contactInformation![0].lastName!;
    positionController.text = data!.data![0].contactInformation![0].position!;
    idController.text = data!.data![0].contactInformation![0].id!;
    phoneController.text = data!.data![0].contactInformation![0].phoneNumber!;
    setBusy(false);
    notifyListeners();
  }

  void viewDocuments() {
    _navigationService.animatedDialog(AlertDialogWeb(
      header: "Business Partner Approval",
      widget: SizedBox(
        width: 70.0.wp,
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            for (int i = 0;
                i <
                    data!.data![0].contactInformation![0].companyDocument!
                        .length;
                i++)
              ImageNetwork(
                  image: data!
                      .data![0].contactInformation![0].companyDocument![i].url!,
                  height: 80,
                  width: 80),
          ],
        ),
      ),
    ));
  }
}
