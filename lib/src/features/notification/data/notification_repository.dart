// Project imports:
import '../../../core/helpers/delay.dart';
import '../../../core/utils/http_client.dart';
import '../domain/models/notification_model.dart';

class NotificationRepository {
  NotificationRepository({required this.httpClient, this.addDelay = false});
  final bool addDelay;
  final HttpClient httpClient;

  Future<List<Notification>> getData() async {
    await delay(addDelay);

    final response = await httpClient.get('/notifications');

    final result = response.data!['data']
        .map<Notification>(
            (e) => Notification.fromJson(e as Map<String, dynamic>))
        .toList();

    return result;
  }
}
