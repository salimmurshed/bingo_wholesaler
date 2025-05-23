import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../data_models/construction_model/route_zone_argument_model/route_zone_argument_model.dart';
import '../../../data_models/models/routes_details_model/routes_details_model.dart';
import '../../../services/navigation/navigation_service.dart';

class RoutesMapViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> controllerCompleter =
      Completer<GoogleMapController>();
  RoutesZonesArgumentData locationData = RoutesZonesArgumentData();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 20.4746,
  );

  String placeName = "";

  void setData(RoutesZonesArgumentData arguments) {
    locationData = arguments;
    print(locationData.latitude);
    print(locationData.longitude);
    kGooglePlex = CameraPosition(
      target: LatLng(
          double.parse(
              locationData.latitude!.isEmpty ? '0.0' : locationData.latitude!),
          double.parse(locationData.longitude!.isEmpty
              ? '0.0'
              : locationData.longitude!)),
      zoom: 20.4746,
    );
    notifyListeners();
  }

  void gotoAddSale() {
    _navigationService.pushNamed(Routes.addSales, arguments: locationData);
  }
}
