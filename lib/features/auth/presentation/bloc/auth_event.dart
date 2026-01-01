part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String mobileNumber;
  final String password;

  LoginEvent({required this.mobileNumber, required this.password});

  @override
  List<Object?> get props => [mobileNumber, password];
}
