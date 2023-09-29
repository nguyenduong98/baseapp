import '../../core/core.dart' hide Headers;

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET('/V1/location')
  Future<dynamic> getRegions();
}
