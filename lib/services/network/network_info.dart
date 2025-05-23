import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../const/utils.dart';

@lazySingleton
class NetworkInfoService {
  Future<bool> get isConnected async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<LocationPermission> permissionHandle() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Utils.toast('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Utils.toast(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }
}
