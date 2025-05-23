import 'package:stacked/stacked.dart';

import '../../../data_models/models/customer_settlement_list/customer_settlement_list.dart';

class CustomerSettlementDetailsViewModel extends BaseViewModel {
  CustomerSettlementData settlementDetail = CustomerSettlementData();
  setData(v) {
    settlementDetail = v;
    notifyListeners();
  }
}
