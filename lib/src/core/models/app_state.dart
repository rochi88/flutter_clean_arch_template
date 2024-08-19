class AppState {
  AppState(
      {required this.token,
      required this.isDarkModeEnabled,
      required this.isSynced,
      required this.dbUpdatedAt});
  Future<String?> token;
  bool isDarkModeEnabled;
  bool isSynced;
  DateTime? dbUpdatedAt;

  AppState copyWith({
    Future<String?>? token,
    bool? isDarkModeEnabled,
    bool? isSynced,
    DateTime? dbUpdatedAt,
  }) {
    return AppState(
      token: token ?? this.token,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      isSynced: isSynced ?? this.isSynced,
      dbUpdatedAt: dbUpdatedAt ?? this.dbUpdatedAt,
    );
  }
}
