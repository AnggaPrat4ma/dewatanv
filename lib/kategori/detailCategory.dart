// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:dewatanv/components/bottom_up_transition.dart';
import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/kategori/detailWisata.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dewatanv/form_crete.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WisataScreen extends StatefulWidget {
  final int idKategori;
  final String namaKategori;

  const WisataScreen(
      {super.key, required this.idKategori, required this.namaKategori});

  @override
  // ignore: library_private_types_in_public_api
  _WisataScreenState createState() => _WisataScreenState();
}

class _WisataScreenState extends State<WisataScreen> {
  late Future<List<Wisata>> futureWisata;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    futureWisata =
        DataService.fetchWisataByCategory(widget.idKategori, currentPage);
  }

  void _fetchPage(int page) {
    setState(() {
      currentPage = page;
      futureWisata =
          DataService.fetchWisataByCategory(widget.idKategori, currentPage);
    });
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
      ),
      body: FutureBuilder<List<Wisata>>(
        future: futureWisata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final wisataList = snapshot.data!;
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:
                              0.7, // Adjust as needed to ensure a single row
                        ),
                        itemCount: wisataList.length,
                        itemBuilder: (context, index) {
                          final wisata = wisataList[index];
                          //final imageUrl =
                              //'${Endpoints.baseUrl}/static/${wisata.gambar}';
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WisataDetailScreen(wisata: wisata),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      wisata.gambar,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 120,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          wisata.nama,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            RatingBar(
                                              minRating: 1,
                                              maxRating: 5,
                                              ignoreGestures: true,
                                              allowHalfRating: false,
                                              initialRating:
                                                  wisata.rating.toDouble(),
                                              itemSize: 18.0,
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
                                              onRatingUpdate:
                                                  (double ratings) {},
                                            ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          color: Colors.blue.withOpacity(0.1),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            wisata.deskripsi,
                                            maxLines: 2, // Limit to two lines
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: currentPage > 1
                                ? () => _fetchPage(currentPage - 1)
                                : null,
                            child: const Text('Previous'),
                          ),
                          ElevatedButton(
                            onPressed: () => _fetchPage(currentPage + 1),
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final role = state.role;
                    if (role == 'admin') {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 54, 40, 176),
                            tooltip: 'Increment',
                            onPressed: () {
                              Navigator.push(
                                context,
                                BottomUpRoute(
                                  page: CreateWisataScreen(
                                      idKategori: widget.idKategori),
                                ),
                              );
                            },
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 28),
                          ),
                        ),
                      );
                    }
                    return Container(); // Return an empty container if the user is not an admin
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
