class Utils {
  static int getCreationTime() {
    return ((DateTime.now().toUtc().millisecondsSinceEpoch - 5000) / 1000).floor();
  }
}
