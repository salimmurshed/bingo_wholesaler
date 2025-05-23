import 'package:bingo/app/locator.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/product_summary_model.dart';
import '../../../../repository/repository_wholesaler.dart';
import '../../../../services/auth_service/auth_service.dart';

class ProductDetailsViewModel extends BaseViewModel {
  ProductDetailsViewModel() {
    getPricingGroups();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;

  List<ProductSummaryData> productList = [];
  ScrollController scrollController = ScrollController();
  getPricingGroups() async {
    ProductSummaryModel data = await _wholesaler.getPricingSummary();
    productList = data.data!;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }
}
