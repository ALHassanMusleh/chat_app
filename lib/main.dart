import 'package:chat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/cubit/Auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screen/chat_page.dart';
import 'package:chat_app/screen/login_page.dart';
import 'package:chat_app/screen/register_page.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimplerBlocObserver();
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => LoginCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => RegisterCubit(),
        // ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
        // home: LoginPage(),
      ),
    );
  }
}
