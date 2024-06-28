import 'package:dewatanv/services/data_service.dart';
import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String username;
  final String backgroundImage;

  const MyDrawer({super.key, required this.username, required this.backgroundImage});

  Future<void> doLogout(context) async {
    debugPrint("need logout");
    final response = await DataService.logoutData();
    if (response.statusCode == 200) {
      await SecureStorageUtil.storage.delete(key: tokenStoreName);
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(backgroundImage),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white),
            _createDrawerItem(
              icon: Icons.person,
              text: 'About Us',
              onTap: () => Navigator.pushNamed(context, '/about_us'),
            ),
            _createDrawerItem(
              icon: Icons.help,
              text: 'Help Center',
              onTap: () => Navigator.pushReplacementNamed(context, '/help-screen'),
            ),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'Sign Out',
              onTap: () => doLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
