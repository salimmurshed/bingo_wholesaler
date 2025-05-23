import '../../../data_models/enums/user_type_for_web.dart';
import '/services/auth_service/auth_service.dart';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../data_models/construction_model/route_zone_argument_model/route_zone_argument_model.dart';
import '../../../data_models/construction_model/routes_argument_model/routes_argument_model.dart';
import '../../../data_models/models/routes_details_model/routes_details_model.dart';
import '../../../data_models/models/sales_zone_details_model/sales_zone_details_model.dart';
import '../../../repository/repository_wholesaler.dart';
import '../../../services/navigation/navigation_service.dart';

class RouteDetailsViewModel extends ReactiveViewModel {
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  RoutesDetailsModelData get routesDetailsModelData =>
      _repositoryWholesaler.routesDetailsModelData;

  SaleZonesDetailsData get saleZonesDetailsData =>
      _repositoryWholesaler.saleZonesDetailsData;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  RoutesZoneArgumentModel? routesZoneArgument;
  bool isZone = false;

  setData(RoutesZoneArgumentModel routesZoneArgumentModel) async {
    print(routesZoneArgumentModel.uniqueId);
    await getData(routesZoneArgumentModel);
  }

  void gotoMap(
      {LocationsDetails? locationsDetails,
      LocationsDetailsSales? locationsDetailsSales}) {
    RoutesZonesArgumentData data = RoutesZonesArgumentData(
      locationId: locationsDetails != null
          ? locationsDetails.locationId
          : locationsDetailsSales!.locationId,
      visitOrder: locationsDetails != null ? locationsDetails.visitOrder : 0,
      routeId: routesZoneArgument!.routeId,
      retailerInternalId: locationsDetails != null
          ? locationsDetails.retailerInternalId
          : locationsDetailsSales!.retailerInternalId,
      retailerName: locationsDetails != null
          ? locationsDetails.retailerName
          : locationsDetailsSales!.retailerName,
      storeId: locationsDetails != null
          ? locationsDetails.storeId
          : locationsDetailsSales!.storeId,
      storeName: locationsDetails != null
          ? locationsDetails.storeName
          : locationsDetailsSales!.storeName,
      storeAddress: locationsDetails != null
          ? locationsDetails.storeAddress
          : locationsDetailsSales!.storeAddress,
      latitude: locationsDetails != null
          ? locationsDetails.lattitude
          : locationsDetailsSales!.lattitude,
      longitude: locationsDetails != null
          ? locationsDetails.longitude
          : locationsDetailsSales!.longitude,
      status: locationsDetails != null
          ? locationsDetails.status
          : locationsDetailsSales!.status,
      statusDescription: locationsDetails != null
          ? locationsDetails.statusDescription
          : locationsDetailsSales!.statusDescription,
    );
    _navigationService.pushNamed(Routes.routesMap, arguments: data);
  }

  Future getData(RoutesZoneArgumentModel routesZoneArgumentModel) async {
    routesZoneArgument = routesZoneArgumentModel;
    isZone = routesZoneArgumentModel.isZone;
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.getRoutesDetails(routesZoneArgumentModel);
    //     .catchError((e) {
    //   print(e);
    //   _navigationService.pop();
    // });
    setBusy(false);
    notifyListeners();
  }
}
