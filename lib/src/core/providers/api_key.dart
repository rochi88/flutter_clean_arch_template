import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_key.g.dart';

@riverpod
String apiKey(ApiKeyRef ref) {
  return 'YOUR_API_KEY';
}
