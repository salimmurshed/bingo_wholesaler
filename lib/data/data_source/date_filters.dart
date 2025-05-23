import 'package:intl/intl.dart';

import '../../data_models/construction_model/date_filter_model/date_filter_model.dart';

String getFormatedDateTime(v) {
  return DateFormat('yyyy-MM-dd').format(v);
}

DateTime today = DateTime.now();
List<DateFilterModel> dateFilterList = [
  DateFilterModel(
    title: "Today - ${getFormatedDateTime(today)}",
    initiate: "today",
  ),
  DateFilterModel(
    title: "Tomorrow - ${getFormatedDateTime(today.add(Duration(days: 1)))}",
    initiate: "tomorrow",
  ),
  DateFilterModel(
    title:
        "Current Week - ${getFormatedDateTime(today.subtract(Duration(days: today.weekday)).add(const Duration(days: 7)))}",
    initiate: "cweek",
  ),
  DateFilterModel(
    title: "Next Week - "
        "${getFormatedDateTime(today.subtract(Duration(days: today.weekday)).add(const Duration(days: 14)))}",
    initiate: "nweek",
  ),
  DateFilterModel(
    title: "Next 2 Week - "
        "${getFormatedDateTime(today.subtract(Duration(days: today.weekday)).add(const Duration(days: 21)))}",
    initiate: "n2week",
  ),
  DateFilterModel(
    title: "Next 3 Week - "
        "${getFormatedDateTime(today.subtract(Duration(days: today.weekday)).add(const Duration(days: 28)))}",
    initiate: "n3week",
  ),
];
