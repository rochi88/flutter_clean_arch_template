class AppState {
  AppState(
      {required this.token,
      required this.isDarkModeEnabled,
      required this.isSynced,
      required this.dbVersion});
  Future<String?> token;
  bool isDarkModeEnabled;
  bool isSynced;
  String? dbVersion;

  AppState copyWith({
    Future<String?>? token,
    bool? isDarkModeEnabled,
    bool? isSynced,
    String? dbVersion,
  }) {
    return AppState(
      token: token ?? this.token,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      isSynced: isSynced ?? this.isSynced,
      dbVersion: dbVersion ?? this.dbVersion,
    );
  }
}
