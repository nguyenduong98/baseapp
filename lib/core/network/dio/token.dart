part of 'dio.dart';

abstract class TokenObject extends Equatable {
  dynamic fromJson(Map<String, dynamic> map);
  Map<String, dynamic> toJson();
}
