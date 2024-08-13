import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SERVER_URL', obfuscate: true)
  static String serverUrl = _Env.serverUrl;

  @EnviedField(varName: 'APP_NAME', obfuscate: true)
  static String appName = _Env.appName;

  @EnviedField(varName: 'APP_KEY', obfuscate: true)
  static String appKey = _Env.appKey;
}
