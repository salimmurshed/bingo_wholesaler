import '../presentation/ui/statement_sales_details/statement_sales_details_view.dart';
import '/presentation/ui/add_credit_line_screen/add_credit_line_view.dart';
import '/presentation/ui/add_store_screen/add_store_screen_view.dart';
import '/presentation/ui/home_screen/home_screen_view.dart';
import '/presentation/ui/notification/notification_view.dart';
import '/presentation/ui/routes_map/routes_map.dart';
import '/presentation/ui/splash_screen/splash_screen_view.dart';
import '/presentation/ui/view_credit_line_request_wholesaler/view_credit_line_request_wholesaler_view.dart';
import 'package:flutter/material.dart';

import '../presentation/ui/add_association_request_screen/add_association_request_screen_view.dart';
import '../presentation/ui/add_edit_users/add_edit_users_view.dart';
import '../presentation/ui/add_manage_account/add_manage_account_view.dart';
import '../presentation/ui/add_wholesaler_screen/add_wholesaler_view.dart';
import '../presentation/ui/association_request_details_screen/association_request_details_screen_view.dart';
import '../presentation/ui/bottom_tabs/bottom_tabs_screen_view.dart';
import '../presentation/ui/create_order/create_order_view.dart';
import '../presentation/ui/customer_creditline_details/customer_creditline_details_view.dart';
import '../presentation/ui/customer_details/customer_details_view.dart';
import '../presentation/ui/customer_location_details/customer_location_details.dart';
import '../presentation/ui/customer_settlement_detail/customer_settlement_detail_view.dart';
import '../presentation/ui/lock_screen/lock_screen_view.dart';
import '../presentation/ui/login_screen/login_screen_view.dart';
import '../presentation/ui/order_details_screen/order_details_screen_view.dart';
import '../presentation/ui/profile_image/profile_image.dart';
import '../presentation/ui/profile_screen/profile_view.dart';
import '../presentation/ui/retailer_creditline_details/retailer_creditline_details_view.dart';
import '../presentation/ui/routes_details/routes_details_view.dart';
import '../presentation/ui/sales_add/sales_add_view.dart';
import '../presentation/ui/sales_details_screen/sales_details_screen_view.dart';
import '../presentation/ui/sales_edit_screen/sales_edit_screen_view.dart';
import '../presentation/ui/settlement_details_screen/settlement_details_screen_view.dart';
import '../presentation/ui/split_creditline/split_creditline_view.dart';
import '../presentation/ui/split_creditline_details/split_creditline_details_view.dart';
import '../presentation/ui/view_manage_account/view_manage_account_view.dart';

abstract class Routes {
  static const startupView = '/';
  static const login = 'login';
  static const homeScreen = 'home_screen';
  static const dashboardScreen = 'bottom_tabs';
  static const addNewAssociationRequest = 'add_new_association_request';

  //all sales
  static const salesDetailsScreen = 'sales_details_screen';
  static const associationRequestDetailsScreen = 'association_request_details';
  static const addStoreView = 'add_store_view';
  static const addManageAccountView = 'add_manage_account_view';
  static const viewManageAccountView = 'view_manage_account_view';
  static const addCreditLineView = 'add_credit_line_view';
  static const addWholesalerView = 'add_wholesaler_view';
  static const viewCreditLineRequestWholesalerView = 'view_credit_line_request'
      '_wholesaler_view';
  static const addSales = 'sales_add';
  static const editSalesScreenView = 'edit_sales_screen_view';
  static const customerDetailsView = 'customer_details_view';
  static const customerCreditlineDetailsView = 'customer_creditline_details_vi'
      'ew';
  static const customerLocationDetails = 'customer_location_details';
  static const customerSettlementDetails = 'customer_settlement_details';
  static const profile = 'profile';
  static const pickImage = 'pick_image';
  static const settlementDetailsScreenView = 'settlement_details_screen';
  static const retailerCreditlineListView = 'retailer_creditline_list_view';
  static const routeDetails = 'route_details';
  static const routesMap = 'routes_map';
  static const createOrder = 'create_order';
  static const orderDetailsScreenView = 'Order_details_screen_view';
  static const notificationView = 'notification_view';
  static const addEditUsersView = 'add_edit_users_view';
  static const splitCreditlineView = 'split_creditline_view';
  static const splitCreditlineDetailsView = 'split_creditline_details_view';
  static const lockScreenView = 'LockScreenView';
  static const statementSalesDetails = 'StatementSalesDetails';

  static const all = {
    startupView,
    login,
    homeScreen,
    dashboardScreen,
    addNewAssociationRequest,
    salesDetailsScreen,
    associationRequestDetailsScreen,
    addStoreView,
    addManageAccountView,
    viewManageAccountView,
    addCreditLineView,
    addWholesalerView,
    viewCreditLineRequestWholesalerView,
    addSales,
    editSalesScreenView,
    customerDetailsView,
    customerCreditlineDetailsView,
    customerLocationDetails,
    customerSettlementDetails,
    profile,
    pickImage,
    settlementDetailsScreenView,
    retailerCreditlineListView,
    routeDetails,
    routesMap,
    createOrder,
    orderDetailsScreenView,
    notificationView,
    addEditUsersView,
    splitCreditlineView,
    splitCreditlineDetailsView,
    lockScreenView,
    statementSalesDetails,
  };
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SplashScreenView(),
          settings: settings,
        );
      case Routes.login:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const LoginScreenView(),
          settings: settings,
        );

      case Routes.homeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HomeScreenView(),
          settings: settings,
        );

      case Routes.dashboardScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BottomTabsScreenView(),
          settings: settings,
        );

      case Routes.addNewAssociationRequest:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddAssociationRequestView(),
          settings: settings,
        );

      case Routes.associationRequestDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AssociationRequestDetailsScreen(),
          settings: settings,
        );

      case Routes.salesDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SalesDetailsScreenView(),
          settings: settings,
        );

      case Routes.addStoreView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddStoreView(),
          settings: settings,
        );

      case Routes.addManageAccountView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddManageAccountView(),
          settings: settings,
        );
      case Routes.viewManageAccountView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ViewManageAccountView(),
          settings: settings,
        );

      case Routes.addCreditLineView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddCreditLineView(),
          settings: settings,
        );

      case Routes.addWholesalerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddWholesalerView(),
          settings: settings,
        );

      case Routes.viewCreditLineRequestWholesalerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ViewCreditLineRequestWholesalerView(),
          settings: settings,
        );

      case Routes.addSales:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddSalesView(),
          settings: settings,
        );

      case Routes.editSalesScreenView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const EditSalesScreenView(),
          settings: settings,
        );

      case Routes.customerDetailsView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CustomerDetailsView(),
          settings: settings,
        );

      case Routes.customerCreditlineDetailsView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CustomerCreditlineDetailsView(),
          settings: settings,
        );

      case Routes.customerLocationDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const CustomerLocationDetails(),
          settings: settings,
        );

      case Routes.customerSettlementDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CustomerSettlementDetailsView(),
          settings: settings,
        );

      case Routes.profile:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const ProfileView(),
          settings: settings,
        );

      case Routes.pickImage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const PickImage(),
          settings: settings,
        );

      case Routes.settlementDetailsScreenView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SettlementDetailsScreenView(),
          settings: settings,
        );

      case Routes.retailerCreditlineListView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RetailerCreditlineListView(),
          settings: settings,
        );

      case Routes.routeDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RouteDetails(),
          settings: settings,
        );

      case Routes.routesMap:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RoutesMap(),
          settings: settings,
        );

      case Routes.createOrder:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const CreateOrderView(),
          settings: settings,
        );

      case Routes.orderDetailsScreenView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const OrderDetailsScreenView(),
          settings: settings,
        );
      //
      case Routes.notificationView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const NotificationView(),
          settings: settings,
        );
      case Routes.addEditUsersView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const AddEditUsersView(),
          settings: settings,
        );
      case Routes.splitCreditlineView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplitCreditlineView(),
          settings: settings,
        );
      case Routes.splitCreditlineDetailsView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplitCreditlineDetailsView(),
          settings: settings,
        );
      case Routes.lockScreenView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LockScreenView(),
          settings: settings,
        );
      case Routes.statementSalesDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const StatementSalesDetails(),
          settings: settings,
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("${settings.name} route does not exist"),
            ),
          ),
        );
    }
  }
}
