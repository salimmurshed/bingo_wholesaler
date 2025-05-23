import '/data_models/models/customer_store_list/customer_store_list.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../customer_store_pics/store_pics.dart';

class CustomerLocationDetailsModel extends BaseViewModel {
  // NavigationService _navigationService = locator<NavigationService>();
  CustomerStoreData customerData = CustomerStoreData();

  setData(CustomerStoreData arguments) {
    customerData = arguments;
    notifyListeners();
  }

  int routeNUmber = 0;

  changeRoute(v) {
    routeNUmber = v;
    notifyListeners();
  }

  gotoPhotos(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              StorePics(customerData.storeLogo, customerData.signBoardPhoto)),
    );
  }
}
