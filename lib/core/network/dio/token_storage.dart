part of 'dio.dart';

class SecureTokenStorage<T extends TokenObject> extends TokenStorage<T> {
  SecureTokenStorage({
    required this.tokenKey,
    required this.create,
    required this.storage,
  }) : assert(tokenKey.isNotEmpty);

  final String tokenKey;
  final T Function() create;
  final SecuredStorage storage;

  @override
  Future<void> delete() async {
    try {
      return await storage.delete(tokenKey);
    } catch (e) {
      throw TokenStorageException('Delete token exception', e);
    }
  }

  @override
  Future<T?> read() async {
    try {
      final stringValue = await storage.read(tokenKey);
      if (stringValue == null || stringValue.isEmpty) return null;
      final map = jsonDecode(stringValue);
      T obj = create();
      return obj.fromJson(map) as T;
    } catch (_) {
      await storage.clear();
      return null;
    }
  }

  @override
  Future<void> write(T token) async {
    try {
      return await storage.write(tokenKey, jsonEncode(token.toJson()));
    } catch (e) {
      throw TokenStorageException('Write token exception', e);
    }
  }
}
