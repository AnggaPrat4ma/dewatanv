import 'package:dewatanv/components/bottom_up_transition.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/form_crete.dart';
import 'package:dewatanv/form_update.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WisataListScreen extends StatefulWidget {
  final int idKategori;
  final String namaKategori;
  final Wisata? wisata;

  WisataListScreen({required this.idKategori, required this.namaKategori, this.wisata});

  @override
  _WisataListScreenState createState() => _WisataListScreenState();
}

class _WisataListScreenState extends State<WisataListScreen> {
  late Future<List<Wisata>> _wisataFuture;
  static const googlePlex = LatLng(37.4223, -122.0848);
  int _currentIndex = 0;
  LatLng? curentWisata;

  @override
  void initState() {
    super.initState();
    _wisataFuture = DataService.fetchWisataByCategory(widget.idKategori);
    _wisataFuture.then((wisataList) {
      if (wisataList.isNotEmpty) {
        _updateCurrentWisataPosition(wisataList[_currentIndex]);
      }
    });
  }

  void refresh() {
    _wisataFuture = DataService.fetchWisataByCategory(widget.idKategori);
  }

  void _updateCurrentWisataPosition(Wisata currentWisata) {
    if (currentWisata.Latitude != null && currentWisata.Longtitude != null) {
      setState(() {
        curentWisata = LatLng(currentWisata.Latitude!, currentWisata.Longtitude!);
      });
    } else {
      setState(() {
        curentWisata = null;
      });
    }
  }

  void _navigateToNext(List<Wisata> wisataList) {
    if (_currentIndex < wisataList.length - 1) {
      setState(() {
        _currentIndex++;
        _updateCurrentWisataPosition(wisataList[_currentIndex]);
      });
    }
  }

  void _navigateToPrevious(List<Wisata> wisataList) {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _updateCurrentWisataPosition(wisataList[_currentIndex]);
      });
    }
  }

  void _deleteWisata(int id) {
    // Call the delete API
    // DataService.deleteWisata(id).then((success) {
    //   if (success) {
    //     setState(() {
    //       _wisataFuture = DataService.fetchWisataByCategory(widget.idKategori);
    //       if (_currentIndex >= 1) _currentIndex--; // Move to previous item if possible
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Wisata deleted successfully')),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Failed to delete wisata')),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.namaKategori,
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 129, 209),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                BottomUpRoute(page: CreateWisataScreen(idKategori: widget.idKategori)),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Wisata>>(
        future: _wisataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No wisata available.'));
          } else {
            final wisataList = snapshot.data!;
            final wisata = wisataList[_currentIndex];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        wisata.gambar != null
                            ? Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    '${Endpoints.uas}/static/${wisata.gambar}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading image: $error');
                                      return const Icon(Icons.error, size: 50);
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, size: 50, color: Colors.white),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          wisata.nama,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            BottomUpRoute(page: UpdateWisataScreen(idwisata: widget.idKategori)),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          _deleteWisata(wisata.idwisata);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    wisata.deskripsi,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            '${wisata.rating}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Category: ${wisata.idkategori}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (curentWisata != null)
                                    SizedBox(
                                      height: 200,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(target: curentWisata!, zoom: 14),
                                        markers: {
                                          Marker(
                                            markerId: const MarkerId('location'),
                                            position: curentWisata!,
                                            icon: BitmapDescriptor.defaultMarker,
                                          )
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _currentIndex > 0 ? () {
                          _navigateToPrevious(wisataList);
                          refresh();
                        } : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: _currentIndex < wisataList.length - 1 ? () { 
                          _navigateToNext(wisataList);
                          refresh();
                        } : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
