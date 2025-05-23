import '/data_models/construction_model/static_data_models/visit_frequent_list_model.dart';

import '../models/component_models/partner_with_currency_list.dart';

class WholesalersData {
  String? id;
  WholesalerData? wholesaler;
  String? currency;
  String? monthlyPurchase;
  String? averageTicket;
  VisitFrequentListModel? visitFrequency;
  String? amount;

  WholesalersData(
      {this.id,
      this.wholesaler,
      this.currency,
      this.monthlyPurchase,
      this.averageTicket,
      this.visitFrequency,
      this.amount});
}
