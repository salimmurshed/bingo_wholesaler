import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app/locator.dart';
import '../services/navigation/navigation_service.dart';

final NavigationService _nav = locator<NavigationService>();

class AppString {
  AppString._();

  static String emailAddress =
      AppLocalizations.of(_nav.activeContext)!.emailAddress;
  static String password = AppLocalizations.of(_nav.activeContext)!.password;
  static String login = AppLocalizations.of(_nav.activeContext)!.login;
  static const String stars = '*****';

  static const String ownerLegalRepresentative = 'Owner/Legal Representative';
  static const String internalInformation = 'Internal Information';
  static const String creditLine = 'Credit Line';
  static const String viewRetailerStores = 'View Retailer Stores';
  static const String noDataInTable = 'No data available in table';
  static const String internalID = "Internal ID";
  static const String selectCustomerType = "Customer Type";
  static const String gracePeriodGroups = "Grace Period Groups";
  static const String pricingGroups = "Pricing Groups";
  static const String salesZone = "Sales Zone";
  static const String salesRoute = "Sales Routes";
  static const String salesStores = "Sales Stores";
  static const String selectWholeSaler = "Select Wholesaler";
  static const String allowOrders = "Allow Orders";
  static const String customerSinceDate = "Customer Since Date";
  static const String monthlySales = "Monthly Sales";
  static const String averageSalesTicket = "Average Sales Ticket";
  static const String visitFrequency = "Visit Frequency";
  static const String suggestedCreditLineAmount =
      "Suggested Credit Line Amount";
  static const String activationRequirement = "Activation code is required";
  static const String recommendedCreditLineAmount =
      "Recommended Credit Line Amount";
  static const String retailerCompletedInfomation =
      "Retailer Completed Infomation";
  static const String put6DigitCode = "Please add "
      "valid 6 numbers code";
  static const String retailer = "Retailer";
  static const String availableAmount = "Available Amount to ";
  static const String bankAccountTypeValidationText =
      "Need to select bank account";
  static const String bankNameValidationText = "Need to select bank name";
  static const String currencyValidationText = "Need to select currency";
  static const String bankAccountValidationText =
      "Bank account number can't be blank";
  static const String bankAccountLengthValidationText =
      "Bank account number can't be less than 8";
  static const String ibanValidationText = "IBAN account number can't be blank";
  static const String ibanLengthValidationText =
      "IBAN account number can't be less than 8";

  //all buttons
  static const String addNew = 'Add New';
  static const String imageLoading = 'Image Loading...';
  static const String dataStored = "Data Stored";
  static const String addNewWholesaler = 'Add New Wholesaler';
  static const String chooseFiles = 'Choose Files';
  static const String approve = 'approve';
  static const String confirmDelivery = 'Confirm Delivery';
  static const String edit = 'Edit';
  static const String reject = 'reject';
  static const String submitButton = 'submit';
  static const String rejectSell = 'No';
  static const String acceptSell = 'Yes';
  static const String closeButton = 'Close';
  static const String cancelButton = 'cancel';
  static const String inactiveButton = 'inactive';
  static const String requestCreditLineReview = 'REQUEST CREDIT LINE REVIEW';
  static const String activeButton = 'active';
  static const String startPayment = 'Start payment';
  static const String offlineApprove = 'Offline approve';
  static const String generateQRCode = 'Generate QR code';
  static const String activationCode = 'ACTIVATION CODE';
  static const String accept = 'Accept';
  static const String viewDocuments = 'View Documents';
  static const String noText = 'No';
  static const String yesText = 'Yes';
  static const String loadMore = 'Load More';
  static const String commercialName = 'Commercial Name: ';
  static const String aboutUs = 'About Us: ';
  static const String dateFounded = 'Date Founded: ';
  static const String legalName = 'Legal Name: ';
  static const String taxID = 'Tax ID: ';
  static const String businessAddress = 'Business Address: ';
  static const String fName = 'First Name: ';
  static const String lName = 'Last Name: ';
  static const String positioN = 'Position: ';
  static const String iD = 'ID: ';
  static const String phoneNumbeR = 'Phone Number: ';
  static const String websiteUrl = 'Website URL: ';
  static const String routeID = 'Route ID: ';
  static const String sNo = 'S.No.: ';
  static const String descriptioN = 'Description: ';
  static const String documentType = 'Document Type:';
  static const String documentId = 'Document ID:';
  static const String contractAccount = 'Contract Account:';
  static const String collectionLot = 'Collection Lot #';
  static const String factura = 'FACTURA #';
  static const String creditLineDocuments = 'Credit Line Documents';
  static const String retailerStores = 'Retailer Stores';
  static const String creditLineHeader = 'Credit Line Header';

  //app bar title
  static const String dashBoard = 'DashBoard';
  static const String requests = 'requests';
  static const String settings = 'settings';
  static const String accountBalance = 'ACCOUNT BALANCE';
  static const String requestsDetail = 'request details';

  static const String wAssociationRequests = 'Wholesaler Association';
  static const String associationRequests = 'Association';
  static const String fAssociationRequests = 'FIE Association';
  static const String creditLineRequests = 'Credit Line';

//screen texts
  static const String users = 'Users';
  static const String roles = 'Roles';
  static const String status = "Status";
  static const String date = "Date";
  static const String stores = 'Stores';
  static const String invoices = 'Invoices';
  static const String invoice = 'Invoice:';
  static const String openBalance = 'Open Balance:';
  static const String appliedAmount = 'Amount Applied:';
  static const String creditLineID = 'Credit Line ID:';
  static const String businessPartnerID = 'Business Partner ID:';
  static const String manageAccount = 'Manage Account';
  static const String companyProfile = 'Company Profile';
  static const String newOrderRequest = 'New Order Requests';
  static const String emailTitle = 'Email';
  static const String phoneTitle = 'Phone';

  // error handler
  static const String badRequestError = "bad_request_error";
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal server error";
  static const String serverError = "Server "
      "error";
  static const String dataStoredMessage = "Data has been stored";
  static const String emptyFieldMessage = "Field can not be empty";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "default_error";
  static const String cacheError = "cache_error";
  static const String noInternetError = "Please check internet connection";
  static const String success = "success";
  static const String applicationInformation = 'Application information';

  static const String needToSelectOneWholesaler = "You need to "
      "select minimum one wholesaler";
  static const String needToSelectFie = "You need to "
      "select minimum one Financial Institution";
  static const String pleaseSelectOne = "Please select one option";
  static const String pleaseAelectARetailer = "Please select a retailer";
  static const String pleaseSelectTermConditions = "Please select terms & "
      "conditions";
  static const String fillOneCommercialReferenceName = "Please fill minimum "
      "one commercial reference name";
  static const String fillOneCommercialReferencePhone = "Please fill minimum "
      "one commercial reference phone";
  static const String provideRelevantDoc = "Please provide all relevant "
      "documents";
  static const String saveDataMessage = "Data have been saved!";
  static const String updateDataMessage = "Data have been updated!";
  static const String orderPlacedSuccessfully = 'Sale Placed Successfully. ';
  static const String orderUpdateSuccessfully = 'Sale update Successfully. ';
  static const String requestSendSuccessMessage = 'Request has been send to '
      'admin';
  static const String viewSalesDetail = 'View sales detail';
  static const String cancelTheSale = 'Cancel the sale';
  static const String cancelTheSaleContent = 'Are you sure to cancel the sale?';
  static const String unableToPlaceSaleMessage = 'You cannot place the sale';
  static const String sendAccountValidationText = "Send For validation";

  // static const String mainProjectAppBarTitle = 'Create Sub Project';
  // static const String mainProjectAppBarTitle = 'Create Sub Project';

  //App request

  static const String offlineSaleLogoutAlert =
      "If you logout before internet connection, your offline sales might"
      " be deleted!";

  static const String orderID = 'Order ID: ';
  static const String invoiceTo = 'Invoice to: ';
  static const String from = "From: ";
  static const String lotId = "Lot ID:";
  static const String lotType = "Lot Type:";
  static const String dateGenerated = "Date Generated:";
  static const String postingDate = "Posting Date:";
  static const String user = "User: ";
  static const String amountCollected = "Amount Collected:";
  static const String amountPaid = "Amount Paid: ";
  static const String openBalanceAmount = "Open Balance Amount:";
  static const String wholesalerId = "Wholesaler Store ID: ";
  static const String fieName = 'FIE Name: ';
  static const String dateOfInvoice = 'Date Of Invoice:';
  static const String bingoOrderId = 'Bingo Order ID: ';
  static const String sr = 'Sr No: ';
  static const String orderNumber = 'Order Number:';
  static const String dueDate = 'Due Date:';
  static const String salesAmount = 'Sales Amount:';
  static const String salesBalance = 'Sales Balance:';
  static const String saleDate = 'Sale Date:';
  static const String saleId = 'Sale ID:';
  static const String salesStep = 'Sales Step:';
  static const String bingoStoreID = 'Bingo Store ID:';
  static const String fie = 'FIE: ';
  static const String statuS = 'Status:';
  static const String settNo = 'Sett No:';
  static const String currencY = 'Currency:';
  static const String appamount = 'App. Amount:';
  static const String amountBalance = 'Amount Balance:';
  static const String amounT = 'Amount: ';
  static const String appDate = 'App. Date:';
  static const String expDate = 'Exp Date: ';
  static const String serialNo = 'S. No: ';
  static const String fiaName = 'Nombre de la FIE: ';
  static const String balance = 'Balance: ';
  static const String caNumber = 'Número de la CA del Banco';
  static const String expireDateSale = 'Fecha de Vencimiento Cantidad de '
      'Venta:';
  static const String depositRecommendation = 'Recomendaciones de depósito::';
  static const String wantToRejectTitle = 'Rejection request';
  static const String wantToRejectContent = 'Do you really want to reject this '
      'request?';
  static const String rejectionCompleteSuccessful = "Your request "
      "rejection is completed";
  static const String rejectionCompleteUnsuccessful = "Your request "
      "rejection is unsuccessful";
  static const String noWholesalerAvailableMessage = "No wholesaler available "
      "in your connection";
  static const String sortBy = "Sort by:";
  static const String editYourProfile = "Edit Your Profile";
  static const String changePassword = "Change Password";

  //association text
  static const String taxId = 'Tax ID';
  static const String associationDate = 'Association Date';
  static const String activationDate = 'Activation Date';
  static const String requestDate = 'Request Date';
  static const String companyAddress = 'Company Address';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String position = 'Position';
  static const String currentPassword = 'Current Password';
  static const String newPassword = 'New Password';
  static const String retypePassword = 'Retype Password';
  static const String id = 'ID';
  static const String taxIdType = 'Tax Id Type';
  static const String phoneNumber = 'Phone Number';
  static const String category = 'Category';
  static const String email = 'Email';
  static const String phone = 'Phone No:';
  static const String remarks = 'Remark:';
  static const String idType = 'ID Type';
  static const String country = 'Country';
  static const String city = 'City';
  static const String setPricing = 'Set Pricing';
  static const String tryAgain = 'Try Again';
  static const String saleNotForYou = "This sale is not for you";
  static const String datainsertedMessage = "Data Has been inserted";

  /// [AddStoreView] AddStoreView text
  static const String locationName = 'Location Name';
  static const String assignedAmount = 'Assigned Amount:';
  static const String consumedAmount = 'Consumed Amount:';
  static const String address = 'Address';
  static const String paymentDetails = 'Payment Details';
  static const String routesInformation = 'Routes Information';
  static const String dynamicRoutes = 'Dynamic Routes';
  static const String staticRoutes = 'Static Routes';
  static const String frontBusinessPhoto = 'Front Business Photo';
  static const String signBoardPhoto = 'Sign Board Photo';
  static const String remark = 'Remark';
  static const String updateStore = 'Update Store';
  static const String update = 'Update';
  static const String remove = 'remove';
  static const String addStore = "Add STORE";
  static const String photos = "Photos";
  static const String editStore = "UPDATE STORE";
  static const String addManageAccount = "Add Account";
  static const String bankAccounttype = "Bank Account type";
  static const String bankName = "Bank Name";
  static const String currency = "Currency";
  static const String bankAccountNumber = "Bank Account Number";
  static const String iban = "IBAN";
  static const String monthlyPurchase = "Monthly Purchase";
  static const String averagePurchaseTicket = "Average Purchase Ticket";
  static const String requestedAmount = "Requested Amount";
  static const String createCreditLineRequest = "CREATE CREDIT LINE REQUEST";
  static const String acceptTermAndConditions = "Accept Terms & Condition and "
      "authorize"
      " Bingo to send Credit Line Request detail to Financial Institutions";
  static const String bingoCanForwardRequest =
      "Allow Bingo to forward this Credit "
      "Line "
      "Request to As Many Finacial Institutions deemed appropriate";
  static const String specificFIA = "Send Credit Line Request To a Specific "
      "Financial institution";
  static const String wholesalerValidationText = "Need to select wholesaler";
  static const String mPurchaseValidationText =
      "Monthly purchase can not be empty";
  static const String aPurchaseValidationText =
      "Average purchase can not be empty";
  static const String vFrequencyValidationText =
      "Need to select visit frequency";
  static const String rAmountValidationText =
      "Requested amount can not be empty";

  static const String locationNameValidationMessage =
      "Location name can't be empty";
  static const String selectedCityValidationMessage = "Need to select a city";
  static const String addressValidationMessage =
      "You have to select an address";
  static const String remarksValidationMessage = "Remarks can't be empty";
  static const String saleCancellMessage = "Sale has been canceled";
  static const String needInternetMessage =
      "You need internet connection to cancel "
      "any request";
  static const String selectedCountryValidationMessage =
      "Need to select a country";
  static const String frontPhotoValidationMessage = "Need to select a front "
      "business photo";
  static const String signBoardPhotoValidationMessage =
      "Need to select a sign board photo";

  //Select Items
  static const String selectFie = "Select Single FIE";
  static const String selectText = 'Select';
  static const String selectedSalesZoneStringDefaultValue = 'XXXXXX';
  static const String selectedWholeSalerStringDefaultValue = 'XXXXXX';
  static const String selectMultipleWholesaler = 'Select Multiple Wholesaler';
  static const String selectMultipleFia = 'Select Multiple FIE';
  static const String selectCountry = "Select Country";
  static const String selectCity = "Select City";
  static const String selectWholesaler = "Select Wholesaler";
  static const String selectCurrency = "Currency";
  static const String selectRetailer = "Select Retailer";
  static const String selectStore = "Select Store";
  static const String selectSaleType = "Select Sales Type";
  static const String emptyPasswordValidationText =
      "Password field can't be empty";
  static const String smallPasswordValidationText =
      "Password should be more than 8";
  static const String emptyEmailValidationText = "Email field can't be empty";
  static const String wrongEmailFormatValidationText =
      "Please put a valid email "
      "address";
  static const String internalIdValidationMessage = "Internal ID required";
  static const String monthlySalesValidationMessage =
      "Monthly sales amount is required";
  static const String selectDateValidationMessage = "Sales date required";
  static const String averageSalesTicketValidationMessage =
      "Average sales ticket is required";
  static const String suggestedCreditLineValidationMessage =
      "Suggested creditline is required";
  static const String selectedCustomerTypeValidationMessage =
      "Need to select customer type";
  static const String selectedGracePeriodGroupsValidationMessage =
      "Need to select grace period group";
  static const String selectedPricingGroupsValidationMessage =
      "Need to select pricing group";
  static const String selectedSalesZoneStringValidationMessage =
      "Need to select sales zone";
  static const String selectedAllowOrdersValidationMessage =
      "Need to select allow orders";
  static const String selectedVisitFrequencyValidationMessage =
      "Need to select visit frequency "
      "number";

  //tab names
  static const String wholesaler = "Wholesaler:";
  static const String addNewIcon = "+ ADD NEW";
  static const String store = "Store";
  static const String salesType = "Sales Type";
  static const String invoiceNumber = "Invoice Number";
  static const String amount = "Amount";
  static const String description = "Description";
  static const String orderNumberSale = "Order Number";
  static const String financialInstitution = "Financial Institution";
  static const String financialInstitutioN = "Financial Institution:";

  //text field data
  static const String crn1TextField = "Commercial Reference Name 1";
  static const String crn2TextField = "Commercial Reference Name 2";
  static const String crn3TextField = "Commercial Reference Name 3";
  static const String crp1TextField = "Commercial Reference Phone No. 1";
  static const String crp2TextField = "Commercial Reference Phone No. 2";
  static const String crp3TextField = "Commercial Reference Phone No. 3";
  static const String hintTextInvoiceController = "Enter Invoice Number";
  static const String hintTextOrderController = "Enter Order Number";
  static const String hintTextCurrencyController =
      "Approve Creditline Currency";
  static const String hintTextAmountController = "Enter Amount";
  static const String hintTextDescriptionController = "Enter Description";

  //body title
  static const String creditLineInformation = "Credit Line Information";
  static const String selectMultipleFie =
      "Select Financial Institution With Whom "
      "You Are Working";
  static const String uploadFie = "Upload Financial Statements";
  static const String chooseOptions = "Choose Options";
  static const String questionAnswers = "Financial Institutions Question";
  static const String files = "View Supported Documents";
  static const String removeWholeSalerText = "Wholesaler has been removed";
  static const String exitApp = "Exit App";
  static const String exitAppBody = "Do you want to exit an App?";
  static const String noData = "No Data";
  static const String noInternet = "No Internet";
  static const String logoutNoInternetMessage =
      "Need internet Connection for logout";
  static const String noSaleMessage = "No sales data available";
  static const String noTransectionMessage = "No Transection data available";

  //Status title
  static const String accepted = "Accepted";
  static const String rejected = "Rejected";
  static const String verified = "Verified";
  static const String active = "Active";
  static const String completed = "Completed";
  static const String salePandingApproval = "Sale Pending Approval";
  static const String pendingWholesalerReview = "Pending Wholesaler \nReview";
  static const String salePendingApproval = "Sale Pending Approval";
  static const String saleApproval = "Sale Approval";
  static const String saleDelivered = "Sale Delivered";
  static const String endOfPage = "End Of Page";
  static const String currentBalance = "Current Balance:";
  static const String expirationDate = "Expiration Date:";
  static const String amountAvailable = "Amount Available";
  static const String appAmount = "App. Amount:";
  static const String approvedAmount = "Approved Amount:";
  static const String bankAccountNo = "Bank Account No:";
  static const String remainAmount = "Remain Amount:";
  static const String minimumCommitmentDate = "Minimum Commitment Date:";
  static const String effectiveDate = "Effective Date:";
  static const String noName = "No Name";
  static const String editProfile = "Edit Profile";
  static const String updateProfile = "Update Profile";
  static const String changeYourProfilePicture = "Change your Profile Picture";
  static const String chooseYourProfilePicture = "Choose your Profile Picture";
  static const String uploadProfilePicture = "Upload Profile Picture";
  static const String noWholesaler = "No Wholesaler "
      "Available.\n you need to create wholesaler first.";
  static const String purchaseAbilityTextFormat = "Amount can't be more than "
      "available balance\n"
      "you can purchase maximum ";

  //sales
  static const String confirmationDialogTitle = "Confirmation of your action";
  static const String confirmationRejectContent =
      "Do you really want to reject this sale?";
  static const String confirmationApproveContent =
      "Do you really want to approve this sale?";
  static const String confirmationDeliverContent =
      "Do you really get your products?";
  static const String salesRejectToast = "Cancel Sale request rejected by you";
  static const String salesApproveToast = "Cancel Sale request approval by you";
  static const String salesDeliverToast = "Cancel Sale request delivery by you";
}
