import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/app/app_config.dart';
import 'package:bingo/const/special_key.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import '../presentation/widgets/utils_folder/big_loader.dart';
import '../presentation/widgets/utils_folder/loader_busy.dart';
import '../presentation/widgets/utils_folder/status/status_widget_center.dart';
import '../presentation/widgets/utils_folder/status/transaction_status_widget.dart';
import '/const/all_const.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/main.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import '../services/storage/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../app/app_secrets.dart';
import '../data_models/enums/status_name.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

statusWidget({
  Color color = AppColors.statusProgress,
  String text = "",
  TextAlign textAlign = TextAlign.end,
  TextStyle textStyle = AppTextStyles.statusCardStatus,
  bool isIconAvailable = true,
  bool isCenter = false,
}) {
  return StatusWidgetCenter(
      color: color,
      text: text,
      textAlign: textAlign,
      textStyle: textStyle,
      isIconAvailable: isIconAvailable,
      isCenter: isCenter);

  // isCenter
  //   ? StatusWidgetCenter(
  //       text: text,
  //       color: color,
  //       textStyle: textStyle,
  //   textAlign:textAlign,isCenter:isCenter,
  //       isIconAvailable: isIconAvailable)
  //   : kIsWeb
  //       ? Padding(
  //           padding:
  //               const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
  //           child: Center(
  //             child: Text(
  //               text,
  //               textAlign: TextAlign.center,
  //               maxLines: 2,
  //               softWrap: true,
  //               style: textStyle.copyWith(color: color),
  //             ),
  //           ),
  //         )
  //       : SizedBox(
  //           width: 150,
  //           child: RichText(
  //             textAlign: textAlign,
  //             maxLines: 2,
  //             softWrap: true,
  //             text: TextSpan(
  //               children: [
  //                 if (isIconAvailable)
  //                   WidgetSpan(
  //                     child: Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 8, 4, 2),
  //                       child: Icon(
  //                         Icons.circle_rounded,
  //                         size: 10,
  //                         color: color,
  //                       ),
  //                     ),
  //                   ),
  //                 TextSpan(
  //                     text: text, style: textStyle.copyWith(color: color)),
  //               ],
  //             ),
  //           ),
  //         );
}

// Widget transactionStatusWidget({
//   Color color = AppColors.statusProgress,
//   String text = "",
//   TextAlign textAlign = TextAlign.start,
//   TextStyle textStyle = AppTextStyles.statusCardStatus,
// }) {
//   return TransactionStatusWidget(color, text, textAlign, textStyle);
// }

// statusWidgetCenter(
//     {Color color = AppColors.statusProgress,
//     String text = "",
//     bool isIconAvailable = true,
//     TextAlign textAlign = TextAlign.start,
//     TextStyle textStyle = AppTextStyles.statusCardStatus}) {
//   return SizedBox(
//     width: 100.0.wp,
//     child: Center(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment:
//             kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//         mainAxisAlignment:
//             kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.center,
//         children: [
//           if (isIconAvailable)
//             Image.asset(
//               AppAsset.statusIcon,
//               color: color,
//             ),
//           if (!isIconAvailable) SizedBox(),
//           Text(
//             text,
//             textAlign: textAlign,
//             maxLines: 1,
//             softWrap: true,
//             style: textStyle.copyWith(color: color),
//           ),
//         ],
//       ),
//     ),
//   );
// }

activeInactiveStatusWidget(
    {Color color = AppColors.statusProgress,
    String text = "",
    bool isIconAvailable = true,
    TextAlign textAlign = TextAlign.end,
    TextStyle textStyle = AppTextStyles.statusCardStatus}) {
  return RichText(
    textAlign: textAlign,
    maxLines: 2,
    softWrap: true,
    text: TextSpan(
      children: [
        if (isIconAvailable)
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 4, 2),
              child: Icon(
                Icons.circle_rounded,
                size: 10,
                color: color,
              ),
            ),
          ),
        TextSpan(text: text, style: textStyle.copyWith(color: color)),
      ],
    ),
  );
}

webStatusWidget(
    {Color color = AppColors.statusProgress,
    String text = "",
    TextStyle textStyle = AppTextStyles.statusCardStatus}) {
  Center(
    child: Text(
      text,
      textAlign: TextAlign.center,
      softWrap: true,
      style: textStyle.copyWith(color: color),
    ),
  );
}

StatusNames statusNamesEnumFromServer(text) {
  String newText =
      text.replaceAll("/", " ").replaceAll(" / ", " ").replaceAll(",", "");
  return convertToStatusNames(newText.toLowerCamelCase().replaceAll(" ", ""));
}

class Utils {
  Utils._();

  static String narrateFunction(String v) {
    return v.replaceAll("/", "").toLowerCase();
  }

  static webLoader() {
    return const SizedBox(
      width: 200.0,
      child: Center(
        child: SizedBox(
          height: 10.0,
          width: 10.0,
          child: CircularProgressIndicator(
            color: AppColors.loader1,
          ),
        ),
      ),
    );
  }

  static final encrypter = encrypt.Encrypter(
      encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cfb64));

  static String getEncryptedData(String value) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(
      value,
      iv: SpecialKeys.iv,
    );
    return encrypted.base64;
    // return value;
  }

  static ScrollPhysics pullScrollPhysic = const BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  static toast(String text,
      {bool isBottom = false, bool isSuccess = false, int sec = 5}) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: isBottom ? ToastGravity.SNACKBAR : ToastGravity.CENTER,
        timeInSecForIosWeb: sec,
        backgroundColor: isSuccess ? AppColors.greenColor : AppColors.redColor,
        textColor: Colors.white,
        webBgColor: isSuccess
            ? "linear-gradient(to right, #5DC151, #1E7FF7)"
            : "linear-gradient(to right, #f63f3f, #f63f3f)",
        fontSize: 16.0);
  }

  static Widget notificationNumberingDesign(String length,
      {double size = 20.0, color = AppColors.statusProgress}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: AutoSizeText(
          length,
          minFontSize: AppFontSize.s10,
          style: AppTextStyles.addRequestTabBar,
        ),
      ),
    );
  }

  static onError(
    context,
    void func,
  ) {
    func;
    Utils.toast(AppLocalizations.of(context)!.internalServerError);
  }

  static cardGaps() {
    return 20.0.giveHeight;
  }

  static cardToTextGaps() {
    return 10.0.giveHeight;
  }

  static loadMore(onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppLocalizations.of(activeContext)!.loadMore,
        style: AppTextStyles.loadMoreStyle,
      ),
    );
  }

  static loaderBusy() {
    return const LoaderBusy();
  }

  static bigLoader() {
    return const BigLoader();
  }

  // static blurLoader(int length) {
  //   return Container(
  //       color: AppColors.blurLoaderColor,
  //       width: 100.0.wp,
  //       height: length < 1 ? 30.0.hp : 100.0.hp,
  //       child: Center(
  //         child: SizedBox(
  //           height: 30.0.hp,
  //           child: const FittedBox(
  //               child: LoaderWidget(
  //             color: AppColors.transparent,
  //           )),
  //         ),
  //       ));
  // }

  static String sectionText() {
    return (prefs.getString(DataBase.userType))!.toLowerCase() == "retailer"
        ? "Retailer Section"
        : (prefs.getString(DataBase.userType))!.toLowerCase() == "wholesaler"
            ? "Wholesaler Section"
            : "FIE Section";
  }

  static Widget showPopupMenu(context,
      {required String text,
      required Color color,
      required List items,
      Function(int)? onTap,
      bool isPadded = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPadded ? 0 : 0),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          child: PopupMenuButton<int>(
              color: Colors.white,
              splashRadius: 20.0,
              offset: const Offset(0, 40),
              onSelected: (int v) {
                onTap!(v);
              },
              elevation: 8.0,
              tooltip: "",
              itemBuilder: (BuildContext context) {
                return items
                    .asMap()
                    .map((index, e) => MapEntry(
                        index,
                        PopupMenuItem<int>(
                          height: 30,
                          value: index,
                          child: Text(
                            e,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.ashColor,
                                fontWeight: e.toString().toLowerCase() ==
                                            "zones" ||
                                        e.toString().toLowerCase() ==
                                            "routes" ||
                                        e.toString().toLowerCase() == "view all"
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        )))
                    .values
                    .toList();
              },
              child: Card(
                color: color,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  child: Row(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.whiteColor),
                      ),
                      const Icon(Icons.keyboard_arrow_down_sharp,
                          color: AppColors.whiteColor)
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  static Widget showPopupMenuWithValue<T>(context,
      {required String text,
      required Color color,
      required List items,
      Function(T)? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          child: PopupMenuButton<T>(
            tooltip: text,
            onSelected: (T value) {
              onTap!(value);
            },
            splashRadius: 20.0,
            offset: const Offset(0, 40),
            itemBuilder: (BuildContext context) {
              return items
                  .asMap()
                  .map((index, e) => MapEntry(
                      index,
                      PopupMenuItem<T>(
                        height: 30,
                        value: e['v'],
                        child: Text(
                          e['t'],
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.ashColor),
                        ),
                      )))
                  .values
                  .toList();
            },
            elevation: 8.0,
            child: Card(
              color: color,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.whiteColor)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static getNiceText(String text,
      {TextStyle style = AppTextStyles.dashboardHeadTitleAshConst,
      bool nxtln = false,
      double padding = 0.0}) {
    List<String> name = text.split(':');
    String restTest() {
      String sub = "";
      for (int i = 1; i < name.length - 0; i++) {
        sub = sub + name[i];
        if (i < name.length - 1) sub = "$sub:";
      }
      return sub;
    }

    return text.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: RichText(
              text: TextSpan(
                text: name[0] == "" ? "" : "${name[0]}:",
                style: style,
                children: <TextSpan>[
                  if (nxtln)
                    const TextSpan(
                      text: "\n",
                    ),
                  TextSpan(
                    text: restTest() == "" ? "" : restTest(),
                    style: style.copyWith(fontWeight: AppFontWeighs.regular),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  static NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );
  static stringTo2Decimal(dynamic value) {
    return formatter
        .format(double.parse((value ?? "00").toString().replaceAll(",", "")));
  }

  static commonText(String text,
      {TextStyle style = AppTextStyles.statusCardTitle,
      bool needPadding = true}) {
    return Padding(
      padding: needPadding ? AppPaddings.commonTextPadding : AppPaddings.zero,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  static Widget validationText(String text) {
    return Text(
      text,
      style: AppTextStyles.errorTextStyle,
    );
  }
  // static Widget validationText(String text) {
  //   return Text(
  //     text,
  //     style: AppTextStyles.errorTextStyle,
  //   );
  // }

  // static endOfData() {
  //   return Padding(
  //     padding: AppPaddings.endOfDataPadding,
  //     child: Row(
  //       children: [
  //         const Expanded(
  //           child: Divider(
  //                           color: AppColors.dividerColor,
  //             color: AppColors.ashColor,
  //             indent: 20.0,
  //             endIndent: 10.0,
  //             thickness: .3,
  //           ),
  //         ),
  //         Text(
  //           AppLocalizations.of(activeContext)!.endOfPage,
  //           style: AppTextStyles.statusCardSubTitle,
  //         ),
  //         const Expanded(
  //           child: Divider(
  //                           color: AppColors.dividerColor,
  //             color: AppColors.ashColor,
  //             indent: 10.0,
  //             endIndent: 20.0,
  //             thickness: .3,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static connectionWidget() {
  //   return Container(
  //     margin: AppMargins.connectionWidgetMargin,
  //     alignment: Alignment.centerLeft,
  //     height: 70.0,
  //     width: double.infinity,
  //     padding: AppPaddings.connectionWidgetPadding,
  //     decoration: BoxDecoration(
  //         borderRadius: AppRadius.connectionWidgetRadius,
  //         color: AppColors.messageColorError),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 30.0,
  //           width: 30.0,
  //           alignment: Alignment.center,
  //           child: Icon(
  //             Icons.wifi_off,
  //             color: Colors.red,
  //             size: AppIconSizes.s28,
  //           ),
  //         ),
  //         const SizedBox(width: 15),
  //         Text(
  //           AppLocalizations.of(activeContext)!.noInternet,
  //           style: AppTextStyles.errorTextStyle
  //               .copyWith(fontWeight: AppFontWeighs.bold),
  //         )
  //       ],
  //     ),
  //   );
  // }

  static noDataWidget(BuildContext context, {double? height, String? name}) {
    return SizedBox(
      height: height ?? 60.0.hp,
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.noDataInTable(name ?? ""),
          style: AppTextStyles.dashboardHeadTitleAsh,
        ),
      ),
    );
  }

  // static noDataWidgetTable(BuildContext context) {
  //   return noDataWidget(context, height: 200);
  // }

  static String contractAccount(String v) {
    List<String> data = v.split("(");
    if (data.length == 1) {
      return data[0];
    } else if (data.length == 3) {
      return "${data[0]} (${data[1]} (${data[2].lastChars(10)}";
    } else if (data.length == 2) {
      return "${data[0]} }";
    } else {
      return "${data[0]} (${data[1].lastChars(10)}";
    }
  }

  static errorShow(String text) {
    if (text.isNotEmpty) {
      return Text(
        text,
        style: AppTextStyles.errorTextStyle,
      );
    } else {
      return const SizedBox();
    }
  }

  static Border tableBorder = const Border(
    bottom: BorderSide(width: 1.5, color: AppColors.tableHeaderBody),
  );
  static Border tableBorder2 = const Border(
    bottom: BorderSide(width: 1.5, color: AppColors.whiteColor),
  );
  static bool hasSSL() {
    String url = ConstantEnvironment.baseUrl.toString().split(":").first;
    return url == "http" ? false : true;
  }

  static void fPrint(dynamic x) {
    if (kDebugMode) {
      print(x.toString());
    }
  }
}
