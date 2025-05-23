import 'package:intl/intl.dart';

extension Formatter on DateTime {
  String formatHyphen() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formatSlash() {
    return DateFormat('MM/dd/yyyy').format(this);
  }
}
