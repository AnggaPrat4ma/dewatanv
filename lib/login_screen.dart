import 'dart:convert';

import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/dto/login.dart';
import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isHovering = false;

  void sendLogin(context, AuthCubit authCubit) async {
    final username= _usernameController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(username, password);
    if(response.statusCode == 200) {
      debugPrint("sending success");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage.write(key: tokenStoreName, value: loggedIn.accessToken);

      authCubit.login(loggedIn.accessToken);
      Navigator.pushReplacementNamed(context, '/home-page');
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(), // Ganti dengan layar tujuan setelah login
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
      debugPrint(loggedIn.accessToken);
    }
    else{
      debugPrint('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color.fromARGB(255, 84, 144, 212),
              Color.fromARGB(255, 51, 99, 158),
              Color.fromARGB(255, 28, 62, 101),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/A.png', // Gambar logo
                    height: 170,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'DewatAnv',
                    style: GoogleFonts.pacifico(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .5),
                          blurRadius: 30.0,
                          offset: Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person, color: Colors.grey),
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock, color: Colors.grey),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                  child: InkWell(
                    onTap: () { sendLogin(context, authCubit); },
                    //onTap: () => Navigator.pushReplacementNamed(context, '/home-page'),
                    child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isHovering
                                ? [const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 0, 0, 0)] // Warna berubah saat hover
                                : [const Color(0xFF61A4F1), const Color(0xFF478DE0)],
                          ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .4),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Implementasi untuk lupa password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


