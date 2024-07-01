// ignore_for_file: file_names

import 'package:dewatanv/components/bottom_up_transition.dart';
import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/form_update.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:dewatanv/dto/wisata.dart';
//import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WisataDetailScreen extends StatefulWidget {
  final Wisata wisata;

  const WisataDetailScreen({super.key, required this.wisata});

  @override
  // ignore: library_private_types_in_public_api
  _WisataDetailScreenState createState() => _WisataDetailScreenState();
}

class _WisataDetailScreenState extends State<WisataDetailScreen> {
  late LatLng curentWisata;
  late Future<List<Wisata>> wisataFuture;

  @override
  void initState() {
    super.initState();
    curentWisata = LatLng(widget.wisata.latitude, widget.wisata.longtitude);
  }

  void refresh() {
    setState(() {
      wisataFuture =
          DataService.fetchWisataByCategory(widget.wisata.idkategori, 2);
    });
  }

  void _toggleFavorite() async {
    final authState = context.read<AuthCubit>().state;
    final userId = authState.idUser; // Ambil id pengguna dari state cubit

    try {
      // Panggil metode untuk menambah atau menghapus favorit sesuai kondisi
      if (authState.isFavoriteList
          .contains(widget.wisata.idwisata.toString())) {
        await DataService.removeFavorite(userId, widget.wisata.idwisata);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red, // Ubah ke warna merah untuk menghapus
            content: Text('Wisata dihapus dari favorit!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        await DataService.addFavorite(userId, widget.wisata.idwisata);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green, // Ubah ke warna hijau untuk menambah
            content: Text('Wisata ditambahkan ke favorit!'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Refresh data atau lakukan tindakan sesuai kebutuhan
      // ignore: use_build_context_synchronously
      context
          .read<AuthCubit>()
          .toggleFavorite(widget.wisata.idwisata.toString());
    } catch (error) {
      // Tangani kesalahan jika operasi gagal
      debugPrint('Gagal mengubah status favorit: $error');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Operasi gagal, coba lagi nanti.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteWisata(int idwisata) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menghapus postingan ini?"),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await DataService.deleteWisata(idwisata);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                refresh();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Data berhasil dihapus!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (error) {
                debugPrint('Gagal menghapus data: $error');
              }
            },
            child: const Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tidak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final imageUrl = '${Endpoints.baseUrl}/static/${widget.wisata.gambar}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.wisata.nama,
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
            Stack(
              children: [
                Image.network(
                  widget.wisata.gambar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100),
                ),
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    widget.wisata.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                RatingBar(
                  minRating: 1,
                  maxRating: 5,
                  ignoreGestures: true,
                  allowHalfRating: false,
                  initialRating: widget.wisata.rating.toDouble(),
                  itemSize: 24.0,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty: const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                    ),
                  ),
                  onRatingUpdate: (double ratings) {},
                ),
                const Spacer(),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final role = state.role;
                    if (role == 'admin') {
                      return Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                BottomUpRoute(
                                    page: UpdateWisataScreen(
                                        wisata: widget.wisata)),
                              ).then((_) => refresh());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteWisata(widget.wisata.idwisata),
                          ),
                        ],
                      );
                    } else {
                      final isFavorite = state.isFavoriteList
                          .contains(widget.wisata.idwisata.toString());
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: isFavorite ? Colors.blue : Colors.grey,
                          size: 40,
                        ),
                        onPressed: _toggleFavorite,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.wisata.deskripsi,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lokasi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(widget.wisata.latitude, widget.wisata.longtitude),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(widget.wisata.idwisata.toString()),
                    position: LatLng(
                        widget.wisata.latitude, widget.wisata.longtitude),
                    infoWindow: InfoWindow(title: widget.wisata.nama),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
