import '../../../../../../data/data.dart';
import '../../core/core.dart';
import '../../core/cubit/cubit.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit(this.userRepo) : super(const MainState());
  final UserRepository userRepo;

  Future<void> getContact() async {
    try {
      if (state.isLoading) return;
      emit(state.copyWith(isLoading: true));
      final respone = await userRepo.getContact();
      emit(state.copyWith(
        isLoading: false,
        contacts: respone,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }
}

class MainState extends BaseState {
  const MainState({
    super.isLoading,
    super.error,
    this.contacts,
  });

  final List<Contact>? contacts;

  bool get isInitialState => this == const MainState();

  @override
  MainState copyWith({
    bool? isLoading,
    dynamic error,
    List<Contact>? contacts,
  }) {
    return MainState(
      error: error,
      isLoading: isLoading ?? this.isLoading,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        contacts,
      ];
}
