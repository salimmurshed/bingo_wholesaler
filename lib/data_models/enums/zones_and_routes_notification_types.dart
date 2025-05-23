enum ZoneRouteNotificationType {
  dynamic_routes_changed,
  static_routes_changed,
  sales_zone_changed,
  todo_list_changed;
}

toEnum(List<ZoneRouteNotificationType> t, String value) {
  final map = {};
  if (map.isEmpty) {
    for (final e in t) {
      map[e.name.toLowerCase()] = e;
    }
  }
  return map[value.toLowerCase()] ?? t[0];
}
