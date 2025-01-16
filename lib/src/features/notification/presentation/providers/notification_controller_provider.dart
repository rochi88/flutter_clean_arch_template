// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../common/providers/http_client_provider.dart';
import '../../data/notification_repository.dart';

part 'notification_controller_provider.g.dart';

@riverpod
NotificationRepository notificationController(Ref ref) {
  final httpClient = ref.read(httpClientProvider);
  final notification = NotificationRepository(httpClient: httpClient);
  return notification;
}
