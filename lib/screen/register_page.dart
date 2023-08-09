import 'package:chat_app/constant.dart';
import 'package:chat_app/cubit/Auth_cubit/auth_cubit.dart';

import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screen/chat_page.dart';
import 'package:chat_app/screen/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = 'RegisterPage';

  String? password;

  bool isLoading = false;

  //create key type of FormState
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          showSnackBar(context, 'Register Succefully',
              backgroundcolor: Colors.green);
          Navigator.pushNamed(context, LoginPage.id);
          isLoading = false;
        } else if (state is RegisterFailureState) {
          showSnackBar(context, state.ErrorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading, //انها هتظهر ولا
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
                        const SizedBox(height: 150),
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
                            'Sign up',
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              // isLoading = true;
                              // setState(() {
                              //   //update ui
                              // });
                              // try {
                              //   await RegisterUser();
                              //   showSnackBar(context, 'Registration Successfully',
                              //       backgroundcolor: Colors.green);
                              //   Navigator.pushNamed(context, ChatPage.id);
                              //
                              //   // print(user.user!.displayName);
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'weak-password') {
                              //     showSnackBar(
                              //         context, 'The password provided is too weak');
                              //   } else if (e.code == 'email-already-in-use') {
                              //     showSnackBar(context,
                              //         'The account already exists for that email.');
                              //   }
                              //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //   //   content: Text(
                              //   //     '$e',
                              //   //   ),
                              //   // ));
                              // } catch (ex) {
                              //   showSnackBar(context, 'there was an error');
                              // }
                              // isLoading = false;
                              // setState(() {});
                              BlocProvider.of<AuthCubit>(context).RegisterUser(
                                  email: email!, password: password!);
                            }
                          },
                          text: 'Sign up',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'hava an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context,'LoginPage');
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
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

  //Register User Method
  Future<void> RegisterUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
