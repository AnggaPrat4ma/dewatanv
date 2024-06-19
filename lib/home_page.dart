import 'package:dewatanv/category.dart';
import 'package:dewatanv/drawer.dart';
import 'package:dewatanv/home_screen.dart';
import 'package:dewatanv/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _screens = [
    const HomeScreen(),
    const Category(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    'DewatAnv',
    'Category',
    'Profile',
  ]; // List of titles corresponding to each screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
    duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        username: 'Angga Pratama',
        backgroundImage: 'assets/images/angga.jpg',
      ),
      body: PageView(
        controller: _pageController,
        children: _screens.map((screen) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: screen,
          );
        }).toList(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 129, 209),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavBarItem(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavBarItem(Icons.category, 1),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: _buildNavBarItem(Icons.person, 2),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 168, 168, 168),
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? Colors.white.withOpacity(0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        size: 30,
        color: _selectedIndex == index ? Colors.white : const Color.fromARGB(255, 168, 168, 168),
      ),
    );
  }
}