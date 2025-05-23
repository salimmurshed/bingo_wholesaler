import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/web/product_pricing/add_edit_promo_code/add_edit_promo_code_view.dart';
import 'package:bingo/presentation/web/retailers_wholesaler/retailer_parts/retailer_settlements/retailer_settlements_view.dart';
import 'package:bingo/presentation/web/settings/store/add_store/add_store_view.dart';
import 'package:bingo/presentation/web/settings/store/store_list/store_list_view.dart';
import 'package:bingo/presentation/web/settings/user/add_user/add_user_view.dart';
import 'package:bingo/presentation/web/settings/user/user_list/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../presentation/ui/login_screen/login_screen_view.dart';
import '../presentation/web/creditline/retailers_details/retailers_creditline_view.dart';
import '../presentation/web/creditline/retailers_list/creditline_view.dart';
import '../presentation/web/dash_board/dash_board_view.dart';
import '../presentation/web/edit_profile/edit_profile_view.dart';
import '../presentation/web/financial_statement/fie_financial_statements/fie_financial_statements_view.dart';
import '../presentation/web/financial_statement/fie_financial_statements_sale_list/fie_financial_statements_sale_list_view.dart';
import '../presentation/web/financial_statement/retailer_financial_statements/financial_statements_view.dart';
import '../presentation/web/financial_statement/retailer_financial_statements_sale_list/financial_statements_sale_list_view.dart';
import '../presentation/web/location_details/location_details_view.dart';
import '../presentation/web/order/order_list/order_list_view.dart';
import '../presentation/web/order/view/retailer/order_details_view.dart';
import '../presentation/web/product_pricing/product_details/product_details_view.dart';
import '../presentation/web/product_pricing/promo_code/promo_code_view.dart';
import '../presentation/web/product_pricing/summury/summury_view.dart';
import '../presentation/web/requests/add_new_creditline/add_new_creditline_view.dart';
import '../presentation/web/requests/add_request/add_request_view.dart';
import '../presentation/web/requests/association_request_details/association_request_details_view.dart';
import '../presentation/web/requests/association_requests/association_requests_view.dart';
import '../presentation/web/requests/credit_line_request/credit_line_request_view.dart';
import '../presentation/web/requests/credit_line_request_details/credit_line_request_details_view.dart';
import '../presentation/web/retailer\'s_fie/details/fie_details_view.dart';
import '../presentation/web/retailer\'s_fie/fie_list_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/internal/internal_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/locations/location_list_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/retailer_credit_line/details/retailer_creditline_details_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/retailer_credit_line/retailer_credit_line_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/retailer_profile/retailer_profile_view.dart';
import '../presentation/web/retailers_wholesaler/retailer_parts/sales/sales_list_view.dart';
import '../presentation/web/retailers_wholesaler/retailers_wholesaler_view.dart';
import '../presentation/web/retailers_wholesaler/wholesaler_details/wholesaler_details_view.dart';
import '../presentation/web/sales_screen/sale_details/sales_details_view.dart';
import '../presentation/web/sales_screen/sale_list/sales_screen_view.dart';
import '../presentation/web/sales_screen/sale_transaction/sale_transaction_view.dart';
import '../presentation/web/sales_screen/sales_add/sales_add_view.dart';
import '../presentation/web/settings/business/business.dart';
import '../presentation/web/settings/business/customer_types/add_edit/customer_type_add_edit_view.dart';
import '../presentation/web/settings/business/customer_types/list/customer_types_view.dart';
import '../presentation/web/settings/business/grace_periods_groups/add_edit/grace_period_add_edit_view.dart';
import '../presentation/web/settings/business/grace_periods_groups/list/grace_periods_groups_view.dart';
import '../presentation/web/settings/business/pricng_group/add_edit/pricing_group_add_edit_view.dart';
import '../presentation/web/settings/business/pricng_group/list/pricng_group_view.dart';
import '../presentation/web/settings/company_profile/company_profile_view.dart';
import '../presentation/web/settings/delivery_method/add_edit/delivery_method_add_edit_view.dart';
import '../presentation/web/settings/delivery_method/list/delivery_method_list_view.dart';
import '../presentation/web/settings/finance/finance_view.dart';
import '../presentation/web/settings/logistics/logistics.dart';
import '../presentation/web/settings/logistics/sales_zones/add_edit/sales_zones_add_edit_view.dart';
import '../presentation/web/settings/logistics/sales_zones/list/sales_zones_list_view.dart';
import '../presentation/web/settings/manage_account/edit/manage_account_edit_view.dart';
import '../presentation/web/settings/manage_account/list/manage_account_list_view.dart';
import '../presentation/web/settings/payment_method/add_edit/payment_add_edit_view.dart';
import '../presentation/web/settings/payment_method/list/payment_method_view.dart';
import '../presentation/web/settings/roles/role_description/role_description_view.dart';
import '../presentation/web/settings/roles/role_list/roles_view.dart';
import '../presentation/web/settlements/payment_lot_details/payment_lot_details_view.dart';
import '../presentation/web/settlements/settlement_screen/settlement_screen_view.dart';
import '../presentation/web/zone_route/dynamic_route/dynamic_route_list/dynamic_route_list_view.dart';
import '../services/storage/db.dart';
import '../services/storage/device_storage.dart';
import 'locator.dart';

abstract class Routes {
  static const dashboard = '/';
  static const login = 'login';
  static const dashboardScreen = 'dashboard';
  static const saleScreen = 'sales';
  static const financialStatementView = 'statements';
  static const financialStatementSaleListViewWeb = 'sale-statements';
  static const fieFinancialStatementView = 'fie-statements';
  static const fieStatementSaleListViewWeb = 'fie-sale-statements';
  static const retailerSettlement = 'settlements';
  static const retailerAccounting = 'accounting';
  static const paymentLotDetailsView = 'payment_lot_details_view';
  static const paymentLotDetailsViewfromretailer = 'payment_lot_details';
  static const saleDetails = 'sale_details';
  static const saleTransaction = 'sale_transaction';
  static const addSales = 'add_sales';
  static const userList = 'user-list';
  static const storeList = 'store-list';
  static const addUser = 'add_user';
  static const editUser = 'edit_user';
  static const addStore = 'add_store';
  static const editStore = 'edit_store';
  static const editProfile = 'edit_profile';
  static const creditlineView = 'creditline';
  static const promoCodeView = 'promo_code';
  static const productSummary = 'product_summary';
  static const productDetailsView = 'product_details_view';
  static const addPromoCodeView = 'add_promo_code_view';
  static const editPromoCodeView = 'edit_promo_code_view';
  static const wholesalerRequest = 'wholesaler_request';
  static const retailerRequest = 'retailer_request';
  static const fieRequest = 'fie_request';
  static const creditLineRequestWebView = 'credit_line_request_web_view';
  static const creditLineRequestDetailsView = 'credit_line_request_details';
  static const addNewCreditlineView = 'add_new_creditline_view';
  static const addRequestView = 'add_request';
  static const associationRequestDetailsView =
      'association_request_details_view';
  static const retailer = 'retailers';
  static const wholesaler = 'wholesalers';
  static const retailerCreditLineView = 'retailer_creditline';
  static const retailerCreditlineDetailsView = 'retailer_creditline_details';
  static const retailerInternalView = 'retailer_internal';
  static const retailerProfile = 'retailer_profile';
  static const retailerLocation = 'retailer_location';
  static const locationDetailsView = 'location_details_view';
  static const retailerSettlements = 'retailer_settlements';
  static const retailerSales = 'retailer_sales';
  static const retailerOrders = 'retailer_orders';
  static const retailersCreditlineView = 'retailers_creditline';
  static const wholesalerDetailsView = 'wholesaler_details';
  static const fieListView = 'fie_list';
  static const fieDetailsView = 'fie_details';
  static const rolesView = 'roles';
  static const roleDescription = 'role_description';
  static const manageAccountView = 'manage_account';
  static const manageAccountAddEditView = 'manage_account_add_edit';
  static const paymentMethodView = 'payment_method';
  static const paymentMethodAddView = 'payment_method_add';
  static const paymentMethodEditView = 'payment_method_edit';
  static const deliveryMethodView = 'delivery_method';
  static const deliveryMethodAddView = 'delivery_method_add';
  static const deliveryMethodEditView = 'delivery_method_edit';

  static const business = 'business';
  static const finance = 'finance';
  static const logistics = 'logistics';
  static const customerTypesView = 'customer_types';
  static const gracePeriodsGroupsView = 'grace_periods_groups';
  static const addCustomerTypeView = 'add_customer_types';
  static const editCustomerTypeView = 'edit_customer_types';
  static const gracePeriodAddView = 'add_grace_period';
  static const gracePeriodEditView = 'edit_grace_period';
  static const pricingGroupAddView = 'add_pricing_group';
  static const pricingGroupEditView = 'edit_pricing_group';
  static const pricingGroupView = 'pricing_group';
  static const companyProfileView = 'company_profile';
  static const salesZoneListView = 'sales_zone_list';
  static const orderListView = 'order_list';
  static const orderDetailsView = 'order_details';
  static const orderAddView = 'add_order';
  static const salesZoneAddView = 'sales_zone_add';
  static const salesZoneEditView = 'sales_zone_edit';
  static const zoneRouteDynamic = 'dynamic';
  static const zoneRouteStatic = 'static';
  static const zoneRouteZone = 'zone';
  static const zoneRouteOption = 'option';
  //no class made yet
  // static const zoneRouteOption = 'option';
  // static const manageAccountAddView = 'manage_account_add';
  static const elses = 'elses';

  static const all = {
    dashboard,
    login,
    dashboardScreen,
    saleScreen,
    financialStatementView,
    financialStatementSaleListViewWeb,
    fieFinancialStatementView,
    fieStatementSaleListViewWeb,
    retailerSettlement,
    retailerAccounting,
    paymentLotDetailsView,
    paymentLotDetailsViewfromretailer,
    saleDetails,
    saleTransaction,
    addSales,
    userList,
    storeList,
    addUser,
    editUser,
    addStore,
    editStore,
    editProfile,
    creditlineView,
    promoCodeView,
    productSummary,
    productDetailsView,
    addPromoCodeView,
    editPromoCodeView,
    wholesalerRequest,
    retailerRequest,
    fieRequest,
    creditLineRequestWebView,
    creditLineRequestDetailsView,
    addNewCreditlineView,
    associationRequestDetailsView,
    retailer,
    wholesaler,
    retailerCreditLineView,
    retailerCreditlineDetailsView,
    retailerInternalView,
    retailerProfile,
    retailerSettlements,
    retailersCreditlineView,
    retailerLocation,
    locationDetailsView,
    retailerSales,
    retailerOrders,
    wholesalerDetailsView,
    fieListView,
    fieDetailsView,
    rolesView,
    roleDescription,
    manageAccountView,
    manageAccountAddEditView,
    paymentMethodView,
    paymentMethodAddView,
    paymentMethodEditView,
    deliveryMethodView,
    deliveryMethodAddView,
    deliveryMethodEditView,
    business,
    finance,
    logistics,
    customerTypesView,
    addCustomerTypeView,
    editCustomerTypeView,
    gracePeriodsGroupsView,
    gracePeriodAddView,
    gracePeriodEditView,
    pricingGroupView,
    pricingGroupAddView,
    pricingGroupEditView,
    companyProfileView,
    salesZoneListView,
    orderListView,
    orderDetailsView,
    orderAddView,
    salesZoneAddView,
    salesZoneEditView,
    zoneRouteDynamic,
    zoneRouteStatic,
    zoneRouteZone,
    zoneRouteOption,
    elses,
  };
}

final GoRouter router = GoRouter(
    errorBuilder: (context, state) => Scaffold(
          body: SizedBox(
            width: 100.0.wp,
            height: 100.0.hp,
            child: Image.asset(
              AppAsset.error404,
              fit: BoxFit.fill,
            ),
          ),
        ),
    navigatorKey: navKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreenView();
        },
      ),
      GoRoute(
        path: Routes.dashboard,
        name: Routes.dashboard,
        builder: (BuildContext context, GoRouterState state) {
          return const DashBoardViewWeb();
        },
        // routes: []
        routes: <RouteBase>[
          GoRoute(
            path: 'dashboard',
            name: 'dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const DashBoardViewWeb();
            },
          ),
          GoRoute(
            path: "${Routes.roleDescription}/:d",
            name: Routes.roleDescription,
            builder: (BuildContext context, GoRouterState state) {
              return RoleDescription(des: state.pathParameters['d']);
            },
          ),
          GoRoute(
            path: Routes.companyProfileView,
            name: Routes.companyProfileView,
            builder: (BuildContext context, GoRouterState state) {
              return const CompanyProfileView();
            },
          ),
          GoRoute(
            path: Routes.rolesView,
            name: Routes.rolesView,
            builder: (BuildContext context, GoRouterState state) {
              return const RolesView();
            },
          ),
          GoRoute(
            path: Routes.business,
            name: Routes.business,
            builder: (BuildContext context, GoRouterState state) {
              return Business();
            },
          ),
          GoRoute(
            path: Routes.finance,
            name: Routes.finance,
            builder: (BuildContext context, GoRouterState state) {
              return Finance();
            },
          ),
          GoRoute(
            path: Routes.logistics,
            name: Routes.logistics,
            builder: (BuildContext context, GoRouterState state) {
              return Logistics();
            },
          ),
          GoRoute(
            path: Routes.customerTypesView,
            name: Routes.customerTypesView,
            builder: (BuildContext context, GoRouterState state) {
              return const CustomerTypesView();
            },
          ),
          GoRoute(
            path: "${Routes.salesZoneListView}/:page",
            name: Routes.salesZoneListView,
            builder: (BuildContext context, GoRouterState state) {
              return SalesZoneListView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: "${Routes.orderListView}/:page",
            name: Routes.orderListView,
            builder: (BuildContext context, GoRouterState state) {
              return OrderListView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            ///:type/:w/:s/:u/:ot
            path: "${Routes.orderDetailsView}",
            name: Routes.orderDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return OrderDetailsView(
                  type: state.uri.queryParameters['type'],
                  w: state.uri.queryParameters['w'],
                  s: state.uri.queryParameters['s'],
                  u: state.uri.queryParameters['u'],
                  ot: state.uri.queryParameters['ot'],
                  id: state.uri.queryParameters['id']);
            },
          ),
          GoRoute(
            path: Routes.orderAddView,
            name: Routes.orderAddView,
            builder: (BuildContext context, GoRouterState state) {
              return const OrderDetailsView();
            },
          ),
          GoRoute(
            path: Routes.zoneRouteDynamic,
            name: Routes.zoneRouteDynamic,
            builder: (BuildContext context, GoRouterState state) {
              return DynamicRoutesListView(
                  type: Routes.zoneRouteDynamic,
                  page: state.uri.queryParameters['page'],
                  from: state.uri.queryParameters['from'],
                  to: state.uri.queryParameters['to']);
            },
          ),
          GoRoute(
            path: Routes.zoneRouteStatic,
            name: Routes.zoneRouteStatic,
            builder: (BuildContext context, GoRouterState state) {
              return DynamicRoutesListView(
                  type: Routes.zoneRouteStatic,
                  page: state.uri.queryParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.zoneRouteZone,
            name: Routes.zoneRouteZone,
            builder: (BuildContext context, GoRouterState state) {
              return DynamicRoutesListView(
                  type: Routes.zoneRouteZone,
                  page: state.uri.queryParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.zoneRouteOption,
            name: Routes.zoneRouteOption,
            builder: (BuildContext context, GoRouterState state) {
              return const DynamicRoutesListView(type: Routes.zoneRouteOption);
            },
          ),
          GoRoute(
            path: Routes.gracePeriodsGroupsView,
            name: Routes.gracePeriodsGroupsView,
            builder: (BuildContext context, GoRouterState state) {
              return const GracePeriodsGroupsView();
            },
          ),
          GoRoute(
            path: Routes.addCustomerTypeView,
            name: Routes.addCustomerTypeView,
            builder: (BuildContext context, GoRouterState state) {
              return AddEditCustomerTypeView();
            },
          ),
          GoRoute(
            path: Routes.gracePeriodAddView,
            name: Routes.gracePeriodAddView,
            builder: (BuildContext context, GoRouterState state) {
              return GracePeriodAddEditView();
            },
          ),
          GoRoute(
            path: Routes.pricingGroupAddView,
            name: Routes.pricingGroupAddView,
            builder: (BuildContext context, GoRouterState state) {
              return const AddEditPricingGroupView();
            },
          ),
          GoRoute(
            path: "${Routes.pricingGroupEditView}/:data",
            name: Routes.pricingGroupEditView,
            builder: (BuildContext context, GoRouterState state) {
              return AddEditPricingGroupView(
                  data: state.pathParameters['data']);
            },
          ),
          GoRoute(
            path: Routes.salesZoneAddView,
            name: Routes.salesZoneAddView,
            builder: (BuildContext context, GoRouterState state) {
              return const SalesZoneAddEditView();
            },
          ),
          GoRoute(
            path: "${Routes.salesZoneEditView}/:data",
            name: Routes.salesZoneEditView,
            builder: (BuildContext context, GoRouterState state) {
              return SalesZoneAddEditView(data: state.pathParameters['data']);
            },
          ),
          GoRoute(
            path: "${Routes.gracePeriodEditView}/:data",
            name: Routes.gracePeriodEditView,
            builder: (BuildContext context, GoRouterState state) {
              return GracePeriodAddEditView(data: state.pathParameters['data']);
            },
          ),
          GoRoute(
            path: "${Routes.editCustomerTypeView}/:data",
            name: Routes.editCustomerTypeView,
            builder: (BuildContext context, GoRouterState state) {
              return AddEditCustomerTypeView(
                  data: state.pathParameters['data']);
            },
          ),
          GoRoute(
            path: Routes.pricingGroupView,
            name: Routes.pricingGroupView,
            builder: (BuildContext context, GoRouterState state) {
              return const PricingGroupView();
            },
          ),
          GoRoute(
            path: "${Routes.userList}/:page",
            name: Routes.userList,
            builder: (BuildContext context, GoRouterState state) {
              return UserListView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: "${Routes.retailer}/:page",
            name: Routes.retailer,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerWholeSalerView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: "${Routes.manageAccountView}/:page",
            name: Routes.manageAccountView,
            builder: (BuildContext context, GoRouterState state) {
              return ManageAccountView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.manageAccountAddEditView,
            name: Routes.manageAccountAddEditView,
            builder: (BuildContext context, GoRouterState state) {
              return ManageAccountEditView(id: state.uri.queryParameters['id']);
            },
          ),
          GoRoute(
            path: Routes.paymentMethodView,
            name: Routes.paymentMethodView,
            builder: (BuildContext context, GoRouterState state) {
              return const PaymentMethodView();
            },
          ),

          GoRoute(
            path: Routes.paymentMethodAddView,
            name: Routes.paymentMethodAddView,
            builder: (BuildContext context, GoRouterState state) {
              return const PaymentAddEditView();
            },
          ),
          GoRoute(
            path: Routes.paymentMethodEditView,
            name: Routes.paymentMethodEditView,
            builder: (BuildContext context, GoRouterState state) {
              return PaymentAddEditView(
                  id: state.uri.queryParameters['id'],
                  title: state.uri.queryParameters['title']);
            },
          ),
          GoRoute(
            path: Routes.deliveryMethodView,
            name: Routes.deliveryMethodView,
            builder: (BuildContext context, GoRouterState state) {
              return const DeliveryMethodListView();
            },
          ),
          GoRoute(
            path: Routes.deliveryMethodAddView,
            name: Routes.deliveryMethodAddView,
            builder: (BuildContext context, GoRouterState state) {
              return const DeliveryMethodAddEditView();
            },
          ),
          GoRoute(
            path: Routes.deliveryMethodEditView,
            name: Routes.deliveryMethodEditView,
            builder: (BuildContext context, GoRouterState state) {
              return DeliveryMethodAddEditView(
                  id: state.uri.queryParameters['id']);
            },
          ),

          GoRoute(
            path: "${Routes.wholesaler}/:page",
            name: Routes.wholesaler,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerWholeSalerView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.retailerCreditLineView,
            name: Routes.retailerCreditLineView,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerCreditLineView(
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: Routes.retailerCreditlineDetailsView,
            name: Routes.retailerCreditlineDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerCreditlineDetailsView(
                id: state.uri.queryParameters['id'],
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: Routes.retailerSales,
            name: Routes.retailerSales,
            builder: (BuildContext context, GoRouterState state) {
              return RetailersSalesListView(
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
                page: state.uri.queryParameters['page'],
              );
            },
          ),
          GoRoute(
            path: Routes.addPromoCodeView,
            name: Routes.addPromoCodeView,
            builder: (BuildContext context, GoRouterState state) {
              return const AddEditPromoCodeView();
            },
          ),
          GoRoute(
            path: Routes.fieListView,
            name: Routes.fieListView,
            builder: (BuildContext context, GoRouterState state) {
              return FieListView(page: state.uri.queryParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.fieDetailsView,
            name: Routes.fieDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return FieDetailsView(id: state.uri.queryParameters['id']);
            },
          ),
          GoRoute(
            path: Routes.wholesalerRequest,
            name: Routes.wholesalerRequest,
            builder: (BuildContext context, GoRouterState state) {
              return const AssociationRequestView();
            },
          ),
          GoRoute(
            path: Routes.retailerRequest,
            name: Routes.retailerRequest,
            builder: (BuildContext context, GoRouterState state) {
              return const AssociationRequestView();
            },
          ),
          GoRoute(
            path: Routes.fieRequest,
            name: Routes.fieRequest,
            builder: (BuildContext context, GoRouterState state) {
              return const AssociationRequestView();
            },
          ),
          GoRoute(
            path: Routes.associationRequestDetailsView,
            name: Routes.associationRequestDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return AssociationRequestDetailsView(
                  id: state.uri.queryParameters['q'],
                  uri: state.uri.queryParameters['u']);
            },
          ),
          GoRoute(
            path: Routes.creditLineRequestDetailsView,
            name: Routes.creditLineRequestDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return CreditLineRequestDetailsView(
                id: state.uri.queryParameters['q'],
                data: state.uri.queryParameters['data'],
                enroll: state.uri.queryParameters['enroll'],
              );
            },
          ),
          GoRoute(
            path: "${Routes.creditLineRequestWebView}/:page",
            name: Routes.creditLineRequestWebView,
            builder: (BuildContext context, GoRouterState state) {
              return CreditLineRequestWebView(
                  page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.addNewCreditlineView,
            name: Routes.addNewCreditlineView,
            builder: (BuildContext context, GoRouterState state) {
              return const AddNewCreditlineView();
            },
          ),
          GoRoute(
            path: Routes.addRequestView,
            name: Routes.addRequestView,
            builder: (BuildContext context, GoRouterState state) {
              return AddRequestView(type: state.uri.queryParameters['type']);
            },
          ),
          GoRoute(
            path: Routes.retailerInternalView,
            name: Routes.retailerInternalView,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerInternalView(
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: Routes.retailerProfile,
            name: Routes.retailerProfile,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerProfileView(
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: Routes.retailerLocation,
            name: Routes.retailerLocation,
            builder: (BuildContext context, GoRouterState state) {
              return RetailersLocationListView(
                  ttx: state.uri.queryParameters['ttx'],
                  uid: state.uri.queryParameters['uid']);
            },
          ),
          GoRoute(
            path: Routes.locationDetailsView,
            name: Routes.locationDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return LocationDetailsView(
                  ttx: state.uri.queryParameters['ttx'],
                  uid: state.uri.queryParameters['uid'],
                  sid: state.uri.queryParameters['sid']);
            },
          ),
          GoRoute(
            path: Routes.retailerSettlements,
            name: Routes.retailerSettlements,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerSettlementsView(
                ttx: state.uri.queryParameters['ttx'],
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: Routes.retailersCreditlineView,
            name: Routes.retailersCreditlineView,
            builder: (BuildContext context, GoRouterState state) {
              return RetailersCreditlineView(
                uid: state.uri.queryParameters['uid'],
                type: state.uri.queryParameters['type'],
              );
            },
          ),
          GoRoute(
            path: Routes.wholesalerDetailsView,
            name: Routes.wholesalerDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return WholesalerDetailsView(
                uid: state.uri.queryParameters['uid'],
              );
            },
          ),
          GoRoute(
            path: "${Routes.editPromoCodeView}/:data",
            name: Routes.editPromoCodeView,
            builder: (BuildContext context, GoRouterState state) {
              return AddEditPromoCodeView(data: state.pathParameters['data']);
            },
          ),
          GoRoute(
            path: Routes.storeList,
            name: Routes.storeList,
            builder: (BuildContext context, GoRouterState state) {
              return const StoreListView();
            },
          ),
          GoRoute(
            path: Routes.addSales,
            name: Routes.addSales,
            builder: (BuildContext context, GoRouterState state) {
              return SalesAddView();
            },
          ),
          GoRoute(
            path: Routes.addUser,
            name: Routes.addUser,
            builder: (BuildContext context, GoRouterState state) {
              return const AddUserView();
            },
          ),
          GoRoute(
            path: '${Routes.editUser}/:id',
            name: Routes.editUser,
            builder: (BuildContext context, GoRouterState state) {
              return AddUserView(id: state.pathParameters['id']);
            },
          ),
          GoRoute(
            path: Routes.addStore,
            name: Routes.addStore,
            builder: (BuildContext context, GoRouterState state) {
              return const AddStoreView();
            },
          ),
          GoRoute(
            path: '${Routes.editStore}/:id',
            name: Routes.editStore,
            builder: (BuildContext context, GoRouterState state) {
              return AddStoreView(id: state.pathParameters['id']);
            },
          ),
          GoRoute(
            path: '${Routes.promoCodeView}/:page',
            name: Routes.promoCodeView,
            builder: (BuildContext context, GoRouterState state) {
              return PromoCodeView(page: state.pathParameters['page']);
            },
          ),
          GoRoute(
            path: Routes.productSummary,
            name: Routes.productSummary,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductSummaryView();
            },
          ),
          GoRoute(
            path: Routes.productDetailsView,
            name: Routes.productDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductDetailsView();
            },
          ),
          GoRoute(
            path: Routes.editProfile,
            name: Routes.editProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const EditProfileView();
            },
          ),
          GoRoute(
            path: Routes.creditlineView,
            name: Routes.creditlineView,
            builder: (BuildContext context, GoRouterState state) {
              return const CreditlineView();
            },
          ),
          GoRoute(
            path: "${Routes.retailerSettlement}/:page/:p",
            name: Routes.retailerSettlement,
            builder: (BuildContext context, GoRouterState state) {
              return SettlementScreenView(
                  page: state.pathParameters['page'],
                  p: state.pathParameters['p']);
            },
          ),
          GoRoute(
            path: "${Routes.saleDetails}/:id/:type",
            name: Routes.saleDetails,
            builder: (BuildContext context, GoRouterState state) {
              return SaleDetailsView(
                  id: state.pathParameters['id'],
                  type: state.pathParameters['type']);
            },
          ),
          GoRoute(
            path: "${Routes.saleTransaction}/:id/:type",
            name: Routes.saleTransaction,
            builder: (BuildContext context, GoRouterState state) {
              return SaleTransactionView(
                  id: state.pathParameters['id'],
                  type: state.pathParameters['type'],
                  transaction: state.uri.queryParameters['transaction']);
            },
          ),
          GoRoute(
            path: "${Routes.saleScreen}/:page",
            name: Routes.saleScreen,
            builder: (BuildContext context, GoRouterState state) {
              return SalesScreenView(
                  page: state.pathParameters['page'],
                  query: state.uri.queryParameters['query']);
            },
          ),
          GoRoute(
            path: Routes.financialStatementView,
            name: Routes.financialStatementView,
            builder: (BuildContext context, GoRouterState state) {
              return RetailerFinancialStatementViewWeb(
                  page: state.uri.queryParameters['page'],
                  to: state.uri.queryParameters['to'],
                  from: state.uri.queryParameters['from']);
            },
          ),
          // GoRoute(
          //   path:
          //       '${true ? "${Routes.financialStatementViewSort}/:from/:to/:page" : "${Routes.financialStatementViewSort}/:from/:to/:page"}',
          //   name: Routes.financialStatementViewSort,
          //   builder: (BuildContext context, GoRouterState state) {
          //     return RetailerFinancialStatementViewWeb(
          //       from: state.pathParameters['from'],
          //       to: state.pathParameters['to'],
          //       page: state.pathParameters['page'],
          //     );
          //   },
          // ),
          GoRoute(
            path: '${Routes.financialStatementSaleListViewWeb}/:id',
            name: Routes.financialStatementSaleListViewWeb,
            builder: (BuildContext context, GoRouterState state) {
              debugPrint('statePage');
              debugPrint(state.uri.queryParameters['page']);
              return RetailerFinancialStatementSaleListViewWeb(
                  id: state.pathParameters['id'],
                  statePage: state.uri.queryParameters['statePage'],
                  to: state.uri.queryParameters['to'],
                  from: state.uri.queryParameters['from']);
            },
          ),
          GoRoute(
            // path: '${Routes.fieFinancialStatementView}/:enroll/:from/:to/:page',
            path: Routes.fieFinancialStatementView,
            name: 'fie-statements',
            builder: (BuildContext context, GoRouterState state) {
              return FieFinancialStatementViewWeb(
                clientType: state.uri.queryParameters['enroll'],
                from: state.uri.queryParameters['from'],
                to: state.uri.queryParameters['to'],
                page: state.uri.queryParameters['page'],
              );
            },
          ),
          GoRoute(
            path: '${Routes.fieStatementSaleListViewWeb}/:enroll/:id',
            name: Routes.fieStatementSaleListViewWeb,
            builder: (BuildContext context, GoRouterState state) {
              return FieFinancialStatementSaleListViewWeb(
                  id: state.pathParameters['id'],
                  enroll: state.pathParameters['enroll']);
            },
          ),
          GoRoute(
            path: '${Routes.paymentLotDetailsView}/:id/:type',
            name: Routes.paymentLotDetailsView,
            builder: (BuildContext context, GoRouterState state) {
              return PaymentLotDetailsView(
                  id: state.pathParameters['id'],
                  type: state.pathParameters['type']);
            },
          ),
          GoRoute(
            path: '${Routes.paymentLotDetailsViewfromretailer}/:id/:type',
            name: Routes.paymentLotDetailsViewfromretailer,
            builder: (BuildContext context, GoRouterState state) {
              return PaymentLotDetailsView(
                  id: state.pathParameters['id'],
                  type: state.pathParameters['type']);
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      //Replace this method depends on how you are managing your user's
      //Sign in status, then return the appropriate route you want to redirect to,
      //make sure your login/authentication bloc is provided at the top level
      //of your app
      if (locator<ZDeviceStorage>().getString(DataBase.userToken).isNotEmpty) {
        // locator<AuthService>().getLoggedUserDetails();
        // callPhpWeb("http://18.188.14.183/partners/dashboard.php");
        return null;
      } else {
        //else, remain at login page
        return '/login';
      }
    });
callPhpWeb(String url) async {
  if (!await launchUrl(Uri.parse(url), webOnlyWindowName: '_self')) {
    throw Exception('Could not launch $url');
  }
}
