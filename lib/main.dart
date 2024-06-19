import 'package:dewatanv/about_us.dart';
import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/cubit/balance/cubit/balance_cubit.dart';
import 'package:dewatanv/home_page.dart';
import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/login_screen.dart';
import 'package:dewatanv/profile_screen.dart';
import 'package:dewatanv/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider<wisataCubit>(create: (context) => wisataCubitit()),
        BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ], 
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      home: const MyHomePage(title: 'DewatAnv'),
      routes: {
        '/profil-screen':(context) => const ProfileScreen(),
        '/home-screen':(context) => const HomeScreen(),
        '/login':(context) => const LoginPage(),
        '/about_us':(context) => const AboutUs(),
        '/home-page':(context) => const MyHomePage(title: 'DewatAnv'),
        '/register':(context) => const Register()
      },
    ));
  }
}


