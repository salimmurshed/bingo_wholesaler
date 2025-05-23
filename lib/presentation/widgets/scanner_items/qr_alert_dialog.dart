import 'dart:convert';

import '../../../const/special_key.dart';
import '../../../const/utils.dart';
import '/const/all_const.dart';
import '/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../app/app_secrets.dart';
import '../../../data_models/enums/sale_qr_states.dart';
import '../buttons/submit_button.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class QRAlertDialog extends StatefulWidget {
  SaleQrState state;
  AllSalesData allSalesData;
  bool isRetailer;

  QRAlertDialog(this.allSalesData,
      {super.key, this.state = SaleQrState.scanInit, required this.isRetailer});

  @override
  State<QRAlertDialog> createState() => _QRAlertDialogState();
}

class _QRAlertDialogState extends State<QRAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.all(0),
      title: Text(
        AppLocalizations.of(context)!.offlineSalesProcess.toUpperCase(),
        style: AppTextStyles.salesScannerDialog
            .copyWith(fontWeight: AppFontWeighs.semiBold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              AppLocalizations.of(context)!.offlineSalesProcessBodyForScan(
                  widget.isRetailer
                      ? widget.allSalesData.wholesalerName!
                      : widget.allSalesData.retailerName!,
                  widget.isRetailer
                      ? AppLocalizations.of(context)!.wholesaler.toLowerCase()
                      : AppLocalizations.of(context)!.retailer.toLowerCase()),
              style: AppTextStyles.salesScannerDialog,
              textAlign: TextAlign.start,
            ),
          ),
          if (widget.state == SaleQrState.scanning)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SizedBox(
                width: 100.0.wp,
                height: 100.0.wp,
                child: _buildQrCode(widget.allSalesData),
              ),
            ),
          if (widget.state == SaleQrState.scanInit)
            SizedBox(
              height: 100.0.wp,
              child: Center(
                child: SubmitButton(
                    onPressed: () {
                      widget.state = SaleQrState.scanning;
                      setState(() {});
                    },
                    width: 50.0.wp,
                    text: AppLocalizations.of(context)!.showQrCodeButton,
                    color: AppColors.activeButtonColor),
              ),
            ),
          Center(
            child: SubmitButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 50.0.wp,
                text: AppLocalizations.of(context)!.complete,
                color: widget.state == SaleQrState.scanning
                    ? AppColors.activeButtonColor
                    : AppColors.inactiveButtonColor2),
          ),
        ],
      ),
    );
  }

  _buildQrCode(AllSalesData allSalesData) {
    Map<String, dynamic> myData = {
      "1": allSalesData.uniqueId,
      "2": allSalesData.invoiceNumber,
      "3": allSalesData.orderNumber,
      '4': allSalesData.saleDate,
      '5': allSalesData.saleType,
      '6': allSalesData.storeId,
      '7': allSalesData.currency, //can reduce
      '8': allSalesData.amount,
      '9': allSalesData.bingoOrderId, //can reduce
      'a': allSalesData.status,
      'b': allSalesData.description,
      'c': allSalesData.wholesalerStoreId, //can reduce
      'd': allSalesData.fieName, //can reduce
      'e': allSalesData.wholesalerTempTxAddress,
      'f': allSalesData.retailerTempTxAddress,
      'g': allSalesData.isStartPayment,
      'h': allSalesData.balance,
      'i': allSalesData.isAppUniqId,
      'j': allSalesData.action,
      // 'j': allSalesData.retailerName,
      // 'k': allSalesData.wholesalerName
    };

    debugPrint('myData');
    debugPrint(jsonEncode(myData));
    String encodedJson = jsonEncode(myData);
    // var encrypted = Encryptor.encrypt(AppSecrets.qrKey, encodedJson);
    var encrypted = Utils.encrypter
        .encrypt(jsonEncode(encodedJson), iv: SpecialKeys.iv)
        .base64;
    debugPrint(encrypted);

    return SizedBox(
      width: 100.0.wp,
      height: 100.0.hp,
      child: CustomPaint(
        painter: QrPainter(
          version: QrVersions.auto,
          gapless: false,
          data: encrypted,
          // symbology: QRCode(
          //   codeVersion: QRCodeVersion.auto,
          //   inputMode: QRInputMode.alphaNumeric,
          // ),
        ),
      ),
    );
    // return SizedBox(
    //   width: 100.0.wp,
    //   height: 100.0.hp,
    //   child: QrImage(
    //     gapless: false,
    //     data: encrypted,
    //     // symbology: QRCode(
    //     //   codeVersion: QRCodeVersion.auto,
    //     //   inputMode: QRInputMode.alphaNumeric,
    //     // ),
    //   ),
    // );
  }
}
