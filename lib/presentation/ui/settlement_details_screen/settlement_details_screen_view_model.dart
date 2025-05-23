import 'dart:convert';

import '/const/app_extensions/strings_extention.dart';
import '/repository/repository_retailer.dart';
import '/services/auth_service/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data_models/models/settlement_details_model/settlement_details_model.dart';
import '../../../data_models/models/user_model/user_model.dart';

class SettlementDetailsScreenViewModel extends ReactiveViewModel {
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final AuthService _authService = locator<AuthService>();

  UserModel get user => _authService.user.value;

  String get language => _authService.selectedLanguageCode;

  SettlementDetailsData get settlementDetailsData =>
      _repositoryRetailer.settlementDetailsData;

  setDatas(String id) async {
    print('ididididid');
    print(id);
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerSettlementDetails(id);

    print('ididididid');
    print(jsonEncode(settlementDetailsData));
    setBusy(false);
    notifyListeners();
  }

  String userNameWithTx() {
    String u = "${user.data!.firstName!} ${user.data!.lastName!}";
    String u1 = user.data!.tempTxAddress!.lastChars(10);
    return "$u ($u1)";
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];
}
