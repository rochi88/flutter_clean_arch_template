// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../main.dart';

part 'hive_storage_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Box> hiveService(Ref ref) async {
  await Hive.initFlutter(tempPath);
  final box = Hive.openBox('box');
  return box;
}
