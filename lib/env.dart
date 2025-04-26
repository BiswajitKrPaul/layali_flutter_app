import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(name: 'Env', path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;

  // @EnviedField(varName: 'LOGIN_PATH')
  // static final String loginPath = _Env.loginPath;

  // @EnviedField(varName: 'REGISTER_PATH')
  // static final String registerPath = _Env.registerPath;

  // @EnviedField(varName: 'UPDATE_USER_PATH')
  // static final String updateUserPath = _Env.updateUserPath;

  // @EnviedField(varName: 'LOGOUT_PATH')
  // static final String logoutPath = _Env.logoutPath;

  // @EnviedField(varName: 'GET_USER_PATH')
  // static final String getUserPath = _Env.getUserPath;
}
