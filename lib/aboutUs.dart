import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({ Key? key }) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/A.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'DewatAnv',
                style: GoogleFonts.lobster(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'explore the desired tour',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OpenContainer(
              closedElevation: 0,
              openElevation: 4,
              transitionType: ContainerTransitionType.fade,
              transitionDuration: const Duration(milliseconds: 800),
              closedBuilder: (context, action) => const ListTile(
                title: Text('Description'),
                subtitle: Text('Click to read more'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              openBuilder: (context, action) => MissionDetails(),
            ),
            OpenContainer(
              closedElevation: 0,
              openElevation: 4,
              transitionType: ContainerTransitionType.fade,
              transitionDuration: const Duration(milliseconds: 800),
              closedBuilder: (context, action) => const ListTile(
                title: Text('Our Team'),
                subtitle: Text('Click to read more'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              openBuilder: (context, action) => TeamDetails(),
            ),
            OpenContainer(
              closedElevation: 0,
              openElevation: 4,
              transitionType: ContainerTransitionType.fade,
              transitionDuration: const Duration(milliseconds: 800),
              closedBuilder: (context, action) => const ListTile(
                title: Text('Contact Us'),
                subtitle: Text('Click to read more'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              openBuilder: (context, action) => ContactDetails(),
            ),
          ],
        ),
      ),
    );
  }
}

class MissionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description Application'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'DewatAnv diambil dari kepanjangan Dewata Anveshaka, yang dalam Bahasa Indonesia diartikan "Penjelajah Dewata." Aplikasi mobile ini ditujukan untuk pulau Dewata dalam konteks ini merujuk pada julukan dari Pulau Bali. Aplikasi mobile dengan nama "DewatAnv" ini dirancang khusus dengan tujuan untuk membantu pengguna/wisatawan dalam menemukan dan menjelajahi destinasi wisata yang ada di Bali dengan mudah dan menyenangkan. Harapannya hal ini juga dapat membantu mempromosikan destinasi wisata yang kurang dikenal namun memiliki potensi besar pada Pulau Bali.'
          'Aplikasi ini memanfaatkan basis data yang kaya tentang tempat-tempat wisata di Bali, mencakup keindahan alam, warisan budaya, dan beragam aktivitas rekreasi. Pengguna dapat mengakses informasi mengenai berbagai jenis destinasi wisata yang ada di Pulau Dewata ini seperti pantai, pura, pegunungan, air terjun, dan pulau-pulau kecil, tentunya lengkap disertai dengan fasilitas-fasilitas lengkap dan mudah seperti fitur-fitur atau layanan yang dapat dimanfaatkan pengguna dalam penggunaan aplikasi, antarmuka intuitif, serta berfokus pada keseluruhan interaksi/pengalaman pengguna dengan aplikasi (User Experience).',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class TeamDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Team'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'We have a diverse and talented team of professionals who are dedicated to achieving excellence...',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'You can reach us at contact@ourcompany.com or call us at (123) 456-7890...',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}