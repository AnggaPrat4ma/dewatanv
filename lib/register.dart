import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/login_screen.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHovering = false;

  void sendRegister() async {
    final name = _nameController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    debugPrint(name);
    debugPrint(username);
    debugPrint(password);
    final response = await DataService.sendSignUpData(name, username, password);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      debugPrint("sending success");
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
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
    } else {
      debugPrint("failed not cannot sign up");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            controller: _nameController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person, color: Colors.grey),
                              border: InputBorder.none,
                              hintText: "Nama Lengkap",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
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
                    onTap: () { sendRegister(); },
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
                        'Registrasi',
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