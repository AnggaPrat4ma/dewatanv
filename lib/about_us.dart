import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/A.png'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'DewatAnv',
                style: GoogleFonts.lobster(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 30, 129, 209),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Explore the Desired Tour',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildListItem(
              context,
              'Description',
              'Click to read more',
              const MissionDetails(),
              const Color.fromARGB(255, 30, 129, 209),
            ),
            _buildListItem(
              context,
              'Our Team',
              'Click to read more',
              const TeamDetails(),
              const Color.fromARGB(255, 30, 129, 209),
            ),
            _buildListItem(
              context,
              'Contact Us',
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
            _buildSectionTitle('Tentang Kami'),
            _buildParagraph(
              'DewatAnv adalah aplikasi revolusioner yang dirancang untuk para pencinta wisata yang ingin mengeksplorasi keindahan Bali dengan cara yang mudah dan informatif. Kami menyediakan berbagai informasi detail tentang destinasi wisata, aktivitas menarik, dan panduan yang bermanfaat untuk memaksimalkan pengalaman Anda di Pulau Dewata.',
            ),
            _buildSectionTitle('Misi Kami'),
            _buildParagraph(
              'Misi kami adalah mempromosikan keindahan Bali kepada dunia dan memberikan informasi yang akurat dan terperinci kepada wisatawan. Kami berkomitmen untuk menjadi panduan terpercaya dalam setiap langkah perjalanan Anda di Bali.',
            ),
            _buildSectionTitle('Visi Kami'),
            _buildParagraph(
              'Visi kami adalah menjadikan DewatAnv sebagai platform terdepan dalam penyediaan informasi wisata di Bali, yang tidak hanya membantu wisatawan tetapi juga mendukung keberlanjutan pariwisata lokal dan memberikan manfaat kepada masyarakat setempat.',
            ),
            _buildSectionTitle('Latar Belakang'),
            _buildParagraph(
              'DewatAnv didirikan oleh sekelompok individu yang memiliki cinta yang mendalam terhadap Bali dan passion untuk teknologi. Kami menyadari bahwa informasi wisata yang komprehensif dan mudah diakses sangat penting bagi wisatawan, dan oleh karena itu, kami mengembangkan aplikasi ini untuk memenuhi kebutuhan tersebut.'
              'Kami terus berinovasi dan mengembangkan fitur-fitur baru untuk memastikan Anda mendapatkan pengalaman terbaik saat menjelajahi Bali. Dengan DewatAnv, Anda tidak hanya mendapatkan informasi terkini, tetapi juga dapat menyimpan destinasi favorit Anda, mengikuti perkembangan terbaru, dan merencanakan perjalanan dengan lebih baik.',
            ),
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

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
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
          'Our Team: DewatAnv', // Ubah judul app bar
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
            _buildSectionTitle('Our Team'),
            const SizedBox(height: 8),
            _buildTeamMember(context, 'Enilia Utari', 'CEO • Founder',
                'Sebagai Chief Executive Officer, Enilia adalah pemimpin utama yang mengarahkan visi dan strategi DewatAnv. Dengan keahlian yang luas di bidang manajemen dan pengalaman yang kaya dalam industri pariwisata, Enilia memastikan bahwa DewatAnv terus berkembang dan memberikan layanan yang terbaik untuk para penggunanya. Enilia berfokus pada pengembangan bisnis dan inovasi untuk menjadikan DewatAnv sebagai platform unggulan di industri pariwisata digital.'),
            _buildTeamMember(context, 'Angga Pratama', 'CIO • Co-Founder',
                'Sebagai Chief Information Officer, Angga bertanggung jawab atas seluruh infrastruktur teknologi DewatAnv. Dengan latar belakang yang kuat dalam teknologi informasi dan pengalaman dalam pengembangan aplikasi, Angga memimpin tim IT untuk memastikan bahwa platform DewatAnv berjalan dengan lancar, aman, dan selalu up-to-date dengan teknologi terbaru. Angga juga berfokus pada pengembangan solusi teknis yang inovatif untuk meningkatkan pengalaman pengguna.'),
            _buildTeamMember(context, 'Restha Aristita', 'CFO • Co-Founder',
                'Restha memegang peran penting sebagai Chief Financial Officer, mengawasi semua aspek keuangan perusahaan. Dengan keahlian yang mendalam dalam manajemen keuangan dan akuntansi, Restha memastikan bahwa DewatAnv memiliki dasar keuangan yang kokoh dan mampu mendukung pertumbuhan berkelanjutan. Restha bertugas untuk mengelola anggaran, merencanakan keuangan jangka panjang, serta mengawasi arus kas dan investasi perusahaan.'),
            _buildTeamMember(context, 'Dewa Aditya', 'CMO • Co-Founder',
                'Dewa adalah Chief Marketing Officer yang bertanggung jawab untuk merancang dan mengimplementasikan strategi pemasaran DewatAnv. Dengan keterampilan yang unggul dalam branding, pemasaran digital, dan komunikasi, Dewa memastikan bahwa DewatAnv terus menarik pengguna baru dan membangun hubungan yang kuat dengan komunitas pengguna. Dewa fokus pada pengembangan kampanye pemasaran yang efektif untuk memperluas jangkauan dan memperkuat posisi DewatAnv di pasar.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Tentang Kami'),
            const SizedBox(height: 8),
            const Text(
              'Tim DewatAnv adalah kombinasi dari profesional yang berdedikasi tinggi di berbagai bidang. Dengan pengalaman yang beragam dan keahlian yang komprehensif, kami bekerja bersama untuk memberikan solusi terbaik bagi pengguna kami, memungkinkan mereka untuk menjelajahi keindahan Bali dengan mudah dan nyaman. Kami berkomitmen untuk terus berinovasi dan memberikan layanan yang memenuhi kebutuhan wisatawan.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kami menghargai setiap masukan dan saran dari pengguna, karena hal itu membantu kami untuk terus memperbaiki dan mengembangkan aplikasi ini. Terima kasih telah menjadi bagian dari perjalanan kami di DewatAnv.',
              style: TextStyle(fontSize: 16),
            ),
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


  Widget _buildTeamMember(BuildContext context, String name, String position, String responsibility) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name\n$position',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            responsibility,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
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
          'Contact Us',
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
            _buildSectionTitle('Kontak Kami'),
            const SizedBox(height: 8),
            _buildContactRow(context, 'Email:', 'support@dewatAnv.com'),
            _buildContactRow(context, 'Telepon:', '+62 123 4567 890'),
            _buildContactRow(context, 'Alamat:', 'Jl. Sunset Road No.88, Kuta, Bali, Indonesia'),
            const SizedBox(height: 16),
            _buildSectionTitle('Ikuti kami di media sosial untuk mendapatkan update terbaru dan tips wisata:'),
            const SizedBox(height: 8),
            _buildContactRow(context, 'Instagram:', '@dewatAnv'),
            _buildContactRow(context, 'Facebook:', 'facebook.com/dewatAnv'),
            _buildContactRow(context, 'Twitter:', '@dewatAnv'),
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

  Widget _buildContactRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
