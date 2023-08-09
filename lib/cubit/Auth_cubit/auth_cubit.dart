import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
