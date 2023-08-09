import 'package:chat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';

import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screen/alldata.dart';
import 'package:chat_app/screen/chat_page.dart';
import 'package:chat_app/screen/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  String? email, password;
  static String id = 'LoginPage';

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          showSnackBar(context, 'Login Succefully',
              backgroundcolor: Colors.green);
          BlocProvider.of<ChatCubit>(context).getMessages(); // get all messages
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailureState) {
          showSnackBar(context, state.ErrorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 150),
                        Image.asset(
                          'assets/images/scholar.png',
                        ),
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'Enter  Email',
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              // isLoading = true;
                              // try {
                              //   await loginUser();
                              //   showSnackBar(context, 'Login Succefully',
                              //       backgroundcolor: Colors.green);
                              //   Navigator.pushNamed(context, ChatPage.id,
                              //       arguments: email);
                              //   // Navigator.push(context,
                              //   //     MaterialPageRoute(builder: (context) {
                              //   //   return Alldata();
                              //   // }));
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'user-not-found') {
                              //     showSnackBar(
                              //         context, 'No user found for that email.');
                              //   } else if (e.code == 'wrong-password') {
                              //     showSnackBar(context,
                              //         'Wrong password provided for that user.');
                              //   }
                              // } catch (e) {
                              //   showSnackBar(context, 'there was an error');
                              // }
                              // isLoading = false;

                              BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                                  email: email!, password: password!));
                            }
                          },
                          text: 'Login',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont hava an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterPage.id);
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  // void showSnackBar(BuildContext context, String message,
  //     {Color? backgroundcolor}) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(
  //       message,
  //     ),
  //     backgroundColor: backgroundcolor,
  //   ));
  // }

  //login User Method
  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
