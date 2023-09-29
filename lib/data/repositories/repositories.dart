import '../../core/core.dart';
import '../../core/exceptions/exceptions.dart';
import '../models/models.dart';

export 'user/user_repository.dart';

abstract class BaseRepository {
  Future<T> request<T>(Future Function() call) async {
    final result = await requestNullable(call);
    if (result != null) return result;
    throw ServiceException.resultNull();
  }

  Future<T?> requestNullable<T>(Future Function() call) async {
    try {
      final hasInternet = await NetworkUtil.instance.hasInternet();
      if (!hasInternet) throw NoInternetException();
      return await call();
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        handleDioErrorResponse(error);
        return null;
      } else if (error.error is RevokeTokenException) {
        throw UnAuthorizeException();
      } else {
        final eType = error.type;

        String msgCode = 'dioOther';
        if (eType == DioExceptionType.cancel) msgCode = 'dioCancel';
        if (eType == DioExceptionType.connectionTimeout) {
          msgCode = 'dioConnectTimeout';
        }
        if (eType == DioExceptionType.receiveTimeout) {
          msgCode = 'dioReceiveTimeout';
        }
        if (eType == DioExceptionType.sendTimeout) msgCode = 'dioSendTimeout';

        throw ServiceException(
          null,
          msgCode,
          error.response?.statusCode,
        );
      }
    } on NoInternetException {
      rethrow;
    } on UnAuthorizeException {
      rethrow;
    } on RevokeTokenException {
      throw UnAuthorizeException();
    } on ServiceException {
      rethrow;
    } catch (error) {
      throw ServiceException.unknow();
    }
  }

  void handleDioErrorResponse(DioError error) {
    if (error.response?.statusCode == 401) {
      //
      final response = error.response?.data;
      final errorModel = (response != null && response is Map)
          ? ErrorModel.fromJson(response as Map<String, dynamic>)
          : null;
      //
      throw UnAuthorizeException(errorModel?.message);
    }
    if (error.response?.statusCode == 500) {
      throw ServiceException.internalServerError();
    }
    if (error.response?.statusCode == 502) {
      throw ServiceException.internalServerError();
    }
    if (error.response?.statusCode == 503) {
      throw ServiceException.serverMaintenanceError();
    }
    final response = error.response?.data;
    if (response != null && response is Map) {
      final json = response as Map<String, dynamic>;
      final model = ErrorModel.fromJson(json);
      throw ServiceException(
        model.message,
        null,
        model.code,
      );
    } else if (response is String) {
      final mess = RegExp(Patterns.html).hasMatch(response) ? null : response;
      throw ServiceException(mess);
    } else {
      throw ServiceException.unknow();
    }
  }
}
