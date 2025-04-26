import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  FlutterSecureStorage get storage => _secureStorage;

  Future<void> saveToken(String token) async {
    return storage.write(key: 'auth-token', value: token);
  }

  Future<void> deleteToken() async {
    return storage.delete(key: 'auth-token');
  }

  Future<String?> getToken() async {
    return storage.read(key: 'auth-token');
  }
}
