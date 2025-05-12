// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_status_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivityStatus(
  Ref ref,
) async* {
  final Connectivity connectivity = Connectivity();

  // yield first connectivity result
  yield await connectivity.checkConnectivity();

  // yield on change stream
  await for (final connectivityResults in connectivity.onConnectivityChanged) {
    yield connectivityResults;
  }
}

/// only listen to changes
@riverpod
Stream<List<ConnectivityResult>> connectivityChanged(
  Ref ref,
) =>
    Connectivity().onConnectivityChanged;
