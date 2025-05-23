import '../../data_models/models/retailer_bank_list/retailer_bank_list.dart';

String statusForSettingCheck(String lang, RetailerBankListData data) {
  if (lang.toLowerCase() == 'en') {
    return data.statusDescription!;
  } else {
    switch (data.statusDescription!.toLowerCase()) {
      case "approved":
        return "Aprobada";
      case "not validated":
        return "No validada";
      case "rejected":
        return "Rechazada";
      case "validation pending":
        return "Pendiente de Validación";
    }
    return "";
  }
}
