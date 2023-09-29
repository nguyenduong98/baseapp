part of 'models.dart';

class ErrorModel extends Equatable {
  final int? code;
  final String? error;
  final String? message;

  const ErrorModel({
    this.code,
    this.error,
    this.message,
  });

  @override
  List<Object?> get props => [code, error, message];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'error': error,
        'message': message,
      };

  factory ErrorModel.fromJson(Map<String, dynamic> map) {
    return ErrorModel(
      code: map['code'],
      error: map['error'],
      message: map['message'] != null
          ? map['message'] is List
              ? (map['message'] as List).join(', ')
              : map['message']
          : null,
    );
  }
}
