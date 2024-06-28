import 'package:dewatanv/aboutUs.dart';
import 'package:dewatanv/components/auth_wrapper.dart';
import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/home_page.dart';
import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/internet.dart';
import 'package:dewatanv/kategori/search.dart';
import 'package:dewatanv/login_screen.dart';
import 'package:dewatanv/profile_screen.dart';
import 'package:dewatanv/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize URLs before running the app
  try {
    await Endpoints.initializeURLs();
  } catch (e) {
    // Handle initialization error if necessary
    // ignore: avoid_print
    print('Failed to initialize URLs: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider<wisataCubit>(create: (context) => wisataCubitit()),
        // BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
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
        '/register':(context) => const Register(),
        '/search':(context) => const WisataSearchPage(),
        '/internet':(context) => const InputIp(),
        '/autologin':(context) => const AuthWrapper(child: LoginPage())
      },
    ));
  }
}


