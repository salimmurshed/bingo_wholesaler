// import 'package:biometric_storage/biometric_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:logging/logging.dart';
// import 'package:logging_appenders/logging_appenders.dart';
// import 'package:flutter/material.dart';
//
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BioMetric {
  static Future<bool> startBio() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      dynamic didAuthenticate = await auth.authenticate(
        localizedReason:
            'Scan your fingerdebugPrint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );

      return didAuthenticate;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> getAvailableBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
