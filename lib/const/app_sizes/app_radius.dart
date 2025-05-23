part of 'app_sizes.dart';

class AppRadius {
  AppRadius._();

  //end with "H" horizontal
  //end with "V" vertical
  //end with "T" top
  //end with "B" bottom
  //end with "L" left
  //end with "R" right

  /// [tabBarShadowDecoration]
  static BorderRadius tabBarShadowDecorationRadius =
      BorderRadius.circular(50.0);

  /// [shadowBox]
  static BorderRadius shadowBoxRadius = BorderRadius.circular(10.0);

  /// [dashboardCardDecoration]
  static BorderRadius dashboardCardDecorationRadius =
      BorderRadius.circular(10.0);

  /// [loginScreenCardDecoration]
  static BorderRadius loginScreenCardDecorationRadius =
      BorderRadius.circular(20.0);

  /// [AppBoxDecoration]
  static BorderRadius borderDecorationRadius = BorderRadius.circular(5.0);

  /// [SubmitButton] & [CancelButton]
  static BorderRadius buttonWidgetRadius = BorderRadius.circular(25.0);
  static BorderRadius buttonWidgetRadiusZero = BorderRadius.circular(5.0);

  /// [AccountBalanceCard]
  static BorderRadius accountBalanceCardRadius = BorderRadius.circular(6.0);

  /// [DashboardTilesCard]
  static BorderRadius dashboardTilesCardRadius = BorderRadius.circular(15.0);

  /// [StatusCard]
  static BorderRadius statusCardMaterialRadius = BorderRadius.circular(12.0);

  /// [RetailerConfirmationCardInDashboard]
  static BorderRadius retailerConfirmationRadius = BorderRadius.circular(10.0);

  /// [WholesalerInvoicePartInDashboard] & [WholesalerNewOrderPartInDashboard]
  static BorderRadius wholesalerInDashboardRadius = BorderRadius.circular(10.0);

  /// [AddAssociationRequestScreenView]
  static BorderRadius associationReqtabL = const BorderRadius.only(
    bottomLeft: Radius.circular(50.0),
    topLeft: Radius.circular(50.0),
  );

  /// [AddAssociationRequestScreenView]
  static BorderRadius associationReqtabR = const BorderRadius.only(
    bottomRight: Radius.circular(50.0),
    topRight: Radius.circular(50.0),
  );

  /// [SalesDetailsScreenView ]
  static BorderRadius salesDetailsRadius = BorderRadius.circular(10.0);

  /// [RetailerRecommandationCardInDashboard]
  static BorderRadius retailerRecommandationCardRadius =
      BorderRadius.circular(10.0);

  /// [main]
  static BorderRadius mainCardThemeRadius = BorderRadius.circular(15.0);

  /// [main]
  static BorderRadius mainDialogThemeRadius = BorderRadius.circular(16.0);

  /// [connectionWidget]
  static BorderRadius connectionWidgetRadius = BorderRadius.circular(10.0);

  /// [displayBottomSheet]
  static BorderRadius displayBottomSheetRadius = const BorderRadius.only(
      topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0));

  /// [displayBottomSheet]
  static BorderRadius s50Padding = BorderRadius.circular(50.0);
}
