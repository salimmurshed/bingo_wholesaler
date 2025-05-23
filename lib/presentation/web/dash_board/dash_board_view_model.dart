import 'package:bingo/data_models/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '/app/locator.dart';
import '/services/auth_service/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../data/data_source/cards_properties_list.dart';
import '../../../data/data_source/date_filters.dart';
import '../../../data_models/construction_model/dashboard_card_properties_model/dashboard_card_properties_model.dart';
import '../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../../services/web_basic_service/WebBasicService.dart';

class DashBoardViewModel extends ReactiveViewModel {
  DashBoardViewModel() {
    _authService.getLoggedUserDetails();
  }
  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authService, _webBasicService];
  List<DashboardCardPropertiesModel> retailerCardsPropertiesList =
      retailerCardsPropertiesListData;

  List<DateFilterModel> get dateFilters => dateFilterList;
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final AuthService _authService = locator<AuthService>();
  DateFilterModel selectedDateFilter = dateFilterList[0];

  UserModel get user => _authService.user.value;

  String get tabNumber => _webBasicService.tabNumber.value;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void changeFilterDate(DateFilterModel filteredDate) {
    selectedDateFilter = filteredDate;
    // getDepositRecommendation(filteredDate.initiate!);
    notifyListeners();
  }
}
