class CoreException implements Exception {
  String? message;
  dynamic stackTrace;
  CoreException([this.message, this.stackTrace]);

  @override
  String toString() => 'Core exception: $message';
}

class UnSupportedLanguageException extends CoreException {}

class NoInternetException implements Exception {}

class UnAuthorizeException implements Exception {
  UnAuthorizeException([this.message]);

  String? message;
}

class TokenStorageException extends CoreException {
  TokenStorageException([String? message, dynamic stackTrace])
      : super(message, stackTrace);
}

class ServiceException implements Exception {
  ServiceException([this.message, this.error, this.code]);

  String? message;
  String? error;
  int? code;

  factory ServiceException.resultNull() {
    return ServiceException(null, 'resultNull');
  }

  factory ServiceException.unknow([String? message]) {
    return ServiceException(message, 'unknow');
  }

  factory ServiceException.internalServerError() {
    return ServiceException(null, 'internalServerError');
  }

  factory ServiceException.serverMaintenanceError() {
    return ServiceException(null, 'serverMaintenance');
  }
}
