// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'APP_NAME')
  static String appName = _Env.appName;

  @EnviedField(varName: 'SERVER_URL', obfuscate: true)
  static String serverUrl = _Env.serverUrl;

  @EnviedField(varName: 'API_VERSION', obfuscate: true)
  static String apiVersion = _Env.apiVersion;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _Env.apiKey;
}
