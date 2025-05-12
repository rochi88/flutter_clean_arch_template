extension ConvertNumToTaka on num? {
  String get inBDT {
    if (this == null) {
      return 'N/A';
    }
    return '৳${this!.toStringAsFixed(2)}';
  }
}
