part of 'models.dart';

class JwtToken extends TokenObject {
  JwtToken({
    this.status,
    this.customerToken,
    this.forceChangePassword = false,
  });

  final bool? status;
  final String? customerToken;
  final bool forceChangePassword;

  @override
  factory JwtToken.fromJson(Map<String, dynamic> map) {
    return JwtToken(
      status: map['status'],
      customerToken: map['customer_token'],
      forceChangePassword: map['force_password_change'] == true,
    );
  }

  @override
  JwtToken fromJson(Map<String, dynamic> map) {
    return JwtToken.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'customer_token': customerToken,
      };

  @override
  List<Object?> get props => [
        status,
        customerToken,
        forceChangePassword,
      ];
}
