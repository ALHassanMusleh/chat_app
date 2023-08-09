part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterFailureState extends AuthState {
  String ErrorMessage;
  RegisterFailureState({required this.ErrorMessage});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailureState extends AuthState {
  String ErrorMessage;
  LoginFailureState({required this.ErrorMessage});
}
