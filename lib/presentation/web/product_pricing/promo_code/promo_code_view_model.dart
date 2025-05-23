import 'dart:convert';

import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_website_settings.dart';
import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app_secrets.dart';
import '../../../../app/locator.dart';
import '../../../../const/special_key.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/promo_code_model/promo_code_model.dart';
import '../../../../repository/repository_wholesaler.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class PromoCodeViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();

  final RepositoryWebsiteSettings _settings =
      locator<RepositoryWebsiteSettings>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  List<PromoCodeData> promoCodeData = [];

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getPromoCode(String page) async {
    setBusy(true);
    notifyListeners();
    PromoCodeModel promoCodeList =
        await _wholesaler.getPromoCode(pageNumber.toString());
    promoCodeData = promoCodeList.data!.data!;
    pageNumber = int.parse(page);
    totalPage = promoCodeList.data!.lastPage!;
    pageTo = promoCodeList.data!.to!;
    pageFrom = promoCodeList.data!.from!;
    dataTotal = promoCodeList.data!.total!;
    setBusy(false);
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    context.goNamed(Routes.promoCodeView,
        pathParameters: {'page': page.toString()});
    getPromoCode(page.toString());
    notifyListeners();
  }

  void addNew(BuildContext context) {
    context.goNamed(Routes.addPromoCodeView, pathParameters: {});
  }

  void editNew(BuildContext context, String id, PromoCodeData promoCodeData) {
    var body = {
      'unique_id': promoCodeData.uniqueId!,
      'promocode': promoCodeData.promocode!,
      'start_date': promoCodeData.startDate,
      'end_date': promoCodeData.endDate,
      'status': promoCodeData.status,
      'description': promoCodeData.description
    };

    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    String b = encrypter.encrypt(jsonEncode(body), iv: SpecialKeys.iv).base64;
    String bReplaced = b.replaceAll("/", "()").replaceAll("+", ")(");
    context
        .goNamed(Routes.editPromoCodeView, pathParameters: {'data': bReplaced});
  }
}
