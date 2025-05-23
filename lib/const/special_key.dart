import 'package:encrypt/encrypt.dart' as encrypt;

class SpecialKeys {
  SpecialKeys._();
  static const lockTiming = 1 * 5 * 60 * 1000;
//replace the one, how many hour you wanna set(1 * 60 * 60 * 1000)
  static String appVersion = "Version: 1.0.0";
  static String perPage = 'per_page';
  static String pdf = 'pdf';
  static String languageEn = 'en';
  static String languageEs = 'es';
  static String poppins = 'Poppins';
  static String startDate = "from_date";
  static String endDate = "to_date";
  static String dateFormat = "yyyy-MM-dd";
  static String dateFormatYDM = "yyyy-dd-MM";
  static String dateDDMMYYYY = "dd/MM/yyyy";
  static String dateMMDDYYYY = "MM/dd/yyyy";
  static String dateFormatWithHour = "yyyy-MM-dd HH:mm:ss";
  static String uniqueId = "unique_id";
  static String orderId = "order_id";
  static String bpIdW = "bp_id_w";
  static String storeId = 'store_id';
  static String clId = 'cl_id';
  static String orderDescription = 'order_description';
  static String productDetails = 'product_details';
  static String promoCode = 'promocode';
  static String dateOfTransaction = 'date_of_transaction';
  static String itemsQty = 'items_qty';
  static String subTotal = 'sub_total';
  static String taxSum = 'tax_sum';
  static String total = 'total';
  static String deliveryMethod = 'delivery_method';
  static String shippingCost = 'shipping_cost';
  static String grandTotal = 'grand_total';
  static String paymentMethod = 'payment_method';
  static String clAvailability = 'cl_availability';
  static String orderType = 'order_type';
  static String qty = 'qty';
  static String productId = 'product_id';
  static String productDescription = 'product_description';
  static String unitPrice = 'unit_price';
  static String currency = 'currency';
  static String unit = 'unit';
  static String tax = 'tax';
  static String amount = 'amount';
  static String amountIsBigger = "amount_is_bigger";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String email = "email";
  static String idType = "id_type";
  static String idDocument = "id_document";
  static String storeIds = "store_ids";
  static String roles = "roles";
  static String status = "status";
  static String bingo = "Bingo";
  static List<String> routeType = [
    "dynamic_routes_changed",
    "static_routes_changed",
    "sales_zone_changed",
    "todo_list_changed"
  ];
  static final key = encrypt.Key.fromUtf8('ymQpRhvKirc8o2SbLwUWFmNxebdK27dU');
  static final iv = encrypt.IV.fromUtf8('ymQpRhvKirc8o2Sb');
}
