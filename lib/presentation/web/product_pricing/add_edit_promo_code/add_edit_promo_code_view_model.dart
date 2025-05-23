import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/app_colors.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../../app/app_secrets.dart';
import '../../../../const/special_key.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/promo_code_model/promo_code_model.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../widgets/alert/date_picker.dart';

class AddEditPromoCodeViewModel extends BaseViewModel {
  AddEditPromoCodeViewModel() {}
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  TextEditingController promocodeTextEditingController =
      TextEditingController();
  TextEditingController startDateTextEditingController =
      TextEditingController();
  TextEditingController endDateTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  String errorPromoCodeMessage = "";
  String errorStartDateMessage = "";
  String errorEndDateMessage = "";
  String errorDescriptionMessage = "";
  String id = "";

  bool isEdit = false;

  bool isButtonBusy = false;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void goBack(BuildContext context) {
    context.goNamed(Routes.promoCodeView, pathParameters: {'page': '1'});
  }

  void preFill(BuildContext context, String data) {
    isEdit = true;
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    String b = data.replaceAll("()", "/").replaceAll(")(", "+");
    var bb = encrypter.decrypt64(b, iv: SpecialKeys.iv);
    PromoCodeData p = PromoCodeData.fromJson(jsonDecode(bb));
    id = p.uniqueId!;
    promocodeTextEditingController.text = p.promocode!;
    descriptionTextEditingController.text = p.description!;
    startDateTextEditingController.text = DateFormat(SpecialKeys.dateMMDDYYYY)
        .format(DateTime.parse(p.startDate!));
    endDateTextEditingController.text =
        DateFormat(SpecialKeys.dateMMDDYYYY).format(DateTime.parse(p.endDate!));
  }

  Future<void> dateSelect(BuildContext context, int fieldNumber) async {
    // String selectDate;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: AppColors.bingoGreen, // header background color
              onPrimary: AppColors.blackColor, // header text color
              onSurface: AppColors.blackColor, // body text color
            )),
            child: child!,
          );
        });

    if (fieldNumber == 0) {
      startDateTextEditingController.text =
          DateFormat(SpecialKeys.dateMMDDYYYY).format(picked!);
    } else {
      endDateTextEditingController.text =
          DateFormat(SpecialKeys.dateMMDDYYYY).format(picked!);
    }
    notifyListeners();
  }

  String body1 = '';

  Future<void> addEditPromoCode(BuildContext context) async {
    checkValidation(context);

    if (errorPromoCodeMessage.isEmpty &&
        errorStartDateMessage.isEmpty &&
        errorEndDateMessage.isEmpty &&
        errorDescriptionMessage.isEmpty) {
      isButtonBusy = true;
      notifyListeners();
      var body = {
        'promocode': promocodeTextEditingController.text,
        'start_date': startDateTextEditingController.text,
        'end_date': endDateTextEditingController.text,
        'description': descriptionTextEditingController.text,
        'status': '1'
      };
      if (isEdit) {
        body.addAll({'unique_id': id});
      }

      ResponseMessageModel response = await _wholesaler.addEditPromoCode(body);
      isButtonBusy = false;
      notifyListeners();
      Utils.toast(response.message!, isSuccess: response.success!);
    }
  }

  void checkValidation(context) {
    if (promocodeTextEditingController.text.isEmpty) {
      errorPromoCodeMessage = AppLocalizations.of(context)!
          .addPromo_textField_promoFieldErrorMessage;
    } else {
      errorPromoCodeMessage = "";
    }
    if (startDateTextEditingController.text.isEmpty) {
      errorStartDateMessage = AppLocalizations.of(context)!
          .addPromo_textField_startDateFieldErrorMessage;
    } else {
      errorPromoCodeMessage = "";
    }
    if (endDateTextEditingController.text.isEmpty) {
      errorEndDateMessage = AppLocalizations.of(context)!
          .addPromo_textField_endDateFieldErrorMessage;
    } else {
      errorEndDateMessage = "";
    }
    if (descriptionTextEditingController.text.isEmpty) {
      errorDescriptionMessage = AppLocalizations.of(context)!
          .addPromo_textField_descriptionErrorMessage;
    } else {
      errorDescriptionMessage = "";
    }
    notifyListeners();
  }
}
