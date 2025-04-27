import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/env.dart';

@singleton
class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  FlutterSecureStorage get storage => _secureStorage;

  Future<void> saveToken(String token) async {
    return storage.write(key: Env.tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    return storage.delete(key: Env.tokenKey);
  }

  Future<String?> getToken() async {
    return storage.read(key: Env.tokenKey);
  }
}
