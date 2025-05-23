// extension MakeDouble on String {
//   double? get toDouble {
//     return runtimeType == int ? double.parse(toString()) : this;
//   }
// }
double makeDouble(dynamic value) {
  return value.runtimeType == double ? value : double.parse(value.toString());
}
