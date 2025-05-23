import '../../models/all_sales_model/all_sales_model.dart';

class SaleEditData {
  AllSalesData allSalesData;
  SaleEditScreens saleEditScreens;
  String? routeZoneId;

  SaleEditData(
      {required this.allSalesData,
      required this.saleEditScreens,
      this.routeZoneId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allSalesData'] = allSalesData;
    data['saleEditScreens'] = saleEditScreens;
    data['routeZoneId'] = routeZoneId;
    return data;
  }
}

enum SaleEditScreens { saleList, today }
