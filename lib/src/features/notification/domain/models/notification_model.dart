// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String title;
  final String body;
  final String? actionUrl;
  final bool seen;
  final Map? additionalData;
  final DateTime? date;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    this.actionUrl,
    this.seen = false,
    this.additionalData,
    this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
