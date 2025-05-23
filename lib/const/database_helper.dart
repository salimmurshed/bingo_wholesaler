import 'dart:convert';
import 'dart:io';

import '/services/local_data/table_names.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "bingo_database_36.db";
  final _databaseVersion = 36;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  factory DatabaseHelper() => instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database?> initDatabase() async {
    if (!kIsWeb) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      return await openDatabase(path,
          version: _databaseVersion, onCreate: onCreate);
    }
    return null;
  }

  Future onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE ${TableNames.countryTableName} ("
        "${DataBaseHelperKeys.id} INTEGER ,"
        "${DataBaseHelperKeys.country} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.timezone} TEXT NOT NULL,"
        "${DataBaseHelperKeys.glId} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.date} TEXT NOT NULL,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.branchLegal} TEXT NOT NULL,"
        "${DataBaseHelperKeys.address} TEXT NOT NULL,"
        "${DataBaseHelperKeys.taxid} TEXT NOT NULL,"
        "${DataBaseHelperKeys.taxIdType} TEXT NOT NULL,"
        "${DataBaseHelperKeys.countryCode} TEXT NOT NULL,"
        "${DataBaseHelperKeys.language} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.storeTableName}("
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.name} TEXT NOT NULL,"
        "${DataBaseHelperKeys.city} TEXT NOT NULL,"
        "${DataBaseHelperKeys.country} TEXT NOT NULL,"
        "${DataBaseHelperKeys.address} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.remarks} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.storeLogo} TEXT NOT NULL,"
        "${DataBaseHelperKeys.signBoardPhoto} TEXT NOT NULL,"
        "${DataBaseHelperKeys.lattitude} TEXT NOT NULL,"
        "${DataBaseHelperKeys.longitude} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.wholesalerList}("
        "${DataBaseHelperKeys.id} INTEGER ,"
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.name} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.fiaList}("
        "${DataBaseHelperKeys.id} INTEGER,"
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.name} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.retailerAssociationList}("
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.id} TEXT NOT NULL,"
        "${DataBaseHelperKeys.email} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.statusFie} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.retailerFieAssociationList}("
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.id} TEXT NOT NULL,"
        "${DataBaseHelperKeys.email} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.statusFie} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.wholeSalerAssociationList}("
        "${DataBaseHelperKeys.uniqueId} TEXT  PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.retailerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.id} TEXT NOT NULL,"
        "${DataBaseHelperKeys.email} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.retailerCreditlineRequestList}("
        "${DataBaseHelperKeys.creditlineUniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.type} TEXT NOT NULL,"
        "${DataBaseHelperKeys.dateRequested} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} INT NOT NULL,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.fieUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.requestedAmount} TEXT NOT NULL,"
        "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.fieFistForCreditlineRequest}("
        "${DataBaseHelperKeys.id} INTEGER KEY,"
        "${DataBaseHelperKeys.fieUniqueId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.bpName} TEXT NOT NULL"
        ")");
    await db
        .execute("CREATE TABLE ${TableNames.wholesalerCreditlineRequestList}("
            "${DataBaseHelperKeys.id} INTEGER PRIMARY KEY NOT NULL,"
            "${DataBaseHelperKeys.uniqueId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.associationId} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.fieId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.bpIdF} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.bpIdR} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.monthlyPurchase} TEXT NOT NULL,"
            "${DataBaseHelperKeys.averagePurchaseTickets} TEXT NOT NULL,"
            "${DataBaseHelperKeys.requestedAmount} TEXT NOT NULL,"
            "${DataBaseHelperKeys.customerSinceDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.monthlySales} TEXT NOT NULL,"
            "${DataBaseHelperKeys.averageSalesTicket} TEXT NOT NULL,"
            "${DataBaseHelperKeys.rcCrlineAmt} TEXT NOT NULL,"
            "${DataBaseHelperKeys.visitFrequency} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.creditOfficerGroup} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialName1} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialPhone1} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialName2} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialPhone2} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialName3} TEXT NOT NULL,"
            "${DataBaseHelperKeys.commercialPhone3} TEXT NOT NULL,"
            "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
            "${DataBaseHelperKeys.financialStatements} TEXT NOT NULL,"
            "${DataBaseHelperKeys.status} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.country} TEXT NOT NULL,"
            "${DataBaseHelperKeys.statusFie} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.approvedCreditLineAmount} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.approvedCreditLineCurrency} TEXT NOT NULL,"
            "${DataBaseHelperKeys.clInternalId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.startDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.expirationDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.clApprovedDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.clType} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.isForward} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.actionBy} TEXT NOT NULL,"
            "${DataBaseHelperKeys.actionEnrollement} TEXT NOT NULL,"
            "${DataBaseHelperKeys.authorizationDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.isFieRespond} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.type} TEXT NOT NULL,"
            "${DataBaseHelperKeys.parentClId} INTEGER NOT NULL,"
            "${DataBaseHelperKeys.createdAt} TEXT NOT NULL,"
            "${DataBaseHelperKeys.updatedAt} TEXT NOT NULL,"
            "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
            "${DataBaseHelperKeys.retailerName} TEXT NOT NULL,"
            "${DataBaseHelperKeys.fieUniqueId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.wholesalerUniqueId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL,"
            "${DataBaseHelperKeys.dateRequested} TEXT NOT NULL"
            ")");

    await db.execute("CREATE TABLE ${TableNames.retailerList}("
        "${DataBaseHelperKeys.bpIdR} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.internalId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.associationUniqueId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.retailerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.hasActiveCreditline} INT,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.storeList}("
        "${DataBaseHelperKeys.storeId} TEXT PRIMARY KEY NOT NULL,"
        "${DataBaseHelperKeys.wholesalerStoreId} TEXT,"
        "${DataBaseHelperKeys.name} TEXT NOT NULL,"
        "${DataBaseHelperKeys.city} TEXT NOT NULL,"
        "${DataBaseHelperKeys.address} TEXT NOT NULL,"
        "${DataBaseHelperKeys.associationIdStore} TEXT NOT NULL,"
        "${DataBaseHelperKeys.saleType} TEXT NOT NULL,"
        "${DataBaseHelperKeys.creditlineId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.approvedCreditLineCurrency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.availableAmount} NUMBER NOT NULL"
        ")");
    await db.execute("CREATE TABLE ${TableNames.createTemSales}("
        "${DataBaseHelperKeys.id}  INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${DataBaseHelperKeys.uniqueId} TEXT,"
        "${DataBaseHelperKeys.invoiceNumber} TEXT,"
        "${DataBaseHelperKeys.totalOwed} TEXT,"
        "${DataBaseHelperKeys.bpIdR} TEXT,"
        "${DataBaseHelperKeys.storeId} TEXT,"
        "${DataBaseHelperKeys.saleType} TEXT,"
        "${DataBaseHelperKeys.orderNumber} TEXT,"
        "${DataBaseHelperKeys.saleDate} TEXT NOT NULL,"
        "${DataBaseHelperKeys.dueDate} TEXT,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.amount} TEXT NOT NULL,"
        "${DataBaseHelperKeys.bingoOrderId} TEXT,"
        "${DataBaseHelperKeys.status} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.description} TEXT ,"
        "${DataBaseHelperKeys.retailerName} TEXT,"
        "${DataBaseHelperKeys.wholesalerName} TEXT,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerTempTxAddress} TEXT NOT NULL,"
        "${DataBaseHelperKeys.retailerTempTxAddress} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerStoreId} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL,"
        "${DataBaseHelperKeys.isStartPayment} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.balance} TEXT,"
        "${DataBaseHelperKeys.appUniqueId} TEXT ,"
        "${DataBaseHelperKeys.isAppUniqId} TEXT,"
        "${DataBaseHelperKeys.action} TEXT"
        ")");
    await db.execute("CREATE TABLE ${TableNames.retailerBankAccounts}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.status} int NOT NULL,"
        "${DataBaseHelperKeys.bankAccountType} int NOT NULL,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.bankAccountNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.iban} TEXT NOT NULL,"
        "${DataBaseHelperKeys.updatedAt} TEXT NOT NULL,"
        "${DataBaseHelperKeys.fieId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL,"
        "${DataBaseHelperKeys.updatedAtDate} TEXT NOT NULL,"
        "${DataBaseHelperKeys.bankAccountTypeDescription} TEXT NOT NULL"
        ")");

    await db.execute("CREATE TABLE ${TableNames.salesList}("
        "${DataBaseHelperKeys.uniqueId} TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.invoiceNumber} TEXT,"
        "${DataBaseHelperKeys.totalOwed} TEXT,"
        "${DataBaseHelperKeys.bpIdR} TEXT,"
        "${DataBaseHelperKeys.storeId} TEXT,"
        "${DataBaseHelperKeys.saleType} TEXT,"
        "${DataBaseHelperKeys.orderNumber} TEXT,"
        "${DataBaseHelperKeys.saleDate} TEXT NOT NULL,"
        "${DataBaseHelperKeys.dueDate} TEXT,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.amount} TEXT NOT NULL,"
        "${DataBaseHelperKeys.bingoOrderId} TEXT,"
        "${DataBaseHelperKeys.status} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.description} TEXT ,"
        "${DataBaseHelperKeys.retailerName} TEXT,"
        "${DataBaseHelperKeys.wholesalerName} TEXT,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerTempTxAddress} TEXT,"
        "${DataBaseHelperKeys.retailerTempTxAddress} TEXT,"
        "${DataBaseHelperKeys.wholesalerStoreId} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL,"
        "${DataBaseHelperKeys.isStartPayment} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.balance} TEXT,"
        "${DataBaseHelperKeys.appUniqueId} TEXT ,"
        "${DataBaseHelperKeys.isAppUniqId} TEXT,"
        "${DataBaseHelperKeys.action} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.customerList}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.retailerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.taxId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.email} TEXT NOT NULL,"
        "${DataBaseHelperKeys.retailerEmail} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.tempTxAddress} TEXT NOT NULL,"
        "${DataBaseHelperKeys.wholesalerName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.customerSinceDate} TEXT NOT NULL"
        ")");
    await db
        .execute("CREATE TABLE ${TableNames.retailerAssociatedWholesalerList}("
            "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
            "${DataBaseHelperKeys.wholesalerName} TEXT NOT NULL,"
            "${DataBaseHelperKeys.companyName} TEXT NOT NULL,"
            "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
            "${DataBaseHelperKeys.taxId} TEXT NOT NULL,"
            "${DataBaseHelperKeys.status} TEXT NOT NULL,"
            "${DataBaseHelperKeys.bpEmail} TEXT NOT NULL,"
            "${DataBaseHelperKeys.associationDate} TEXT NOT NULL,"
            "${DataBaseHelperKeys.address} TEXT NOT NULL,"
            "${DataBaseHelperKeys.latitude} TEXT NOT NULL,"
            "${DataBaseHelperKeys.longitude} TEXT NOT NULL,"
            "${DataBaseHelperKeys.firstName} TEXT ,"
            "${DataBaseHelperKeys.lastName} TEXT ,"
            "${DataBaseHelperKeys.position} TEXT ,"
            "${DataBaseHelperKeys.contactId} TEXT ,"
            "${DataBaseHelperKeys.contactPhoneNumber} TEXT ,"
            "${DataBaseHelperKeys.supportedDocuments} TEXT ,"
            "${DataBaseHelperKeys.bpCompanyLogoUrl} TEXT, "
            "${DataBaseHelperKeys.tempTxAddress} TEXT "
            ")");

    await db.execute("CREATE TABLE ${TableNames.retailerAssociatedFieList}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.fieName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.companyName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.phoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.taxId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} TEXT NOT NULL,"
        "${DataBaseHelperKeys.bpEmail} TEXT NOT NULL,"
        "${DataBaseHelperKeys.associationDate} TEXT NOT NULL,"
        "${DataBaseHelperKeys.address} TEXT NOT NULL,"
        "${DataBaseHelperKeys.latitude} TEXT NOT NULL,"
        "${DataBaseHelperKeys.longitude} TEXT NOT NULL,"
        "${DataBaseHelperKeys.firstName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.lastName} TEXT NOT NULL,"
        "${DataBaseHelperKeys.position} TEXT NOT NULL,"
        "${DataBaseHelperKeys.contactId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.contactPhoneNumber} TEXT NOT NULL,"
        "${DataBaseHelperKeys.supportedDocuments} TEXT NOT NULL"
        ")");

    await db.execute("CREATE TABLE ${TableNames.retailerSettlementList}("
        "${DataBaseHelperKeys.postingDate}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.lotId} TEXT NOT NULL,"
        "${DataBaseHelperKeys.currency} TEXT NOT NULL,"
        "${DataBaseHelperKeys.amount} TEXT NOT NULL,"
        "${DataBaseHelperKeys.status} INTEGER NOT NULL,"
        "${DataBaseHelperKeys.statusDescription} TEXT NOT NULL"
        ")");

    await db.execute("CREATE TABLE ${TableNames.allLoggedUsers}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.email} TEXT not null,"
        "${DataBaseHelperKeys.firstName} TEXT not null,"
        "${DataBaseHelperKeys.lastName} TEXT,"
        "${DataBaseHelperKeys.profileImage} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.dynamicRoutes}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.description} TEXT not null,"
        "${DataBaseHelperKeys.routeId} TEXT not null,"
        "${DataBaseHelperKeys.date} TEXT,"
        "${DataBaseHelperKeys.createdAt} TEXT,"
        "${DataBaseHelperKeys.status} TEXT,"
        "${DataBaseHelperKeys.updatedDate} TEXT,"
        "${DataBaseHelperKeys.retailersCount} TEXT,"
        "${DataBaseHelperKeys.storesCount} TEXT,"
        "${DataBaseHelperKeys.assignToo} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.staticRoutes}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.description} TEXT not null,"
        "${DataBaseHelperKeys.routeId} TEXT not null,"
        "${DataBaseHelperKeys.salesId} TEXT,"
        "${DataBaseHelperKeys.salesStep} TEXT,"
        "${DataBaseHelperKeys.salesZoneName} TEXT,"
        "${DataBaseHelperKeys.date} TEXT,"
        "${DataBaseHelperKeys.createdAt} TEXT,"
        "${DataBaseHelperKeys.status} TEXT,"
        "${DataBaseHelperKeys.updatedDate} TEXT,"
        "${DataBaseHelperKeys.retailersCount} TEXT,"
        "${DataBaseHelperKeys.storesCount} TEXT,"
        "${DataBaseHelperKeys.assignToo} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.salesZone}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.salesId} TEXT not null,"
        "${DataBaseHelperKeys.salesZoneName} TEXT not null,"
        "${DataBaseHelperKeys.salesStep} TEXT,"
        "${DataBaseHelperKeys.status} TEXT,"
        "${DataBaseHelperKeys.assignToo} TEXT,"
        "${DataBaseHelperKeys.createdAt} TEXT,"
        "${DataBaseHelperKeys.retailersCount} TEXT,"
        "${DataBaseHelperKeys.storesCount} TEXT,"
        "${DataBaseHelperKeys.salesStepDescription} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.orderList}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.grandTotal} NUMBER,"
        "${DataBaseHelperKeys.deliveryDate} TEXT ,"
        "${DataBaseHelperKeys.dateOfTransaction} TEXT,"
        "${DataBaseHelperKeys.status} INT,"
        "${DataBaseHelperKeys.orderType} INT,"
        "${DataBaseHelperKeys.retailerName1} TEXT,"
        "${DataBaseHelperKeys.WholesalerName1} TEXT,"
        "${DataBaseHelperKeys.storeName} TEXT,"
        "${DataBaseHelperKeys.currency} TEXT,"
        "${DataBaseHelperKeys.salesId} TEXT,"
        "${DataBaseHelperKeys.wholesalerUniqueId} TEXT,"
        "${DataBaseHelperKeys.storeUniqueId} TEXT,"
        "${DataBaseHelperKeys.statusDescription} TEXT,"
        "${DataBaseHelperKeys.orderTypeDescription} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.notificationList}("
        "${DataBaseHelperKeys.uniqueId}  TEXT PRIMARY KEY,"
        "${DataBaseHelperKeys.message} TEXT,"
        "${DataBaseHelperKeys.generatedDate} TEXT ,"
        "${DataBaseHelperKeys.isRead} INT,"
        "${DataBaseHelperKeys.targetUniqueId} TEXT,"
        "${DataBaseHelperKeys.notificationType} INT,"
        "${DataBaseHelperKeys.notificationCategory} INT,"
        "${DataBaseHelperKeys.readStatus} TEXT"
        ")");

    await db.execute("CREATE TABLE ${TableNames.notificationCounter}("
        "${DataBaseHelperKeys.count} INTEGER"
        ")");
  }

  Future<int> insert(tableName, tableData) async {
    Database db = await instance.database;
    return await db.insert(tableName, jsonDecode(tableData),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void delete(tableName) async {
    Database db = await instance.database;
    await db.delete(tableName);
  }

  Future deleteDB() async {
    Database db = await instance.database;
    await db.delete(TableNames.countryTableName);
    await db.delete(TableNames.fiaList);
    await db.delete(TableNames.retailerAssociationList);
    await db.delete(TableNames.storeTableName);
    await db.delete(TableNames.wholeSalerAssociationList);
    await db.delete(TableNames.wholesalerList);
    await db.delete(TableNames.retailerCreditlineRequestList);
    await db.delete(TableNames.fieFistForCreditlineRequest);
    await db.delete(TableNames.wholesalerCreditlineRequestList);
    await db.delete(TableNames.retailerList);
    await db.delete(TableNames.createTemSales);
    await db.delete(TableNames.retailerFieAssociationList);
    await db.delete(TableNames.storeList);
    await db.delete(TableNames.salesList);
    await db.delete(TableNames.retailerBankAccounts);
    await db.delete(TableNames.customerList);
    await db.delete(TableNames.retailerAssociatedWholesalerList);
    await db.delete(TableNames.retailerAssociatedFieList);
    await db.delete(TableNames.dynamicRoutes);
    await db.delete(TableNames.staticRoutes);
    await db.delete(TableNames.salesZone);
    await db.delete(TableNames.orderList);
    await db.delete(TableNames.notificationList);
    // await db.delete(TableNames.retailerApproveCreditlineRequest);
  }

  Future deleteRetailerDataForFilterSearch() async {
    Database db = await instance.database;
    await db.delete(TableNames.salesList);
    await db.delete(TableNames.wholesalerList);
    await db.delete(TableNames.retailerAssociatedFieList);
    await db.delete(TableNames.storeList);
  }

  Future deleteWholesalerDataForFilterSearch() async {
    Database db = await instance.database;
    await db.delete(TableNames.salesList);
    await db.delete(TableNames.customerList);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(tblName) async {
    Database db = await instance.database;
    return await db.query(tblName);
  }

  Future<int> deleteData(tblName, id) async {
    Database db = await instance.database;
    return await db.delete(tblName,
        where: '${DataBaseHelperKeys.uniqueId} = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsByGroup(
    tblName,
    order,
    group,
  ) async {
    Database db = await instance.database;
    return await db.query(tblName, orderBy: order
        // groupBy: group,
        );
  }

  Future<List<Map<String, dynamic>>> queryAllSortedRows(
      String tblName, String field, String? arg) async {
    Database db = await instance.database;
    return await db.query(tblName, where: '$field  = ?', whereArgs: [arg]);
  }

  Future<Map<String, dynamic>> queryAllSortedRowsSingle(
      String tblName, String field, dynamic? arg) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> p =
        (await db.query(tblName, where: '$field  = ?', whereArgs: [arg]));
    print(p);
    return p.last;
  }

  Future<Map<String, dynamic>> queryDataSingle(
      String tblName, String field) async {
    Database db = await instance.database;
    return (await db.query(tblName)).last;
  }

// Future<int?> queryRowCount() async {
//   Database db = await instance.database;
//   return Sqflite.firstIntValue(
//       await db.rawQuery('SELECT COUNT(*) FROM $countries'));
// }

// Future<int> update(Map<String, dynamic> row) async {
//   Database db = await instance.database;
//   int id = row['id'];
//   return await db.update(countries, row, where: '$id = ?', whereArgs: [id]);
// }

// Future<int> delete(int id) async {
//   Database db = await instance.database;
//   return await db.delete(countries, where: '$id = ?', whereArgs: [id]);
// }
}

class DataBaseHelperKeys {
  static String id = "id";
  static String count = "count";
  static String country = 'country';
  static String timezone = 'timezone';
  static String glId = "gl_id";
  static String status = "status";
  static String date = "date";
  static String currency = 'currency';
  static String branchLegal = 'branch_legal';
  static String address = 'address';
  static String taxid = 'taxid';
  static String taxId = 'tax_id';
  static String taxIdType = 'tax_id_type';
  static String countryCode = 'country_code';
  static String language = 'language';
  static String uniqueId = 'unique_id';
  static String name = 'name';
  static String city = 'city';
  static String remarks = 'remarks';
  static String associationUniqueId = 'association_unique_id';
  static String wholesalerName = 'wholesaler_name';
  static String WholesalerName1 = 'WholesalerName';
  static String companyName = 'company_name';
  static String tempTxAddress = 'temp_tx_address';
  static String retailerName = 'retailer_name';
  static String retailerName1 = 'RetailerName';
  static String approvedAmount = 'approved_amount';
  static String approvedDate = 'approved_date';
  static String remainingDays = 'remaining_days';
  static String currentBalance = 'current_balance';
  static String amountAvailable = 'amount_available';
  static String remainAmount = 'remain_amount';
  static String bankName = 'bank_name';
  static String phoneNumber = 'phone_number';
  static String email = 'email';
  static String retailerEmail = 'retailer_email';
  static String bpEmail = 'bp_email';
  static String associationDate = 'association_date';
  static String statusFie = 'status_fie';
  static String creditlineUniqueId = 'creditline_unique_id';
  static String type = 'type';
  static String dateRequested = 'date_requested';
  static String fieName = 'fie_name';
  static String fieUniqueId = 'fie_unique_id';
  static String wholesalerUniqueId = 'wholesaler_unique_id';
  static String storeUniqueId = 'store_unique_id';
  static String statusDescription = 'status_description';
  static String requestedAmount = 'requested_amount';
  static String updatedAtDate = 'updated_at_date';
  static String bankAccountTypeDescription = 'bank_account_type_description';
  static String bpName = 'bp_name';
  static String latitude = 'latitude';
  static String lattitude = 'lattitude';
  static String longitude = 'longitude';
  static String firstName = 'first_name';
  static String lastName = 'last_name';
  static String profileImage = 'profile_image';
  static String position = 'position';
  static String contactId = 'contact_id';
  static String contactPhoneNumber = 'contact_phone_number';
  static String supportedDocuments = 'supported_documents';
  static String bpCompanyLogoUrl = 'bp_company_logo_url';
  static String documents = 'documents';

  static String isOnline = 'is_online';

  // static String uniqueId = 'unique_id';
  static String associationId = 'association_id';
  static String fieId = 'fie_id';
  static String bpIdF = 'bp_id_f';
  static String bpIdR = 'bp_id_r';
  static String monthlyPurchase = 'monthly_purchase';
  static String averagePurchaseTickets = 'average_purchase_tickets';

  // static String requestedAmount = 'requested_amount';
  static String customerSinceDate = 'customer_since_date';
  static String monthlySales = 'monthly_sales';
  static String averageSalesTicket = 'average_sales_ticket';
  static String rcCrlineAmt = 'rc_crline_amt';
  static String visitFrequency = 'visit_frequency';
  static String creditOfficerGroup = 'credit_officer_group';
  static String commercialName1 = 'commercial_name_1';
  static String commercialPhone1 = 'commercial_phone_1';
  static String commercialName2 = 'commercial_name_2';
  static String commercialPhone2 = 'commercial_phone_2';
  static String commercialName3 = 'commercial_name_3';
  static String commercialPhone3 = 'commercial_phone_3';

  // static String currency = 'currency';
  static String financialStatements = 'financial_statements';

  // static String status = 'status';
  // static String country = 'country';
  // static String statusFie = 'status_fie';
  static String approvedCreditLineAmount = 'approved_credit_line_amount';
  static String approvedCreditLineCurrency = 'approved_credit_line_currency';
  static String clInternalId = 'cl_internal_id';
  static String startDate = 'start_date';
  static String expirationDate = 'expiration_date';
  static String clApprovedDate = 'cl_approved_date';
  static String clType = 'cl_type';
  static String isForward = 'is_forward';
  static String actionBy = 'action_by';
  static String actionEnrollement = 'action_enrollement';
  static String authorizationDate = 'authorization_date';
  static String isFieRespond = 'is_fie_respond';

  // static String type = 'type';
  static String parentClId = 'parent_cl_id';
  static String createdAt = 'created_at';
  static String updatedAt = 'updated_at';
  static String updatedDate = 'updated_date';
  static String internalId = 'internal_id';

  // static String associationUniqueId = 'association_unique_id';
  static String storeId = 'store_id';
  static String wholesalerStoreId = 'wholesaler_store_id';
  static String saleType = 'sale_type';
  static String salesStep = 'sales_step';
  static String invoiceNumber = 'invoice_number';
  static String totalOwed = 'total_owed';
  static String orderNumber = 'order_number';
  static String amount = 'amount';
  static String description = 'description';
  static String routeZone = 'w_route_zone_id';
  static String creditlineId = 'creditline_id';
  static String hasActiveCreditline = 'has_active_creditline';
  static String associationIdStore = 'associationId';
  static String availableAmount = 'available_amount';
  static String bankAccountType = 'bank_account_type';
  static String bankAccountNumber = 'bank_account_number';
  static String iban = 'iban';
  static String appUniqueId = 'app_unique_id';
  static String isAppUniqId = 'is_app_unique_id';
  static String action = 'action';
  static String tranctionDetails = 'tranction_details';
  static String isStartPayment = 'is_start_payment';

  static String saleDate = 'sale_date';
  static String dueDate = 'due_date';
  static String bingoOrderId = 'bingo_order_id';
  static String balance = 'balance';
  static String wholesalerTempTxAddress = 'wholesaler_temp_tx_address';
  static String retailerTempTxAddress = 'retailer_temp_tx_address';
  static String storeLogo = 'store_logo';
  static String signBoardPhoto = 'sign_board_photo';

  static String averagePurchasePerMonth = 'average_purchase_per_month';
  static String consumedAmount = 'consumed_amount';
  static String parentCrId = 'parent_cr_id';
  static String bankAccountId = 'bank_account_id';
  static String minimumCommitmentDate = 'minimum_commitment_date';
  static String invoiceId = 'invoice_id';
  static String financialEntriesUniqueId = 'financial_entries_unique_id';
  static String clOperationalStatus = 'cl_operational_status';

  static String postingDate = 'posting_date';
  static String lotId = 'lot_id';
  static String routeId = 'route_id';
  static String retailersCount = 'retailers_count';
  static String storesCount = 'stores_count';
  static String assignToo = 'assign_to';
  static String salesId = "sales_id";
  static String salesZoneName = "sales_zone_name";
  static String salesStepDescription = "sales_step_description";
  static String grandTotal = "grand_total";
  static String deliveryDate = "delivery_date";
  static String dateOfTransaction = "date_of_transaction";
  static String orderType = "order_type";
  static String storeName = "storeName";
  static String orderTypeDescription = "order_type_description";
  static String message = "message";
  static String generatedDate = "generated_date";
  static String isRead = "is_read";
  static String targetUniqueId = "target_unique_id";
  static String notificationType = "notification_type";
  static String notificationCategory = "notification_category";
  static String readStatus = "read_status";
}
