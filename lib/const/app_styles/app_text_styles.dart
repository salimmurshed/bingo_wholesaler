import 'package:flutter/foundation.dart';

import '../web_devices.dart';
import '/const/app_font_manager.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

//DashBoard
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.medium,
    fontSize: AppFontSize.s19,
    color: AppColors.whiteColor,
  );
  static const TextStyle alertBlueTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s16,
    color: AppColors.accentColor,
  );
  static const TextStyle loadMoreStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s12,
    color: AppColors.accentColor,
  );

  static const TextStyle dashboardHeadTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s16,
    color: AppColors.ashColor,
    height: 1.5,
  );

  static const TextStyle dashboardHeadBoldTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s16,
    color: AppColors.ashColor,
    height: 1.5,
  );

  static const TextStyle headerText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s16,
    color: AppColors.blackColor,
    height: 1.5,
  );

  static const TextStyle cartAmountText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.medium,
    fontSize: AppFontSize.s26,
    color: AppColors.whiteColor,
  );

  static const TextStyle dashboardBodyTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s10,
    color: AppColors.blackColor,
    height: 1.5,
  );

  static TextStyle dashboardHeadTitleAsh = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: kIsWeb && device == ScreenSize.small
        ? AppFontWeighs.medium
        : AppFontWeighs.light,
    fontSize: AppFontSize.s12,
    color: AppColors.ashColor,
    height: 1.5,
  );

  static const TextStyle dashboardHeadTitleAshConst = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s12,
    color: AppColors.ashColor,
    height: 1.5,
  );

  static const TextStyle cartTitleText = TextStyle(
    height: 0.9,
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s13,
    color: AppColors.whiteColor,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s32,
    color: AppColors.blackColor,
  );

//button text
  static const TextStyle buttonText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s10,
    color: AppColors.blackColor,
  );

  //StatusCard
  static const TextStyle statusCardTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s16,
    color: AppColors.blackColor,
  );
  static const TextStyle priceTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    color: AppColors.blackColor,
  );
  static const TextStyle statusCardSubTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s10,
    color: AppColors.ashColor,
  );
  static const TextStyle statusCardStatus = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s10,
    color: AppColors.statusVerified,
  );

  static const TextStyle bottomTexts = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s12,
    color: AppColors.ashColor,
  );

  static TextStyle loginTitleStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: kIsWeb && device == ScreenSize.small
        ? AppFontWeighs.medium
        : AppFontWeighs.light,
    fontSize: AppFontSize.s13,
    color: AppColors.activeButtonColor,
  );

  static const TextStyle testForAll = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s13,
    color: AppColors.activeButtonColor,
  );

  static const TextStyle saleAvailabilityStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s16,
    color: AppColors.darkGreenColor,
  );

//add request screen
  static const TextStyle addRequestTabBar = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s12,
    color: AppColors.whiteColor,
  );

  static const TextStyle retailerStoreCard = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s12,
    color: AppColors.blackColor,
  );
  static const TextStyle addRequestHeader = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s16,
    color: AppColors.blackColor,
  );

  static const TextStyle addRequestSubTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s10,
    color: AppColors.ashColor,
  );

  static const TextStyle requestDetailsSubTitle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s16,
    color: AppColors.ashColor,
  );

  static const TextStyle noDataTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.light,
    fontSize: AppFontSize.s16,
    color: AppColors.ashColor,
  );

  static const TextStyle successStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    color: AppColors.blackColor,
  );

//drawer
  static const TextStyle drawerText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s19,
    color: AppColors.blackColor,
  );
  static const TextStyle errorTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    color: AppColors.redColor,
  );

  //sales
  static const TextStyle addSaleGreenBoxText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    color: AppColors.whiteColor,
  );
  static const TextStyle addSaleGreenBoxTextBold =
      TextStyle(fontWeight: AppFontWeighs.bold);

  static const TextStyle underlineText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    decoration: TextDecoration.underline,
    color: AppColors.blackColor,
  );

  static const TextStyle salesScannerDialog = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    color: AppColors.blackColor,
  );

  static const TextStyle salesAddedMessageTestStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.medium,
    fontSize: AppFontSize.s12,
    color: AppColors.pasteColor,
  );
  static TextStyle formFieldTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontSize: AppFontSize.dropdownHintTextFontSize,
    color: AppColors.blackColor,
    fontWeight: kIsWeb && device == ScreenSize.small
        ? AppFontWeighs.medium
        : AppFontWeighs.regular,
  );
  static TextStyle formFieldHintTextStyle = const TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontSize: AppFontSize.dropdownHintTextFontSize,
    color: AppColors.hintColor,
  );
  static TextStyle formTitleTextStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,

    fontWeight: kIsWeb && device == ScreenSize.small
        ? AppFontWeighs.medium
        : AppFontWeighs.regular,
    // fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s12,
    color: AppColors.blackColor,
  );
  static TextStyle formTitleTextStyleNormal = AppTextStyles.formTitleTextStyle
      .copyWith(
          color: AppColors.ashColor,
          fontWeight: kIsWeb && device == ScreenSize.small
              ? AppFontWeighs.medium
              : FontWeight.normal);

  static const TextStyle normalCopyText = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.regular,
    fontSize: AppFontSize.s16,
    color: AppColors.blackColor,
  );

  static const TextStyle webTableHeader = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s14,
    color: AppColors.blackColor,
  );

  static TextStyle webTableBody = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: kIsWeb && device == ScreenSize.small
        ? AppFontWeighs.medium
        : AppFontWeighs.light,
    fontSize: AppFontSize.s14,
    color: AppColors.blackColor,
  );

  static const TextStyle webBtnTxtStyle = TextStyle(
    fontFamily: AppFont.mainTextFontFamily,
    fontWeight: AppFontWeighs.semiBold,
    fontSize: AppFontSize.s12,
    color: AppColors.whiteColor,
  );
}
