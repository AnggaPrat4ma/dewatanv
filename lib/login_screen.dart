import 'dart:convert';
import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/dto/login.dart';
import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHovering = false;

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login Failed',
                style: GoogleFonts.pacifico(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                message,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendLogin(BuildContext context, AuthCubit authCubit) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(username, password);
    if (response.statusCode == 200) {
      debugPrint("sending success");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage.write(key: tokenStoreName, value: loggedIn.accessToken);

      authCubit.login(
        loggedIn.accessToken, 
        loggedIn.iduser,
        loggedIn.namaUser,
        loggedIn.role,
        loggedIn.username
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home-page');
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(), 
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
      debugPrint(loggedIn.role); // Debug print role untuk memastikan isinya benar
    } else {
      showErrorDialog('Incorrect username or password.');
      debugPrint('failed send login');
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
                      boxShadow: const [
                        BoxShadow(
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
                          boxShadow: const [
                            BoxShadow(
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
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    child: InkWell(
                      onTap: () => Navigator.pushReplacementNamed(context, '/register'),
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
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .4),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementasi aksi FAB di sini, misalnya navigasi ke layar lain
          Navigator.pushNamed(context, '/internet'); // Ganti dengan rute yang diinginkan
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.wifi_find),
      ),
    );
  }
}
