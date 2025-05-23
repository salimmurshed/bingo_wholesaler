class ExpectedDataTypeApiResponse {
  static String addSaleDataType =
      ({"success": bool, "message": String, "data": String}).toString();

  // static String saleList={'success': 'bool', 'message': 'String', 'data': {'current_page': 'int', 'items': [{'url': 'String', 'label': 'String', 'active': 'bool'},
  //   {'url': 'String', 'label': 'String', 'active': 'bool'}, {'url': 'String', 'label': 'String', active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}, {url: String, label: String, active: bool}], first_page_url: String, from: int, last_page: int, last_page_url: String, next_page_url: String, path: String, per_page: String, prev_page_url: String, to: int, total: int}}

  static Map<String, dynamic> saleList = {
    'unique_id': 'String',
    'app_unique_id': 'String',
    'invoice_number': 'String',
    'order_number': 'String',
    'sale_date': 'String',
    'due_date': 'String',
    'currency': 'String',
    'sale_type': 'String',
    'amount': 'String',
    'bingo_order_id': 'String',
    'status': 'int',
    'description': 'String',
    'retailer_name': 'String',
    'wholesaler_name': 'String',
    'fie_name': 'String',
    'wholesaler_temp_tx_address': 'String',
    'retailer_temp_tx_address': 'String',
    'wholesaler_store_id': 'String',
    'bp_id_r': 'String',
    'store_id': 'String',
    'status_description': 'String',
    'is_start_payment': 'int',
    'balance': 'String',
    'is_app_unique_id': 'String',
    'action': 'String',
    'total_owed': 'String'
  };
  static Map<String, dynamic> paginationDataResponse = {
    'success': 'bool',
    'message': 'String',
    'data': {
      'current_page': 'int',
      'data': 'List<dynamic>',
      'first_page_url': 'String',
      'from': 'int',
      'last_page': 'int',
      'last_page_url': 'String',
      'links': 'List<dynamic>',
      'next_page_url': 'String',
      'path': 'String',
      'per_page': 'int',
      'prev_page_url': 'String',
      'to': 'int',
      'total': 'int'
    }
  };

  static Map<String, dynamic> saleDataDetails = {
    "available_amount": 'String',
    "retailer_name": 'String',
    "fie_name": 'String',
    "date_of_invoice": 'String',
    "due_date": 'String',
    "currency": 'String',
    "amount": 'String',
    "invoice_number": 'String',
    "order_number": 'String',
    "reserved_amount": 'String',
    "bingo_store_id": 'String',
    "wholesaler_store_id": 'String',
    "sales_step": 'String',
    "description": 'String',
    "status": 'int',
    "status_description": 'String',
    "sub_sales": 'List<dynamic>'
  };
  static Map<String, dynamic> saleDetailsRetailer = {
    "wholesaler_name": "String",
    "fie_name": "String",
    "sale_date": "String",
    "due_date": "String",
    "currency": "String",
    "amount": "String",
    "invoice_number": "String",
    "order_number": "String",
    "bingo_store_id": "String",
    "sales_step": "String",
    "description": "String",
    "status": "int",
    "status_description": "String",
    "is_start_payment": "int",
    "tranction_details": "List<dynamic>"
  };
  static Map<String, dynamic> saleDetailsTransactionRetailer = {
    "sale_unique_id": "String",
    "invoice": "String",
    "currency": "String",
    "document_type": "String",
    "document_id": "String",
    "posting_date": "String",
    "store_name": "String",
    "retailer_name": "String",
    "status": "int",
    "date_generated": "String",
    "due_date": "String",
    "amount": "String",
    "open_balance": "String",
    "applied_amount": "String",
    "status_description": "String",
    "contract_account": "String"
  };

  static Map<String, dynamic> retailerAssociationList = {
    "unique_id": "String",
    "association_unique_id": "String",
    "wholesaler_name": "String",
    "phone_number": "String",
    "id": "String",
    "email": "String",
    "status": "String",
    "status_fie": "String"
  };
  static Map<String, dynamic> retailerAssociationListDetails = {
    "company_information": {
      "unique_id": "String",
      "bp_id_w": "String",
      "company_name": "String",
      "tax_id": "String",
      "association_date": "String",
      "company_address": "String",
      "status": "String",
      "status_fie": "String"
    },
    "contact_information": {
      "first_name": "String",
      "last_name": "String",
      "id": "String",
      "phone_number": "String",
      "company_document": "List<dynamic>"
    }
  };

  static Map<String, dynamic> retailerFieAssociationList = {
    "unique_id": "String",
    "fie_name": "String",
    "phone_number": "String",
    "id": "String",
    "email": "String",
    "status": "String",
    "status_fie": "String"
  };
  static Map<String, dynamic> retailerFieAssociationListDetails = {
    "company_information": {
      "unique_id": "String",
      "bp_id_f": "String",
      "company_name": "String",
      "tax_id": "String",
      "association_date": "String",
      "company_address": "String",
      "status": "String",
      "status_fie": "String"
    },
    "contact_information": {
      "first_name": "String",
      "last_name": "String",
      "id": "String",
      "phone_number": "String",
      "company_document": "List<dynamic>"
    }
  };
  static Map<String, dynamic> retailerSettingUserList = {
    "id": "int",
    "unique_id": "String",
    "temp_tx_address": "String",
    "first_name": "String",
    "last_name": "String",
    "email": "String",
    "employee_id": "String",
    "id_type": "String",
    "id_number": "String",
    "tax_id": "String",
    "retailer_store_id": "String",
    "role": "String",
    "sales_team": "String",
    "doc_id": "String",
    "branches": "String",
    "seller": "String",
    "country": "String",
    "is_master": "int",
    "status": "int",
    "master_email": "String",
    "created_by": "String",
    "created_at": "String",
    "updated_at": "String",
    "adderss": "String",
    "profile_image": "String",
    "role_id": "String",
    "is_password_changed": "String",
    "language_code": "String",
    "mobile_app_pin": "String",
    "store_name_list": "String",
    "status_description": "String"
  };
  static Map<String, dynamic> retailerSettingRoleList = {
    "unique_id": "String",
    "role_name": "String",
    "role_description": "String",
    "is_status": "int",
    "created_at": "String",
    "status_description": "String"
  };
  static Map<String, dynamic> retailerSettingStoreList = {
    "unique_id": "String",
    "name": "String",
    "city": "String",
    "address": "String",
    "remarks": "String",
    "status": "String",
    "country": "String",
    "store_logo": "String",
    "sign_board_photo": "String"
  };

  static Map<String, dynamic> retailerSettingBankAccountList = {
    "unique_id": "String",
    "bank_account_type": "int",
    "currency": "String",
    "bank_account_number": "String",
    "iban": "String",
    "updated_at": "String",
    "fie_id": "String",
    "fie_name": "String",
    "status": "int",
    "updated_at_date": "String",
    "status_description": "String",
    "bank_account_type_description": "String"
  };
  static Map<String, dynamic> retailerSettingCompanyAccountList = {
    'commercial_name': 'String',
    'main_products': 'String',
    'date_founded': 'String',
    'website_url': 'String',
    'about_us': 'String',
    'information': 'String',
    'logo': 'String'
  };
  static Map<String, dynamic> retailerAccountBalanceList = {
    "unique_id": "String",
    "bank_account_type": "int",
    "currency": "String",
    "bank_account_number": "String",
    "iban": "String",
    "updated_at": "String",
    "fie_id": "String",
    "fie_name": "String",
    "status": "int",
    "balance": "String",
    "bank_name": "String",
    "date": "String",
    "status_description": "String",
    "bank_account_type_description": "String"
  };
  static Map<String, dynamic> retailerOrderList = {
    "unique_id": "String",
    "grand_total": "String",
    "delivery_date": "String",
    "date_of_transaction": "String",
    "status": "int",
    "order_type": "int",
    "RetailerName": "String",
    "WholesalerName": "String",
    "storeName": "String",
    "currency": "String",
    "wholesaler_unique_id": "String",
    "store_unique_id": "String",
    "sales_id": "String",
    "status_description": "String",
    "order_type_description": "String"
  };
  static Map<String, dynamic> retailerOrderDetails = {
    "unique_id": "String",
    "bp_id_r": "String",
    "retailer_name": "String",
    "bp_id_w": "String",
    "wholesaler_name": "String",
    "cl_id": "String",
    "store_id": "String",
    "store_name": "String",
    "order_description": "String",
    "date_of_transaction": "String",
    "promocode": "String",
    "items_qty": "int",
    "sub_total": "double",
    "total_tax": "double",
    "total": "double",
    "delivery_date": "String",
    "delivery_method_id": "String",
    "delivery_method_name": "String",
    "delivery_method_description": "String",
    "shipping_cost": "int",
    "grand_total": "double",
    "payment_method_id": "int",
    "payment_method_name": "String",
    "country": "String",
    "status": "int",
    "status_description": "String",
    "order_type": "int",
    "order_type_description": "String",
    "is_cl_increase": "int",
    "creditline_currency": "String",
    "creditline_status": "int",
    "creditline_status_description": "String",
    "creditline_available_amount": "double",
    "order_logs": "List<dynamic>"
  };
  static Map<String, dynamic> retailerOrderDetailsOrderLogs = {
    "unique_id": "String",
    "product_id": "String",
    "sku": "String",
    "product_description": "String",
    "unit_price": "int",
    "currency": "String",
    "qty": "int",
    "unit": "String",
    "tax": "double",
    "amount": "double",
    "country": "String"
  };

  static Map<String, dynamic> wholesalerListWithDetails = {
    "unique_id": "String",
    "wholesaler_name": "String",
    "company_name": "String",
    "phone_number": "String",
    "tax_id": "String",
    "status": "String",
    "bp_email": "String",
    "association_date": "String",
    "address": "String",
    "latitude": "String",
    "longitude": "String",
    "first_name": "String",
    "last_name": "String",
    "position": "String",
    "contact_id": "String",
    "contact_phone_number": "String",
    "supported_documents": "String",
    "bp_company_logo_url": "String",
    "temp_tx_address": "String"
  };
  static Map<String, dynamic> fieListWithDetails = {
    "unique_id": "String",
    "fie_name": "String",
    "company_name": "String",
    "phone_number": "String",
    "tax_id": "String",
    "status": "String",
    "bp_email": "String",
    "association_date": "String",
    "address": "String",
    "latitude": "String",
    "longitude": "String",
    "first_name": "String",
    "last_name": "String",
    "position": "String",
    "contact_id": "String",
    "contact_phone_number": "String",
    "supported_documents": "String"
  };

  static Map<String, dynamic> financeCreditlineList = {
    "status_description": "String",
    "unique_id": "String",
    "internal_id": "String",
    "wholesaler_name": "String",
    "retailer_name": "String",
    "fie_name": "String",
    "approved_amount": "String",
    "approved_date": "String",
    "expiration_date": "String",
    "remaining_days": "int",
    "current_balance": "String",
    "amount_available": "String",
    "utilization": "String",
    "status": "int",
    "currency": "String",
    "minimum_commitment_date": "String",
    "bank_name": "String",
    "bank_account_number": "String",
    "remain_amount": "String",
    "effective_date": "String",
    "country": "String",
    "timezone": "String",
    "creditline_documents": "List<dynamic>",
    "retailer_store_details": "List<dynamic>"
    // {
    //   "id": 36487,
    //   "unique_id": "17175070486j7NJEnfQPjguidTFsdo4EU9sHyME1pBGrhrzyO4yU",
    //   "sale_unique_id": "171750701736OJSFuzRkg9ccLUfOSEj0YENuUs3yWfSgiSDcizn9",
    //   "settlement_unique_id": null,
    //   "credit_line_id": 159,
    //   "document_type_unique_id": "17175070486j7NJEnfQPjguidTFsdo4EU9sHyME1pBGrhrzyO4yU",
    //   "enrollment_type": "Retailer",
    //   "bp_id": 269,
    //   "invoice": "WD_CA_FE_INV_001",
    //   "open_balance": 10,
    //   "amount": 10,
    //   "date_generated": "2024-06-04 09:17:28",
    //   "due_date": "2024-06-13 23:59:59",
    //   "status": 2,
    //   "is_block": 0,
    //   "advance_payment": 1,
    //   "country": "Dominican Republic",
    //   "created_at": "2024-06-04T13:17:28.000000Z",
    //   "updated_at": "2024-06-14T23:55:32.000000Z",
    //   "document_type": "Sale",
    //   "sale_id": 1022,
    //   "creditLineId": "134859964216",
    //   "bp_name": null,
    //   "temp_tx_address": null,
    //   "currency": "DOP",
    //   "store_name": "Colmado Alcantara",
    //   "store_id": 115
    // }
    // {
    //   "id": 115,
    //   "unique_id": "1696444849vMABjfxSDDsNI8MY82nMTqp1Uyk93LjKvfesbiGzTL",
    //   "retailler_id": 269,
    //   "name": "Colmado Alcantara",
    //   "city": "Consuelo",
    //   "address": "G5GG+X8V, Manuel de Jesus Viñas Caceres, Santo Domingo Este, Santo Domingo Este, Santo Domingo",
    //   "cordinate": null,
    //   "remark": "Remark",
    //   "bank_account": null,
    //   "irn_no": null,
    //   "store_logo": "store_logo/3117269.jpeg",
    //   "country": "Dominican Republic",
    //   "website": null,
    //   "preffered_bank": null,
    //   "lattitude": "0.0",
    //   "longitude": "0.0",
    //   "sign_board_photo": "retailer_sign_board_photo/4780269.jpeg",
    //   "status": "Active",
    //   "date": "2023-10-19 04:02:37",
    //   "created_at": "2023-10-04T18:40:49.000000Z",
    //   "updated_at": "2023-10-19T04:02:37.000000Z",
    //   "amount": 200000000,
    //   "consumed_amount": 10,
    //   "effective_date": "2024-06-04 04:00:00",
    //   "r_cl_id": 269,
    //   "cl_id": 159,
    //   "new_assignment": 0,
    //   "retailer_id": "0xKtW0NgQSpQIt3fScQ3aWiDmGuLmA07HPKamtW1hPQf"
    // },
  };

  static Map<String, dynamic> financeStatementList = {
    "document_id": "String",
    "sale_unique_id": "String",
    "enrollment_type": "String",
    "date_generated": "String",
    "document_type": "String",
    "due_date": "String",
    "sale_id": "String",
    "creditLineId": "String",
    "invoice": "String",
    "amount": "String",
    "status": "int",
    "wholesaler_name": "String",
    "bp_id_w": "String",
    "currency": "String",
    "total_balance": "String",
    "open_balance": "String",
    "total_amount": "String",
    "store_name": "String",
    "status_description": "String",
    "contract_account": "String",
    "documents_count": "String"
  };

  static Map<String, dynamic> financeSettlementList = {
    'posting_date': '',
    'lot_id': 'lotId',
    'currency': 'currency',
    'amount': 'amount',
    'status': 'status',
    'status_description': 'statusDescription'
  };
}
