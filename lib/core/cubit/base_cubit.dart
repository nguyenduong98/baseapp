part of 'cubit.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  bool get hasError => state.error != null;
}
