import 'package:dewatanv/dto/data_wisata.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:video_player/video_player.dart';

class WisataScreendetail extends StatefulWidget {
  final int idwisata;

  WisataScreendetail({required this.idwisata});

  @override
  _WisataScreendetailState createState() => _WisataScreendetailState();
}

class _WisataScreendetailState extends State<WisataScreendetail> {
  Future<DataWisata?>? _wisataFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   _wisataFuture = DataService.getWisataById(widget.idwisata);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Wisata'),
      ),
      body: FutureBuilder<DataWisata?>(
        future: _wisataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final wisata = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (wisata.gambar != null)
                    Image.network(wisata.gambar!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      wisata.nama,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(wisata.deskripsi),
                  ),
                  if (wisata.video != null)
                    FlickVideoPlayer(
                      flickManager: FlickManager(
                        videoPlayerController:
                            VideoPlayerController.network(wisata.video!),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rating: ${wisata.rating}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Kategori ID: ${wisata.idkategori}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _parseLatLng(wisata.maps),
                          zoom: 14.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(wisata.idwisata.toString()),
                            position: _parseLatLng(wisata.maps),
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  LatLng _parseLatLng(String maps) {
    final parts = maps.split(',');
    final lat = double.parse(parts[0]);
    final lng = double.parse(parts[1]);
    return LatLng(lat, lng);
  }
}
