import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/images/A.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Text(
                'kamu bisa cari dan baca topik yang ingin kamu ketahui',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildListItem(
              context,
              'How To Using The App?',
              'Click to read more',
              const MissionDetails(),
              const Color.fromARGB(255, 30, 129, 209),
            ),
            _buildListItem(
              context,
              'App Features',
              'Click to read more',
              const TeamDetails(),
              const Color.fromARGB(255, 30, 129, 209),
            ),
            _buildListItem(
              context,
              'Technical Issues',
              'Click to read more',
              const ContactDetails(),
              const Color.fromARGB(255, 30, 129, 209),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    String subtitle,
    Widget page,
    Color color,
  ) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 4,
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 800),
      closedBuilder: (context, action) => ListTile(
        title: Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: action,
      ),
      openBuilder: (context, action) => page,
    );
  }
}

class MissionDetails extends StatelessWidget {
  const MissionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Description Application',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Using the App'),

            // How to Search for Tourist Spots
            _buildListItem('How to Search for Tourist Spots',
                'To search for tourist spots, users can go to the home screen and look for the search bar. Tap the search bar and type in the desired tourist spot. The app will then display all related tourist spots based on the user\'s query.'),

            // How to View Tourist Spot Details
            _buildListItem('How to View Tourist Spot Details',
                'To view the details of a tourist spot, users can select any spot available, either from the home screen\'s top-rated section or from categories. After selecting a tourist spot from the list, users can see detailed information such as images, descriptions, and maps of the spot.'),

            // How to Use Google Maps in the App
            _buildListItem('How to Use Google Maps in the App',
                'To view Google Maps within the app, users can do so after viewing the details of the selected tourist spot. At the bottom of the tourist spot details, users will find the Google Maps section for their destination.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 30, 129, 209),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 129, 209),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class TeamDetails extends StatelessWidget {
  const TeamDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Features',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('App Features'),

            // Tourist Spot Details
            _buildListItem('Tourist Spot Details',
                'This feature provides users with comprehensive information about various tourist spots, including images, descriptions, reviews, and maps. Users can explore different attractions and plan their visits accordingly.'),

            // Profile
            _buildListItem('Profile',
                'Users can view their profile, which includes personal information and a list of their favorite tourist spots. This allows users to keep track of the places they have marked as favorites and access them easily.'),

            // Tourist Spot Map
            _buildListItem('Tourist Spot Map',
                'This feature offers an interactive map that highlights various tourist spots. Users can navigate through the map to discover new attractions and get directions to their chosen destinations.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 30, 129, 209),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 129, 209),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Technical Issues',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Technical Issues'),

            // App Won't Open
            _buildListItem('App Won\'t Open',
                'If the app won\'t open, try the following steps:\n1. Ensure the app is updated to the latest version.\n2. Restart your device.\n3. Clear the app\'s cache and data.\n4. If the problem persists, reinstall the app.'),

            // Fixing Internet Connection Problems in the App
            _buildListItem('Fixing Internet Connection Problems in the App',
                'If you\'re experiencing internet connection problems within the app, try the following:\n1. Check your internet connection and ensure you have a stable connection.\n2. Toggle airplane mode on and off.\n3. Restart your device.\n4. If using Wifi, try connecting to a different network.'),
            
            // Google Maps in the App Doesn't Load
            _buildListItem('Google Maps in the App Doesn\'t Load',
                'If Google Maps in the app doesn\'t load, try the following:\n1. Ensure you have a stable internet connection.\n2. Update the Google Maps app on your device.\n3. Restart your device.\n4. Clear the cache and data of the Google Maps app.\n5. If the problem persists, reinstall the Google Maps app.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 30, 129, 209),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 129, 209),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
