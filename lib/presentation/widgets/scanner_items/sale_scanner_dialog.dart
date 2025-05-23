import 'dart:convert';

import '../../../const/special_key.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '/app/locator.dart';
import '/const/all_const.dart';
import '/data_models/models/user_model/user_model.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/repository/repository_sales.dart';
import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../app/app_secrets.dart';
import '../../../const/utils.dart';
import '../../../data_models/enums/sale_qr_states.dart';

class SaleScannerDialog extends StatefulWidget {
  const SaleScannerDialog(
      {Key? key,
      this.isFromSaleDetailsScreen = false,
      this.forWhom = "",
      required this.isRetailer})
      : super(key: key);
  final bool isFromSaleDetailsScreen;
  final String forWhom;
  final bool isRetailer;

  @override
  State<SaleScannerDialog> createState() => _SaleScannerDialogState();
}

class _SaleScannerDialogState extends State<SaleScannerDialog> {
  SaleQrState state = SaleQrState.scanInit;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraOn = false;
  Barcode? scanData;

  UserModel user = locator<AuthService>().user.value;

  // bool isRetailer = locator<AuthService>().isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.resumeCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  cameraOn() async {
    controller!.resumeCamera().then((value) => setState(() {
          isCameraOn = true;
        }));
  }

  @override
  void initState() {
    if (widget.isFromSaleDetailsScreen) {
      state = SaleQrState.scanning;
    } else {
      if (enrollment == UserTypeForWeb.retailer) {
        state = SaleQrState.scanInit;
      } else {
        state = SaleQrState.preSaleScan;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.all(12),
      alignment: const Alignment(0, -0.5),
      title: Text(
        state == SaleQrState.scanInit
            ? AppLocalizations.of(context)!.headerScannerDialog.toUpperCase()
            : state == SaleQrState.preSaleScan
                ? AppLocalizations.of(context)!.preSaleDialogHead.toUpperCase()
                : AppLocalizations.of(context)!
                    .offlineSalesProcess
                    .toUpperCase(),
        style: AppTextStyles.salesScannerDialog
            .copyWith(fontWeight: AppFontWeighs.semiBold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.isFromSaleDetailsScreen
                  ? AppLocalizations.of(context)!.offlineSalesProcessBody(
                      widget.forWhom,
                      widget.isRetailer
                          ? AppLocalizations.of(context)!
                              .wholesaler
                              .toLowerCase()
                          : AppLocalizations.of(context)!
                              .retailer
                              .toLowerCase())
                  : state == SaleQrState.scanInit
                      ? AppLocalizations.of(context)!.bodyScannerDialog(
                          enrollment == UserTypeForWeb.retailer
                              ? "wholesaler"
                              : "retailer")
                      : state == SaleQrState.preSaleScan
                          ? AppLocalizations.of(context)!.preSaleDialogBody
                          : AppLocalizations.of(context)!
                              .offlineSalesProcessBodyWithoutName,
              style: AppTextStyles.salesScannerDialog,
              textAlign: TextAlign.start,
            ),
          ),
          if (state != SaleQrState.preSaleScan)
            SizedBox(
              height: 30.0.hp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state == SaleQrState.scanInit)
                    InkWell(
                      onTap: () {
                        state = SaleQrState.scanning;
                        setState(() {});
                      },
                      child: SizedBox(
                        width: 25.0.wp,
                        child: Image.asset(AppAsset.scanner),
                      ),
                    ),
                  if (state == SaleQrState.scanning)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                              borderColor: Colors.red,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: scanArea),
                          onPermissionSet: (ctrl, p) =>
                              _onPermissionSet(context, ctrl, p),
                        ),
                      ),
                    ),
                  if (state == SaleQrState.scanDone)
                    SizedBox(
                      width: 25.0.wp,
                      child: Image.asset(AppAsset.doneScan),
                    ),
                  if (state == SaleQrState.scanRejected)
                    SizedBox(
                      width: 25.0.wp,
                      child: Image.asset(AppAsset.closeScan),
                    ),
                  if (state == SaleQrState.scanInit)
                    Text(
                      AppLocalizations.of(context)!.scanButtonScannerDialog,
                      style: AppTextStyles.salesScannerDialog,
                    ),
                  if (state == SaleQrState.scanDone ||
                      state == SaleQrState.scanRejected)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        state == SaleQrState.scanDone
                            ? AppLocalizations.of(context)!.scannedSuccessful
                            : AppLocalizations.of(context)!.scannedRejected,
                        style: AppTextStyles.salesScannerDialog,
                      ),
                    ),
                ],
              ),
            ),
          if (state == SaleQrState.preSaleScan) 20.0.giveHeight,
          if (state == SaleQrState.scanInit)
            SubmitButton(
                onPressed: () {},
                width: 50.0.wp,
                text: AppLocalizations.of(context)!.complete,
                color: state == SaleQrState.scanning
                    ? AppColors.activeButtonColor
                    : AppColors.inactiveButtonColor2),
          if (state == SaleQrState.preSaleScan)
            SubmitButton(
                onPressed: initStateForWholesaler,
                width: 30.0.wp,
                text: AppLocalizations.of(context)!.ok,
                color: AppColors.activeButtonColor),
          if (state == SaleQrState.scanDone ||
              state == SaleQrState.scanRejected ||
              state == SaleQrState.scanning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CancelButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: AppLocalizations.of(context)!.cancelButton,
                  ),
                ),
                if (state == SaleQrState.scanDone)
                  Expanded(
                    flex: 1,
                    child: SubmitButton(
                        onPressed: () {
                          Navigator.pop(context, scanData);
                        },
                        text: AppLocalizations.of(context)!.nextButton,
                        color: AppColors.activeButtonColor),
                  ),
                if (state == SaleQrState.scanRejected)
                  Expanded(
                    flex: 1,
                    child: SubmitButton(
                        onPressed: scanAgain,
                        text: AppLocalizations.of(context)!.scanAgain,
                        color: AppColors.activeButtonColor),
                  ),
              ],
            )
        ],
      ),
    );
  }

  addToLocal() {
    locator<RepositorySales>().startBarcodeScanner2;
  }

  scanAgain() {
    setState(() {
      state = SaleQrState.scanning;
    });
  }

  initStateForWholesaler() {
    setState(() {
      state = SaleQrState.scanInit;
    });
  }

  // final encrypter = encrypt.Encrypter(
  //     encrypt.AES(AppSecrets.key, mode: encrypt.AESMode.cfb64));

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();

    Future.delayed(Duration.zero).then((_) {
      controller.scannedDataStream.listen((data) {
        setState(() {
          scanData = data;
          // var d = (Encryptor.decrypt(AppSecrets.qrKey, data.code!));
          String d = Utils.encrypter.decrypt64(data.code!, iv: SpecialKeys.iv);
          var p = json.decode(jsonEncode(jsonDecode(jsonDecode(d))));
          if (enrollment == UserTypeForWeb.retailer) {
            if (user.data!.tempTxAddress == p['f']) {
              setState(() {
                state = SaleQrState.scanDone;
              });
            } else {
              setState(() {
                state = SaleQrState.scanRejected;
              });
            }
          } else if (enrollment == UserTypeForWeb.wholesaler) {
            if (user.data!.tempTxAddress == p['e']) {
              debugPrint("hoynahoyna3");
              setState(() {
                state = SaleQrState.scanDone;
              });
            } else {
              debugPrint("hoynahoyna4");
              setState(() {
                state = SaleQrState.scanRejected;
              });
            }
          } else {
            setState(() {
              state = SaleQrState.scanRejected;
            });
          }
          controller.pauseCamera();
        });
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
