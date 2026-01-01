part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserdataEntity userdataEntity;

  LoginSuccessState({required this.userdataEntity});

  @override
  List<Object?> get props => [userdataEntity];
}

class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
