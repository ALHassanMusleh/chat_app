import 'package:chat_app/cubit/register_cubit/resgister_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  //write logic
//Register User Method
  Future<void> RegisterUser(
      {required String email, required String password}) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailureState(
            ErrorMessage: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(
            ErrorMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFailureState(ErrorMessage: e.toString()));
    }
  }
}
