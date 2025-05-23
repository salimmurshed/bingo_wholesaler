import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../const/utils.dart';
import '../../presentation/widgets/utils_folder/connection_widget.dart';

@lazySingleton
class ConnectivityService {
  Connectivity connectivity = Connectivity();
  ReactiveValue<bool> connection = ReactiveValue<bool>(true);

  // ConnectivityService() {
  //   checkConnection();
  // }
  //
  // checkConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       // Utils.toast('connected');
  //     }
  //   } on SocketException catch (_) {
  //     Utils.toast('not connected');
  //   }
  // }
  bool isConnected = false;

  connectionStream() {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (BuildContext context, snapshot) {
          var connectivityResult = snapshot.data;
          if (connectivityResult != null &&
              connectivityResult == ConnectivityResult.none) {
            // getConnectionStatus(false);
            isConnected = false;
            return const ConnectionWidget();
          } else {
            // getConnectionStatus(true);
            isConnected = true;
            return const SizedBox();
          }
        });
  }

  connectionStreamForSale() {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (BuildContext context, snapshot) {
          var connectivityResult = snapshot.data;
          if (connectivityResult != null &&
              connectivityResult == ConnectivityResult.none) {
            // getConnectionStatus(false);
            isConnected = false;
            return const SizedBox();
          } else {
            // getConnectionStatus(true);
            isConnected = true;
            return const SizedBox();
          }
        });
  }
}
