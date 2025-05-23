import 'dart:convert';

import '../../const/app_extensions/make_double.dart';

var data = jsonEncode(
  [
    {
      "product_id": "162608980210LGkW61y96rCkjNJ2XJiuWzajW6UonVszNS2Mh0gV",
      "sku": "IDK-2032",
      "product_description": "This Is a Coca Cola Six Pack",
      "unit_price": 45,
      "currency": "usd",
      "unit": "Liter",
      "tax": 8.1
    },
    {
      "product_id": "1626158275POPcpl2NPB2LEfE2KHiLKFcRUsfnBmZa7vRW1Bsp1r",
      "sku": "IDK-2033",
      "product_description": "This Is a Coca Cola seaven Pack",
      "unit_price": 50,
      "currency": "USD",
      "unit": "Liters",
      "tax": 7.5
    }
  ],
);

class ProductModel {
  String? productId;
  String? sku;
  String? productDescription;
  int? unitPrice;
  String? currency;
  String? unit;
  double? tax;

  ProductModel(
      {this.productId,
      this.sku,
      this.productDescription,
      this.unitPrice,
      this.currency,
      this.unit,
      this.tax});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    sku = json['sku'];
    productDescription = json['product_description'];
    unitPrice = json['unit_price'];
    currency = json['currency'];
    unit = json['unit'];
    tax = json['tax'];
  }

  static List<ProductModel> toJsonList(List list) {
    return list.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
  }

  // static List<ProductModel> fromJsonList(jsonList) {
  //   return jsonList
  //       .map<visitedPlaceModel>((obj) => visitedPlaceModel.fromJson(obj))
  //       .toList();
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['sku'] = this.sku;
    data['product_description'] = this.productDescription;
    data['unit_price'] = this.unitPrice;
    data['currency'] = this.currency;
    data['unit'] = this.unit;
    data['tax'] = this.tax;
    return data;
  }
}

List<ProductModel> productsMock = ProductModel.toJsonList(jsonDecode(data));

class OrderModel {
  String? productId;
  String? sku;
  String? productDescription;
  double? unitPrice;
  String? currency;
  String? unit;
  double? tax;
  String? productImage;
  int? qty;

  OrderModel(
      {this.productId,
      this.sku,
      this.productDescription,
      this.unitPrice,
      this.currency,
      this.unit,
      this.tax,
      this.productImage,
      this.qty});

  OrderModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    sku = json['sku'];
    productDescription = json['product_description'];
    unitPrice = makeDouble(json['unit_price']);
    currency = json['currency'];
    unit = json['unit'];
    tax = json['tax'];
    productImage = json['product_id'];
    qty = json['qty'];
  }
}
