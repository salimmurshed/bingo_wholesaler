import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/product_summary_model.dart';
import '../../../../services/auth_service/auth_service.dart';

class ProductSummaryViewModel extends BaseViewModel {
  ProductSummaryViewModel() {
    getPricingGroups();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  List<String> pricingGroups = [];
  List<ProductSummaryData> summaryList = [];
  ScrollController scrollController = ScrollController();
  getPricingGroups() async {
    List<String> d = await _wholesaler.getPricingGroups();
    pricingGroups = List.from(d.reversed);
    notifyListeners();
    ProductSummaryModel data = await _wholesaler.getPricingSummary();
    summaryList = data.data!;
    notifyListeners();
  }

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }
}
