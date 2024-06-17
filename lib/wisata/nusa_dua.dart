import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:video_player/video_player.dart';

class NusaDua extends StatefulWidget {
  const NusaDua({Key? key}) : super(key: key);

  @override
  _NusaDuaState createState() => _NusaDuaState();
}

class _NusaDuaState extends State<NusaDua> {
  final PageController _pageController = PageController();
  final LatLng _initialPosition = LatLng(-8.6717348, 115.2313271); // Coordinate for Monumen Bajra Sandhi
  final double aspectRatio = 16 / 9;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset("assets/images/mars_undiksha.mp4")
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monumen Bajra Sandhi'),
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: PageView(
                controller: _pageController,
                children: [
                  AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Image.asset(
                      'assets/images/bajra2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: aspectRatio,
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 30, 129, 209),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Monumen Bajra Sandhi di Denpasar, Bali, adalah landmark yang mengesankan, menjulang setinggi 45 meter dan berbentuk seperti lonceng upacara Hindu. Diresmikan oleh Presiden Megawati pada 2003, monumen ini menghormati perjuangan rakyat Bali dengan arsitektur memukau dan arca-arca bersejarah. Terletak di taman indah Lapangan Puputan Renon, Bajra Sandhi menawarkan wisatawan pemandangan spektakuler dan wawasan mendalam tentang budaya Bali, menjadikannya destinasi yang tidak boleh dilewatkan.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Jam Operasional',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 30, 129, 209),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Senin - Jumat: 08:00 - 18:00\nSabtu: 09:00 - 17:00\nMinggu: 10:00 - 17:00\nTanggal Merah: 09:00 - 17:00',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Maps',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 30, 129, 209),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 14.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('MonumenBajraSandhi'),
                            position: _initialPosition,
                            infoWindow: InfoWindow(title: 'Monumen Bajra Sandhi'),
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
