part of 'app_sizes.dart';

class AppMargins {
  AppMargins._();

  ///end with "H" [horizontal]
  ///end with "V" [vertical]
  ///end with "T" [top]
  ///end with "B" [bottom]
  ///end with "L" [left]
  ///end with "R" [right]

  /// [AccountBalanceCard]
  static EdgeInsets accountBalanceCardMargin = const EdgeInsets.symmetric(
    vertical: 12.0,
  );

  /// [StatusCard]
  static EdgeInsets statusCardMargin =
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2);
  static EdgeInsets statusCardMargin1 = const EdgeInsets.all(
    28.0,
  );

  /// [RetailerConfirmationCardInDashboard]
  static EdgeInsets retailerConfirmationMarginV = const EdgeInsets.symmetric(
    vertical: 10.0,
  );

  // /// [RetailerDashboardRequestSettingTabPart] & [RetailerRecommandationCardInDashboard]
  // static EdgeInsets retailerDashboardRequestMarginV =
  //     const EdgeInsets.symmetric(
  //   vertical: 12.0,
  // );

  /// [WholesalerDashboardRequestTabPart]
  static EdgeInsets wholesalerDashboardRequestTabMarginH =
      const EdgeInsets.symmetric(
    horizontal: 12.0,
  );

  /// [WholesalerInvoicePartInDashboard] & [WholesalerNewOrderPartInDashboard]
  static EdgeInsets wholesalerInDashboardMarginB = const EdgeInsets.only(
    bottom: 10.0,
  );

  /// [AssociationRequestDetailsScreen]
  static EdgeInsets screenARDSWidgetMarginH = const EdgeInsets.symmetric(
    horizontal: 10.0,
  );

  /// [SalesDetailsScreenView]
  static EdgeInsets salesDetailsMainCardMargin = const EdgeInsets.all(
    25.0,
  );

  static EdgeInsets smallBoxPadding = const EdgeInsets.all(
    10.0,
  );

  /// [connectionWidget]
  static EdgeInsets connectionWidgetMargin = const EdgeInsets.all(10.0);

  /// [AccountBalance]
  static EdgeInsets accountBalanceMarginB = EdgeInsets.only(bottom: 10.0.hp);

  ///[DashBoard]
  static EdgeInsets dashboardCalenderMarginV = const EdgeInsets.symmetric(
    vertical: 25.0,
  );

  ///[AddStoreView]
  static EdgeInsets addStoreBody = const EdgeInsets.all(27.0);
  static EdgeInsets cardBody = const EdgeInsets.all(25.0);
}
