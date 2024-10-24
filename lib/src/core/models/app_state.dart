class AppState {
  Future<String?>? token;
  bool dbSynced;
  String? dbSyncedAt;

  AppState({this.token, this.dbSynced = false, this.dbSyncedAt});

  AppState copyWith({
    Future<String?>? token,
    bool? dbSynced,
    String? dbSyncedAt,
  }) {
    return AppState(
      token: token ?? this.token,
      dbSynced: dbSynced ?? this.dbSynced,
      dbSyncedAt: dbSyncedAt ?? this.dbSyncedAt,
    );
  }
}
