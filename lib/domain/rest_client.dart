import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/domain/apply_header_interceptors.dart';
import 'package:layali_flutter_app/domain/token_expire_interceptor.dart';
import 'package:layali_flutter_app/env.dart';
import 'package:layali_flutter_app/services/auth_service.dart';
import 'package:layali_flutter_app/services/property_service.dart';
import 'package:layali_flutter_app/services/user_service.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';

@singleton
class RestUnprotectedService {
  final _client = ChopperClient(
    baseUrl: Uri.parse(Env.baseUrl),
    converter: const JsonConverter(),
    errorConverter: const JsonConverter(),
    services: [AuthService.create()],
    interceptors: [PrettyChopperLogger()],
  );
  ChopperClient get client => _client;
}

@singleton
class RestProtectedService {
  final _client = ChopperClient(
    baseUrl: Uri.parse(Env.baseUrl),
    converter: const JsonConverter(),
    errorConverter: const JsonConverter(),
    services: [UserService.create(), PropertyService.create()],
    interceptors: [
      ApplyHeaderInterceptor(),
      PrettyChopperLogger(),
      TokenExpireInterceptor(),
    ],
  );
  ChopperClient get client => _client;
}
