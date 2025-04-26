import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/env.dart';
import 'package:layali_flutter_app/services/auth_service.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';

@singleton
class RestService {
  final _client = ChopperClient(
    baseUrl: Uri.parse(Env.baseUrl),
    converter: const JsonConverter(),
    errorConverter: const JsonConverter(),
    services: [AuthService.create()],
    interceptors: [PrettyChopperLogger()],
  );
  ChopperClient get client => _client;
}
