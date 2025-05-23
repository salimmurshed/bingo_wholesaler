part of 'app_sizes.dart';

class AppPaddings {
  AppPaddings._();

  //end with "H" horizontal
  //end with "V" vertical
  //end with "T" top
  //end with "B" bottom
  //end with "L" left
  //end with "R" right

  /// [SelectedDropdownField] & [AddAssociationRequestScreenView]
  static EdgeInsets zero = EdgeInsets.zero;

  /// [CancelButton] & [SubmitButton]
  static EdgeInsets buttonWidgetPadding =
      const EdgeInsets.symmetric(horizontal: 8.0);

  static EdgeInsets dashboardTilesCardAmountPadding =
      const EdgeInsets.symmetric(vertical: 8.0);

  /// [RetailerConfirmationCardInDashboard]
  static EdgeInsets retailerConfirmationPadding = const EdgeInsets.symmetric(
    horizontal: 19.0,
    vertical: 15.0,
  );

  /// [WholesalerInvoicePartInDashboard] & [WholesalerNewOrderPartInDashboard]
  static EdgeInsets wholesalerInDashboardPadding = const EdgeInsets.all(
    15.0,
  );

  /// [AddAssociationRequestScreenView]
  static EdgeInsets associationRequestTabBarWidgetV =
      const EdgeInsets.symmetric(
    vertical: 20.0,
  );

  static EdgeInsets bodyHorizontal23 =
      const EdgeInsets.symmetric(horizontal: 23.0);

  static EdgeInsets associationRequestTabBarViewListCard =
      const EdgeInsets.symmetric(
    horizontal: 23.0,
    vertical: 12.0,
  );

  ///[AssociationRequestDetailsScreen]
  static EdgeInsets screenARDSWidgetInnerPadding = const EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical: 13.0,
  );

  ///[DashboardScreenView]
  static EdgeInsets bottomTabBarH = const EdgeInsets.symmetric(
    horizontal: 10.0,
  );

  ///[LoginScreenView]
  static EdgeInsets loginScreenMainCard =
      const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0);

  ///[LoginScreenView]
  static EdgeInsets loginScreenInnerCard = const EdgeInsets.symmetric(
    horizontal: 38.0,
    vertical: 20.0,
  );

  ///[SalesDetailsScreenView]
  static EdgeInsets salesDetailsDeviderPadding = const EdgeInsets.only(
    top: 20.0,
    bottom: 22.0,
  );

  ///[connectionWidget]
  static EdgeInsets connectionWidgetPadding =
      const EdgeInsets.symmetric(horizontal: 15.0);

  ///[DashBoard]
  static EdgeInsets dashboardOtherCardPadding = const EdgeInsets.all(12.0);

  ///[DashBoard]
  static EdgeInsets dashboardCalenderPaddingH = const EdgeInsets.symmetric(
    horizontal: 21.0,
  );

  static EdgeInsets topPadding = const EdgeInsets.only(top: 10.0);

  ///[Requests] & [Settings]
  static EdgeInsets requestSettingTabViewPadding =
      const EdgeInsets.only(top: 72);

  ///[MyDrawer]
  static EdgeInsets drawerCloseIconPaddingTR =
      const EdgeInsets.only(top: 40.0, right: 30.0);

  static EdgeInsets cardBody = const EdgeInsets.all(25.0);
  static EdgeInsets cardBodyHorizontal =
      const EdgeInsets.symmetric(horizontal: 25.0);
  static EdgeInsets allTabBarPadding =
      const EdgeInsets.symmetric(horizontal: 12.0);
  static EdgeInsets allBottomTabBarPadding =
      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0);
  static EdgeInsets bodyVertical = const EdgeInsets.symmetric(vertical: 20.0);
  static EdgeInsets bodyTop = const EdgeInsets.only(top: 20.0);
  static EdgeInsets commonTextPadding =
      const EdgeInsets.symmetric(horizontal: 18.0);

  static EdgeInsets cardPadding = const EdgeInsets.all(12.0);
  static EdgeInsets cardPaddingChild =
      const EdgeInsets.symmetric(horizontal: 2.0);
  static EdgeInsets classifiedTextBottomPadding =
      const EdgeInsets.only(bottom: 8.0);

  static EdgeInsets borderCardPadding = const EdgeInsets.all(16.0);
  static EdgeInsets webBodyPadding = EdgeInsets.symmetric(
      horizontal: device != ScreenSize.wide ? 12.0 : 32.0, vertical: 8.0);
}

//end with "H" horizontal
//end with "V" vertical
//end with "T" top
//end with "B" bottom
//end with "L" left
//end with "R" right
