part of 'cubit.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final dynamic error;

  const BaseState({this.isLoading = false, this.error});

  dynamic copyWith({bool? isLoading, dynamic error});
}
