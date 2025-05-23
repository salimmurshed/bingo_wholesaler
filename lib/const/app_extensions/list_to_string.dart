extension ListToString on String {
  String get listToString =>
      replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "").toString();
}

/*
extension ListToInt on String {
  int get listToInt => replaceAll("[", "").replaceAll("]", "");
}*/
extension GroupingBy on Iterable<dynamic> {
  Map<String, List<dynamic>> groupingBy(String key) {
    var result = <String, List<dynamic>>{};
    for (var element in this) {
      result[element[key]] = (result[element[key]] ?? [])..add(element);
    }
    return result;
  }
}
