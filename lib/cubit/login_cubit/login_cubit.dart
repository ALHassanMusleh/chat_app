import 'package:chat_app/cubit/login_cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  //write logic
  // login User Method
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // print(user.user!.uid);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(ErrorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(
            ErrorMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailureState(ErrorMessage: e.toString()));
    }
  }
}
