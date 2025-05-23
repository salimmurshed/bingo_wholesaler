import 'package:bingo/app/locator.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/repository/repository_customer.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../widgets/web_widgets/alert_dialod.dart';

class RetailerProfileViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  AssociationWholesalerRequestDetailsModel? data;
  ScrollController scrollController = ScrollController();
  TextEditingController comNameController = TextEditingController();
  TextEditingController dateFoundedController = TextEditingController();
  TextEditingController webUrlController = TextEditingController();
  TextEditingController legalNameController = TextEditingController();
  TextEditingController taxIDController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String aboutUs = "";

  FocusNode aboutUsFocusNode = FocusNode();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getProfile(String? uid) async {
    setBusy(true);
    notifyListeners();
    data = await _customerRepository.getCustomerProfileWeb(uid!);
    comNameController.text =
        data!.data![0].companyInformation![0].commercialName!;
    dateFoundedController.text =
        data!.data![0].companyInformation![0].dateFounded!;
    webUrlController.text = data!.data![0].companyInformation![0].website!;
    aboutUs = data!.data![0].companyInformation![0].bpCompanyAboutUs!;

    legalNameController.text =
        "${data!.data![0].contactInformation![0].firstName!} ${data!.data![0].contactInformation![0].lastName!}";
    taxIDController.text = data!.data![0].companyInformation![0].taxId!;
    businessAddressController.text =
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
