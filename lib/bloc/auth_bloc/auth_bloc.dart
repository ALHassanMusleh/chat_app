import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          UserCredential user =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          // print(user.user!.uid);
          emit(LoginSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailureState(
                ErrorMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailureState(
                ErrorMessage: 'Wrong password provided for that user.'));
          }
        } catch (e) {
          emit(LoginFailureState(ErrorMessage: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoadingState());
        try {
          UserCredential user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   print(transition);
  // }
}
