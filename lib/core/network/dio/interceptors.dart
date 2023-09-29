part of 'dio.dart';

class RefreshTokenInterceptor<T extends TokenObject> extends Fresh<T> {
  RefreshTokenInterceptor({
    required this.tokenStorage,
    required this.headerBuilder,
    required super.refreshToken,
  }) : super(
          tokenStorage: tokenStorage,
          tokenHeader: headerBuilder,
        );

  final TokenHeaderBuilder<T> headerBuilder;
  final SecureTokenStorage<T> tokenStorage;

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await tokenStorage.read();
    final headers = currentToken != null
        ? headerBuilder(currentToken)
        : const <String, String>{};
    options.headers.addAll(headers);
    handler.next(options);
  }
}
