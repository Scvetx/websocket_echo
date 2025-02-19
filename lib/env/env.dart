import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  /// Login for server authentication
  @EnviedField(varName: 'WS_LOGIN', obfuscate: true)
  static final String wsLogin = _Env.wsLogin;
  /// Password for server authentication
  @EnviedField(varName: 'WS_PASSWORD', obfuscate: true)
  static final String wsPassword = _Env.wsPassword;
}