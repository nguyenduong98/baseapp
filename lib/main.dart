import 'core/core.dart';
import 'data/data.dart';
import 'data/models/models.dart';
import 'features/app.dart';
import 'features/main/main_cubit.dart';

void main() async {
  await initializeComponents();
  //
  runApp(const MyApp());
}

Future<void> initializeComponents() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  final storage = SecuredStorage();
  final tokenStorage = SecureTokenStorage<JwtToken>(
    tokenKey: 'token_key',
    create: () => JwtToken(),
    storage: storage,
  );

  final interceptor = RefreshTokenInterceptor<JwtToken>(
    tokenStorage: tokenStorage,
    headerBuilder: (token) {
      final headers = <String, String>{};
      if (token.customerToken != null) {
        headers['Authorization'] = 'Bearer ${token.customerToken}';
      }
      return headers;
    },
    refreshToken: (token, dio) => throw RevokeTokenException(),
  );

  final api = Api(
    Dio()
      ..options.baseUrl = 'http'
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 120000)
      ..options.sendTimeout = const Duration(milliseconds: 30000)
      ..interceptors.addAll([interceptor]),
  );

  final userRepo = UserRepositoryImpl(api: api);

  /**
   * Cubit
   */
  GetIt.instance.registerFactory(() => MainCubit(userRepo));
}
