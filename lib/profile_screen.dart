import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/angga.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Gede Angga Putra Pratama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  'Bali, Indonesia',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Saya Sangat Suka Berliburan di Wisata yang Bernuansa Lautan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            _buildTabBar(),
            _buildGridView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.bookmark)),
            ],
          ),
          Container(
            height: 400, // Height of the TabBarView
            child: TabBarView(
              children: [
                _buildGridView(), // Placeholder for likes view
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.network(
            'https://www.example.com/post_image_$index.jpg',
            fit: BoxFit.cover,
          ),
        );
      },
      itemCount: 12, // Number of posts
    );
  }
}

void main() => runApp(const MaterialApp(home: ProfileScreen()));
