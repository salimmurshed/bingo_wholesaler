import '../../app/app_config.dart';

class NetworkUrls {
  NetworkUrls._();

  //login
  static String loginUrl = ("${ConstantEnvironment.baseUrl}login");
  //Update Profile
  static String updateProfile =
      ("${ConstantEnvironment.baseUrl}update-profile");
  //Update Profile Image
  static String updateProfileImage =
      ("${ConstantEnvironment.baseUrl}update-profile-image");
  //logout
  static String logoutUrl = ("${ConstantEnvironment.baseUrl}logout");
  //F : Country List
  static String countryUrl = ("${ConstantEnvironment.baseUrl}country-list");
  //W:Retailer Store List For Sales
  static String storeUrl = ("${ConstantEnvironment.baseUrl}store-list");

  //Wholesaler
  //"R : Wholesaler List For Orders"
  static String wholesalerListUri =
      ("${ConstantEnvironment.baseUrl}wholesaler-list");

  //association urls
  //R : FIE List @FIE List For Retailer
  static String fiaListURI = ("${ConstantEnvironment.baseUrl}fie-list");
  //R : Retailer - Wholesaler Association Request List
  static String requestAssociationList =
      ("${ConstantEnvironment.baseUrl}retailer-wholesaler-association-request-list");
  //R : Retailer -  FIE Association Request List
  static String requestFieAssociationList =
      ("${ConstantEnvironment.baseUrl}retailer-fie-association-request-list");
  //W : Wholesaler - Retailer Association Request List
  static String requestAssociationListForWholesaler =
      ("${ConstantEnvironment.baseUrl}wholesaler-retailer-association-request-list?page=");
  //W : View Wholesaler Retailer Association Request
  static String viewWholesalerRetailerAssociationRequest =
      ("${ConstantEnvironment.baseUrl}view-wholesaler-retailer-association-request");
  //R : Add Retailer Wholesaler Association Request
  static String addRetailerWholesalerAssociationRequest =
      ("${ConstantEnvironment.baseUrl}add-retailer-wholesaler-association-request");
  //R : Add Retailer - FIE Association Request
  static String addRetailerFiaAssociationRequest =
      ("${ConstantEnvironment.baseUrl}add-retailer-fie-association-request");
  //R : View Retailer - Wholesaler Association Request
  static String viewRetailerWholesalerAssociationRequest =
      ("${ConstantEnvironment.baseUrl}view-retailer-wholesaler-association-request");
  //R : view Retailer - FIE Association Request
  static String viewRetailerFieAssociationRequest =
      ("${ConstantEnvironment.baseUrl}view-retailer-fie-association-request");
  //W : Update Wholesaler Retailer Association Status
  static String updateWholesalerRetailerAssociationStatus =
      ("${ConstantEnvironment.baseUrl}update-wholesaler-retailer-association-status");
  //R : Update Retailer - Wholesaler Association Status
  static String updateRetailerWholesalerAssociationStatus =
      ("${ConstantEnvironment.baseUrl}update-retailer-wholesaler-association-status");
  //R : Update Retailer - FIE Association Status
  static String updateRetailerFieAssociationStatus =
      ("${ConstantEnvironment.baseUrl}update-retailer-fie-association-status");
  //R : Credit Line Request At Retailer side
  static String retailerCreditlineRequestList =
      ("${ConstantEnvironment.baseUrl}retailer-creditline-request-list?page=");
  //R : credit line details at retailer side
  static String retailerCreditlineRequestDetails =
      ("${ConstantEnvironment.baseUrl}retailer-creditline-request-details");
  //R : Add Creditline Requests
  static String addCreditlineRequests =
      ("${ConstantEnvironment.baseUrl}add-creditline-requests");
  //R: Activate Creditline
  static String activeCreditlineRequests =
      ("${ConstantEnvironment.baseUrl}activate-creditline");
  //R: Creditline Store Assignemnt
  static String updateCreditlineStoreAssignment =
      ("${ConstantEnvironment.baseUrl}update-creditline-store-assignment");
  //R: Add Edit Retailer Store
  static String addEditRetailerStore =
      ("${ConstantEnvironment.baseUrl}add-edit-retailer-store");
  //R: Reply on Creditline Request question by FIE
  static String retailerCreditlineRequestreply =
      ("${ConstantEnvironment.baseUrl}retailer-creditline-request-reply");
  //W : Credit Line Request At wholesaler side
  static String wholesalerCreditlineRequestList =
      ("${ConstantEnvironment.baseUrl}wholesaler-creditline-request-list?page=");
  //W : Get Retailer Store List
  static String getRetailerStoreList =
      ("${ConstantEnvironment.baseUrl}get-retailer-store-list");
  //R : Bank list to create bank account
  static String retailerBankList =
      ("${ConstantEnvironment.baseUrl}retailer-bank-list");
  //W : Store List and CL details For Sales
  static String storeCreditlineDetails =
      ("${ConstantEnvironment.baseUrl}store-creditline-details");
  //F : [FIE] Retailer Bank account list
  static String retailerBankAccountList =
      ("${ConstantEnvironment.baseUrl}retailer-bank-account-list");
  //R: Retailer Associated Wholesaler List
  static String retailerAssociatedWholesalerList =
      ("${ConstantEnvironment.baseUrl}retailer-associated-wholesaler-list");
  //R: Retailer associated FIE list
  static String retailerAssociatedFieList =
      ("${ConstantEnvironment.baseUrl}retailer-associated-fie-list?page=");
  //R : Add / Edit Retailer Bank Account
  static String addEditRetailerBankAccount =
      ("${ConstantEnvironment.baseUrl}add-edit-retailer-bank-account");
  //W : sales-list @sales list for wholesaler
  static String salesList = ("${ConstantEnvironment.baseUrl}sales-list");
  //R : sales List @sales list for retailer @if is_start_payment = 1 then give start payment option
  static String retailerSalesList =
      ("${ConstantEnvironment.baseUrl}retailer-sales-list");
  //W : Add Sales
  static String addSales = ("${ConstantEnvironment.baseUrl}add-sales");
  //W: Offline Sales
  static String wholesalerSyncOfflineSales =
      ("${ConstantEnvironment.baseUrl}wholesaler-sync-offline-sales");
  //W : Update-Sales
  static String updateSales = ("${ConstantEnvironment.baseUrl}update-sales");
  //R : Approved, Rejected, Confirm delivery
  static String updateSalesStatus =
      ("${ConstantEnvironment.baseUrl}update-sales-status");
  //W : cancel-sales
  static String cancelSalesq = ("${ConstantEnvironment.baseUrl}cancel-sales");
  //R : Retailer Start Payment
  static String createPayment =
      ("${ConstantEnvironment.baseUrl}retailer-start-payment");
  //R: Bank account: Send for validation to FIE
  static String changeRetailerBankAccount =
      ("${ConstantEnvironment.baseUrl}change-retailer-bank-account");
  //W: Wholesaler Associated Retailer List
  static String wholesalerAssociatedRetailerList =
      ("${ConstantEnvironment.baseUrl}wholesaler-associated-retailer-list?page=");
  //W: Get creditline lis for retailer => Wholesaler Side
  static String retailerWholesalerCreditlineList =
      ("${ConstantEnvironment.baseUrl}retailer-wholesaler-creditline-list?page=");
  //W: Get sales list retailer
  static String retailerWholesalerSalesList =
      ("${ConstantEnvironment.baseUrl}retailer-wholesaler-sales-list?page=");
  //W: Get settlement list for retailer
  static String retailerWholesalerSettlementList =
      ("${ConstantEnvironment.baseUrl}retailer-wholesaler-settlement-list");
  //W: Get location list for retailer
  static String retailerWholesalerStoreList =
      ("${ConstantEnvironment.baseUrl}retailer-wholesaler-store-list");
  //retailer-store-details-for-wholesaler
  static String retailerStoreDetailsForWholesaler =
      ("${ConstantEnvironment.baseUrl}retailer-store-details-for-wholesaler");
  //R: Change retailer store status
  static String changeRetailerStoreStatus =
      ("${ConstantEnvironment.baseUrl}change-retailer-store-status");
//R : View Retailer Lot Details
  static String retailerSettlementDetails =
      ("${ConstantEnvironment.baseUrl}view-retailer-lot-details");
  //R: Approved Creditlines
  static String retailerApprovedCreditLinesList =
      ("${ConstantEnvironment.baseUrl}retailer-approved-credit-lines-list");
  //R: Dashoboard: Pending Approvals / Delivery Confirmations
  static String retailerPendingSalesList =
      ("${ConstantEnvironment.baseUrl}retailer-pending-sales-list");
  //R: Dashboard Deposit Recommondation
  static String retailerDepositRecommendation =
      ("${ConstantEnvironment.baseUrl}retailer-deposit-recommendation");

  //components urls
//F : Tax ID Type LIst
  static String taxIdType = ("${ConstantEnvironment.baseUrl}tax-id-type-list");
  //R: Roles List
  static String retailerRolesList =
      ("${ConstantEnvironment.baseUrl}get-retailer-roles-list");
  //W : Customer Type List
  static String customerType =
      ("${ConstantEnvironment.baseUrl}customer-type-list");
  //W : Grace period groups list
  static String gracePeriodGroup =
      ("${ConstantEnvironment.baseUrl}grace-period-groups-list");
  //W : Pricing Groups List
  static String pricingGroup =
      ("${ConstantEnvironment.baseUrl}pricing-groups-list");
  //W : Sales Zone List
  static String salesZone =
      ("${ConstantEnvironment.baseUrl}wholesaler-sales-zone-list");
  //Country-List
  static String countryUri = ("${ConstantEnvironment.baseUrl}country-list");
  //F : City List
  static String cityUri = ("${ConstantEnvironment.baseUrl}city-list");
  //R : All FIE list for add creditline request @all fie With Whom You Are Working
  static String allFieListForCreditLine =
      ("${ConstantEnvironment.baseUrl}all-fie-list-for-creditline-request");
  //R : get wholesaler and its currency for add creditline request
  static String partnerWithCurrencyList =
      ("${ConstantEnvironment.baseUrl}partner-with-currency-list");
  //W : Dynamic Routes List @it will gives default today's data and if pass the from and to date then it will gives filterable data
  static String dynamicRoutesUrl =
      ("${ConstantEnvironment.baseUrl}dynamic-routes-list?page=");
  //W : static route list
  static String staticRoutesUrl =
      ("${ConstantEnvironment.baseUrl}static-routes-list?page=");
  //W : Dynamic Routes Details
  static String dynamicRoutesDetails =
      ("${ConstantEnvironment.baseUrl}dynamic-routes-details");
  //W : static routes details
  static String staticRoutesDetails =
      ("${ConstantEnvironment.baseUrl}static-routes-details");
  //General Page Detail
  static String getPageTerms =
      ("${ConstantEnvironment.baseUrl}get-page-detail");
  //W : Manage sales zone list
  static String getSaleZone =
      ("${ConstantEnvironment.baseUrl}manage-sale-zones-list?page=");
  //W : Manage sales zone details
  static String manageSaleZoneDetails =
      ("${ConstantEnvironment.baseUrl}manage-sale-zone-details");
  //R : Order Selection @get product details ,delivery methods ,payment methods and creditline details for add orders
  static String orderSelection =
      ("${ConstantEnvironment.baseUrl}order-selection");
  //W : view wholesaler order details with two step generation
  static String viewWholesalerOrderDetails =
      ("${ConstantEnvironment.baseUrl}view-wholesaler-order-details");
  //R : Apply Promocode
  static String applyPromoCode =
      ("${ConstantEnvironment.baseUrl}apply-promocode");
  //R : Add Order
  static String addOrder = ("${ConstantEnvironment.baseUrl}add-order");
  //W : Update order from wholesaler side
  static String wholesalerUpdateOrder =
      ("${ConstantEnvironment.baseUrl}wholesaler-update-order");
  //R : Order List  @order list at retailer side
  static String retailerOrderList =
      ("${ConstantEnvironment.baseUrl}retailer-order-list?page=");
  //W : order list (wholesaler side)
  static String wholesalerOrderList =
      ("${ConstantEnvironment.baseUrl}wholesaler-order-list?page=");

  //R : View Retailer Order Details
  static String retailerOrderDetails =
      ("${ConstantEnvironment.baseUrl}view-retailer-order-details");
  //W : Wholesaler Notifications List
  static String wholesalerNotificationsList =
      ("${ConstantEnvironment.baseUrl}wholesaler-notifications-list?page=");
  //R : Retailer Notifications List
  static String retailerNotificationsList =
      ("${ConstantEnvironment.baseUrl}retailer-notifications-list?page=");
  //R: User list
  static String retailerUsersList =
      ("${ConstantEnvironment.baseUrl}get-retailer-users-list?page=");
  //R : Retailer Sales and Transaction Details
  static String retailerSalesDetails =
      ("${ConstantEnvironment.baseUrl}retailer-sales-transaction-details");
  //W : Get Sales Details
  static String getSaleDetails =
      ("${ConstantEnvironment.baseUrl}get-sales-details");
  //R: Add User
  static String addRetailerUser =
      ("${ConstantEnvironment.baseUrl}add-retailer-user");
  //R: Edit User
  static String editRetailerUser =
      ("${ConstantEnvironment.baseUrl}edit-retailer-user");
  //R: Inactive User
  static String inactiveRetailerUser =
      ("${ConstantEnvironment.baseUrl}inactive-retailer-user");
  //R : Get Retailer Bank Account Detail
  static String getRetailerBankAccountDetail =
      ("${ConstantEnvironment.baseUrl}get-retailer-bank-account-detail");
  //F: Mark as Read Unread FIE Notification
  static String markAsReadNotification =
      ("${ConstantEnvironment.baseUrl}mark-as-read-unread-notifications");
  //R: Get Company Profile
  static String getCompanyProfile =
      ("${ConstantEnvironment.baseUrl}get-company-profile");
  //R: Update Company Profile
  static String updateCompanyProfile =
      ("${ConstantEnvironment.baseUrl}update-company-profile");
  //R: Get Retailer Bank Account Balance
  static String getRetailerBankAccountBalance =
      ("${ConstantEnvironment.baseUrl}get-retailer-bank-account-balance");
  //W: Add Remove Today Route
  static String addRemoveTodayRoute =
      ("${ConstantEnvironment.baseUrl}add-remove-today-route");
  //W: Add Remove Today Zone
  static String addRemoveTodayZone =
      ("${ConstantEnvironment.baseUrl}add-remove-today-zone");
  //W: Get Today Route List
  static String getTodayRouteList =
      ("${ConstantEnvironment.baseUrl}get-today-route-list");
  //W: Update Today Route Store Status
  static String updateTodayRouteStoreStatus =
      ("${ConstantEnvironment.baseUrl}update-today-route-store-status");
  //W: Get Today Route Store Deline List
  static String getTodayStoreDeclineReasonList =
      ("${ConstantEnvironment.baseUrl}get-today-store-decline-reason-list");
  //R : Request Creditline Review
  static String retailerRequestCreditlineReview =
      ("${ConstantEnvironment.baseUrl}retailer-request-creditline-review");
  //R : Make Active Creditline Inactive
  static String makeActiveCreditlineInactive =
      ("${ConstantEnvironment.baseUrl}make-active-creditline-inactive");
  //R : Retailer Sales and Transaction Details
  static String retailerSalesTransactionDetails =
      ("${ConstantEnvironment.baseUrl}retailer-sales-transaction-details");
  //W : Wholesale Sale Transaction Details
  static String wholesalerSalesTransactionDetails =
      ("${ConstantEnvironment.baseUrl}wholesaler-sale-transaction-details");
  //R : Wholesaler List For Orders
  static String wholesalerListForOrder =
      ("${ConstantEnvironment.baseUrl}wholesaler-list-for-order");

//financial-statements
  //R : Financial statements list for retailers
  static String retailerFinancialStatementsList =
      ("${ConstantEnvironment.baseUrl}retailer-financial-statements-list");
  //W : Financial Statement List For Wholesaler
  static String wholesalerFinancialStatementsList =
      ("${ConstantEnvironment.baseUrl}wholesaler-financial-statements-list");

  //R : Financial statements list for retailer sale
  static String retailerSaleFinancialStatementsList =
      ("${ConstantEnvironment.baseUrl}retailer-sale-financial-statements-list");

  //todo
  static String wholesalerSaleFinancialStatementsList =
      ("${ConstantEnvironment.baseUrl}wholesaler-sale-financial-statements-list");
//F : Fie Retailer Financial statements for fie
  static String fieRetailerStatementList =
      ("${ConstantEnvironment.baseUrl}fie-retailer-financial-statements-list");
  //todo
  static String fieRetailerSaleStatementList =
      ("${ConstantEnvironment.baseUrl}fie-retailer-sale-financial-statements-list");
//F : Fie Wholesaler Financial statements for fie Copy
  static String fieWholesalerStatementList =
      ("${ConstantEnvironment.baseUrl}fie-wholesaler-financial-statements-list");
  //todo
  static String fieWholesalerSaleStatementList =
      ("${ConstantEnvironment.baseUrl}fie-wholesaler-sale-financial-statements-list");
//todo
  static String fieFieStatementList =
      ("${ConstantEnvironment.baseUrl}fie-fie-financial-statements-list");
  //todo
  static String fieFieSaleStatementList =
      ("${ConstantEnvironment.baseUrl}fie-fie-sale-financial-statements-list");
//todo
  static String fieBingoStatementList =
      ("${ConstantEnvironment.baseUrl}fie-bingo-financial-statements-list");
//todo
  static String fieBingoSaleStatementList =
      ("${ConstantEnvironment.baseUrl}fie-bingo-sale-financial-statements-list");

//settlement
  //R : Retailer Settlement List
  static String retailerSettlementList =
      ("${ConstantEnvironment.baseUrl}retailer-settlement-list?page=");
  //W : Settlement List @settlement list For Wholesaler
  static String wholesalerSettlementList =
      ("${ConstantEnvironment.baseUrl}wholesaler-settlement-list?page=");
  //F : Settlement List @settlement List For FIE
  static String fieSettlementList =
      ("${ConstantEnvironment.baseUrl}fie-settlement-list?page=");
  //F : Accounting
  static String fieAccountingList =
      ("${ConstantEnvironment.baseUrl}fie-accounting");
  //F : Add Collection Lot
  static String addCollectionLot =
      ("${ConstantEnvironment.baseUrl}add-collection-lot");
  //R : Add Payment Lot
  static String addPaymentLot =
      ("${ConstantEnvironment.baseUrl}add-payment-lot");
  //F : Download Accounting CSV
  static String downloadCSV =
      ("${ConstantEnvironment.baseUrl}fie-accounting/download-csv");
  //F : Download Accounting XML
  static String downloadXML =
      ("${ConstantEnvironment.baseUrl}fie-accounting/download-xml");
//F : view Lot Details
  static String viewLotDetails =
      ("${ConstantEnvironment.baseUrl}view-lot-details");
//W : Wholesaler lot details
  static String viewWholeSalerLotDetails =
      ("${ConstantEnvironment.baseUrl}view-wholesaler-lot-details");
//R : View Retailer Lot Details
  static String viewRetailerLotDetails =
      ("${ConstantEnvironment.baseUrl}view-retailer-lot-details");
  //R: Get User
  static String getRetailerUserDetails =
      ("${ConstantEnvironment.baseUrl}get-retailer-user-detail");
  //R: Get Store Detail
  static String getRetailerStore =
      ("${ConstantEnvironment.baseUrl}get-retailer-store");
  //W: Promocode list
  static String promoCodeList =
      ("${ConstantEnvironment.baseUrl}promocode-list");
  //W: Add Edit Promocode
  static String addEditPromocode =
      ("${ConstantEnvironment.baseUrl}add-edit-promocode");
  //Clear Today's Routes
  static String clearTodayRoutes =
      ("${ConstantEnvironment.baseUrl}clear-today-routes");
  //W : Internal Configuration list
  static String wholesalerInternalConfigurationList =
      ("${ConstantEnvironment.baseUrl}wholesaler-internal-configuration-list");
  //Set Mobile App Pin
  static String setMobileAppPin =
      "${ConstantEnvironment.baseUrl}set-mobile-app-pin";
  //Change Mobile App Pin
  static String changeMobileAppPin =
      "${ConstantEnvironment.baseUrl}change-mobile-app-pin";
  //Verify Mobile App Pin
  static String verifyMobileAppPin =
      "${ConstantEnvironment.baseUrl}verify-mobile-app-pin";
  //W: Delete Customer Type, W: Add Customer Type, W: Update Pricing Group
  static String addCustomerTypes =
      "${ConstantEnvironment.baseUrl}customer-types";
  //W: Update Pricing Group
  static String addCustomerTypesUpdate =
      "${ConstantEnvironment.baseUrl}customer-types/update";
  //W: Delete Grace Period, W: Add Grace Period Group, W: Update Grace Period Group
  static String addGracePeriodGroups =
      "${ConstantEnvironment.baseUrl}grace-period-groups";
  //W: Update Grace Period Group
  static String addGracePeriodGroupsUpdate =
      "${ConstantEnvironment.baseUrl}grace-period-groups/update";
  //W: Delete Pricing Group, W: Add Pricing Group, W: Update Pricing Group
  static String addPricingGroups =
      "${ConstantEnvironment.baseUrl}pricing-groups";
//W : Update sale zone details
  static String updateSaleZoneDetails =
      "${ConstantEnvironment.baseUrl}update-sale-zone-details";
  //W: List Pricing Groups
  static String pricingGroupsList =
      "${ConstantEnvironment.baseUrl}pricing-groups-list";
  //W: Product list with price group
  static String productListWithPriceGroup =
      "${ConstantEnvironment.baseUrl}product-list-with-price-group";
  //R: Approved Creditlines
  static String retailerApprovedCreditLines =
      "${ConstantEnvironment.baseUrl}retailer-approved-credit-lines/";
  //W: List Payment Methods, W: Add Payment Method, W: Update Payment Method, W: Remove Payment Method
  static String paymentMethods =
      "${ConstantEnvironment.baseUrl}payment-methods";
  //W: List Delivery Methods, W: Delete Delivery Method, W: Add Delivery Method, W:  Update Delivery Method
  static String deleveryMethods =
      "${ConstantEnvironment.baseUrl}delivery-methods";
  //todo
  static String uri_retailerWholesalerCreditlineSummary =
      "${ConstantEnvironment.baseUrl}retailer-wholesaler-creditline-summary";
  //todo
  static String uri_retailerWholesalerCreditlineDetails =
      "${ConstantEnvironment.baseUrl}retailer-wholesaler-creditline-details";
  //W : Update static route status
  static String uri_updateStaticRouteStatus =
      "${ConstantEnvironment.baseUrl}update-static-route-status";
  //W : update dynamic route status
  static String uri_updateDynamicRouteStatus =
      "${ConstantEnvironment.baseUrl}update-dynamic-route-status";
  //W : Update Manage Sales zone location staus @active @inactive
  static String uri_updateManageSaleZoneLocationStatus =
      "${ConstantEnvironment.baseUrl}update-manage-sale-zone-location-status";

  static String createPaymentOnWebsite =
      ("${ConstantEnvironment.baseUrl}v2/statements/start-payment");
  static String retailerFinancialStatementsListV2 =
      ("${ConstantEnvironment.baseUrl}v2/retailer-financial-statements-list");
  static String wholesalerFinancialStatementsListV2 =
      ("${ConstantEnvironment.baseUrl}v2/wholesaler-financial-statements-list");
  static String retailerSaleFinancialStatementsListV2 =
      ("${ConstantEnvironment.baseUrl}v2/retailer-sale-financial-statements-list");
  static String wholesalerSaleFinancialStatementsListV2 =
      ("${ConstantEnvironment.baseUrl}v2/wholesaler-sale-financial-statements-list");
}
