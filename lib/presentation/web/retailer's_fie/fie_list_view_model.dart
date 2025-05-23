import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/retailer_association_fie_list/retailer_association_fie_list.dart';
import '../../../repository/repository_retailer.dart';
import '../../../services/auth_service/auth_service.dart';

class FieListViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  RetailerAssociationFieList? fieModel;
  List<RetailerAssociationFieListData> fieList = [];

  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  int totalPage = 0;
  int pageTo = 0;
  int pageFrom = 0;
  int dataTotal = 0;

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  getFieList(page) async {
    pageNumber = int.parse(page);
    fieModel =
        await _repositoryRetailer.getRetailerFieListWeb(pageNumber.toString());
    fieList = fieModel!.data!.data!;
    totalPage = fieModel!.data!.lastPage ?? 0;
    pageTo = fieModel!.data!.to ?? 0;
    pageFrom = fieModel!.data!.from ?? 0;
    dataTotal = fieModel!.data!.total ?? 0;
    notifyListeners();
  }

  void changePage(BuildContext context, int page) {
    pageNumber = page;
    context.goNamed(Routes.fieListView,
        queryParameters: {'page': page.toString()});
    getFieList(page.toString());
    notifyListeners();
  }

  void action(BuildContext context, String id) {
    context.goNamed(Routes.fieDetailsView, queryParameters: {"id": id});
  }
}
