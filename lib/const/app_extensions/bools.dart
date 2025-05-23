extension IntToBool on int {
  String get toBool {
    if (this == 1) {
      return 'true';
    } else {
      return 'false';
    }
  }
}
