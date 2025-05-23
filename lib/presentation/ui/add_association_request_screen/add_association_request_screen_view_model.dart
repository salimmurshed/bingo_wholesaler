import '../../../data_models/enums/user_type_for_web.dart';
import '/data_models/enums/data_source.dart';
import '/presentation/widgets/alert/alert_dialog.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data_models/models/wholesaler_list_model/wholesaler_list_model.dart';
import '../../../repository/repository_retailer.dart';
import '../../../services/auth_service/auth_service.dart';

class AddAssociationRequestViewModel extends ReactiveViewModel {
  //services
  final AuthService _authService = locator<AuthService>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final NavigationService _navigationService = locator<NavigationService>();

  //services get variables
  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  List<WholeSalerOrFiaListData> get wholeSaleList =>
      _repositoryRetailer.wholeSaleList;

  List<WholeSalerOrFiaListData> get fiaList => _repositoryRetailer.fiaList;

  //local variables
  bool isAddRequestBusy = false;
  int wholesalerOrFia = 0;
  List<String> selectedWholeSaler = [];
  List<String> selectedFia = [];

  void changeTabBar(int i) {
    wholesalerOrFia = i;
    notifyListeners();
  }

  void setAddRequestBusy(bool v) {
    isAddRequestBusy = v;
    notifyListeners();
  }

  void cancelButtonPressed() {
    _navigationService.pop();
  }

  void addRemoveWholesaler(int i) {
    var data = selectedWholeSaler.contains(wholeSaleList[i].uniqueId);
    if (data) {
      selectedWholeSaler.remove(wholeSaleList[i].uniqueId!);
    } else {
      selectedWholeSaler.add(wholeSaleList[i].uniqueId!);
    }
    notifyListeners();
  }

  void addRemoveFia(int i) {
    var data = selectedFia.contains(fiaList[i].uniqueId);
    if (data) {
      selectedFia.remove(fiaList[i].uniqueId!);
    } else {
      selectedFia.add(fiaList[i].uniqueId!);
    }
    notifyListeners();
  }

  void sendWholesalerRequest() async {
    if (selectedWholeSaler.isEmpty) {
      _navigationService.animatedDialog(AlertDialogMessage(
          AppLocalizations.of(_navigationService.activeContext)!
              .needToSelectOneWholesaler));
    } else {
      setAddRequestBusy(true);
      await _repositoryRetailer.sendWholesalerRequest(selectedWholeSaler);
      notifyListeners();
      selectedWholeSaler.clear();
      setAddRequestBusy(false);
      notifyListeners();
    }
  }

  void setDetails(RetailerTypeAssociationRequest arguments) {
    wholesalerOrFia = arguments.index;
    notifyListeners();
  }

  void sendFiaRequest() async {
    if (selectedFia.isEmpty) {
      _navigationService.animatedDialog(AlertDialogMessage(
          AppLocalizations.of(_navigationService.activeContext)!
              .needToSelectFie));
    } else {
      setAddRequestBusy(true);
      await _repositoryRetailer.sendFiaRequest(selectedFia);
      await _repositoryRetailer.getRetailersAssociationData();
      selectedFia.clear();
      setAddRequestBusy(false);
      _navigationService.pop();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_repositoryRetailer];
}
