import 'package:binclan/bloc/user_bloc.dart';
import 'package:binclan/page/login.dart';
import 'package:binclan/page/pickup.dart';
import 'package:binclan/page/pickupHistory.dart';
import 'package:binclan/page/slashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        // Add other BLoCs here
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue[200],
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}

