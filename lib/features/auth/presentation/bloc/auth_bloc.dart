import 'package:bloc/bloc.dart';
import 'package:mechine_test_nasih/features/auth/domain/entity/userdata_entity.dart';
import 'package:mechine_test_nasih/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLoginUsecase userLoginUsecase;
  AuthBloc({required this.userLoginUsecase}) : super(AuthInitial()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      final result = await userLoginUsecase.call(
        event.mobileNumber,
        event.password,
      );
      emit(LoginSuccessState(userdataEntity: result));
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }
}
