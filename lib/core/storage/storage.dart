import '../core.dart';

class SecuredStorage implements LocalStorage {
  SecuredStorage();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } catch (_) {}
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (_) {}
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } on PlatformException {
      await clear();
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String key, String data) async {
    try {
      await _storage.write(key: key, value: data);
    } catch (_) {}
  }
}

abstract class LocalStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String data);
  Future<void> delete(String key);
  Future<void> clear();
}
