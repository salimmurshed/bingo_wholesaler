import 'dart:convert';

import '/data_models/models/all_order_model/all_order_model.dart';
import 'package:flutter/foundation.dart';
import '/data_models/models/all_order_model/all_order_model.dart';
import 'package:injectable/injectable.dart';

import '../../const/database_helper.dart';

@lazySingleton
class LocalData {
  LocalData() {
    if (!kIsWeb) {
      dbHelper.database;
    }
  }

  final dbHelper = DatabaseHelper.instance;

  Future<void> insert(
    tableName,
    tableData,
  ) async {
    for (int i = 0; i < tableData.length; i++) {
      var id = await dbHelper.insert(tableName, jsonEncode(tableData[i]));
      debugPrint(id.toString());
    }
  }

  void insertSingleData(tableName, tableData) async {
    var id = await dbHelper.insert(tableName, jsonEncode(tableData));
    debugPrint(id.toString());
  }

  Future<int> insertSingleDataSales(tableName, tableData) async {
    var id = await dbHelper.insert(tableName, jsonEncode(tableData));
    debugPrint(id.toString());
    return id;
  }

  Future deleteDB() async {
    await dbHelper.deleteDB();
  }

  Future deleteRetailerDataForFilterSearch() async {
    await dbHelper.deleteRetailerDataForFilterSearch();
  }

  Future deleteWholesalerDataForFilterSearch() async {
    await dbHelper.deleteWholesalerDataForFilterSearch();
  }

  void delete(tableName) async {
    dbHelper.delete(tableName);
  }
}
