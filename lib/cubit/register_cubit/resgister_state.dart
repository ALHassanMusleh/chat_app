abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  String ErrorMessage;
  RegisterFailureState({required this.ErrorMessage});
}
