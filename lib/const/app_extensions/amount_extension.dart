import 'package:intl/intl.dart';

final oCcy = NumberFormat.currency(
    locale: 'en_US',
    customPattern: '#,### \u00a4',
    symbol: '',
    decimalDigits: 2);

extension Amount on String {
  String priceString() {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }

    return "${numberDigits.join()}.00";
  }
}

extension Amount1 on double {
  String getFormattedDouble() {
    return oCcy.format(this);
  }
}
