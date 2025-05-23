import 'dart:io';

import '/const/app_colors.dart';
import '/const/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/locator.dart';
import '../../../services/navigation/navigation_service.dart';

class QRViewScanner extends StatefulWidget {
  const QRViewScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScannerState();
}

class _QRViewScannerState extends State<QRViewScanner> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  cameraOn() async {
    controller!.resumeCamera().then((value) => setState(() {
          isCameraOn = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blackColor,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  color: AppColors.loader1,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
          ),
          Expanded(flex: 10, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // setState(() {
    //   this.controller = controller;
    //   controller.resumeCamera();
    // });
    Future.delayed(Duration.zero).then((_) {
      controller.scannedDataStream.listen((scanData) {
        locator<NavigationService>().pop(scanData);

        controller.dispose();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      Utils.toast(AppLocalizations.of(context)!.noCameraPermissionMessage);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('no camera permission')),
      // );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
