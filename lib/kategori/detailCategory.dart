// import 'package:dewatanv/components/bottom_up_transition.dart';
// import 'package:dewatanv/dto/wisata.dart';
// import 'package:dewatanv/endpoints/endpoints.dart';
// import 'package:dewatanv/kategori/detailWisata.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:dewatanv/form_crete.dart';
// import 'package:dewatanv/services/data_service.dart';
// import 'package:flutter/material.dart';

// class WisataScreen extends StatefulWidget {
//   final int idKategori;
//   final String namaKategori;

//   WisataScreen({required this.idKategori, required this.namaKategori});

//   @override
//   _WisataScreenState createState() => _WisataScreenState();
// }

// class _WisataScreenState extends State<WisataScreen> {
//   late Future<List<Wisata>> futureWisata;

//   @override
//   void initState() {
//     super.initState();
//     futureWisata = DataService.fetchWisataByCategory(widget.idKategori);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.namaKategori),
//       ),
//       body: FutureBuilder<List<Wisata>>(
//         future: futureWisata,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final wisataList = snapshot.data!;
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of columns
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//                 childAspectRatio: 2.5, // Adjust as needed to ensure a single row
//               ),
//               itemCount: wisataList.length,
//               itemBuilder: (context, index) {
//                 final wisata = wisataList[index];
//                 final imageUrl = '${Endpoints.uas}/static/${wisata.gambar}';
//                 return GestureDetector(
//                   child: Card(
//                     margin: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         Image.network(
//                           imageUrl,
//                           fit: BoxFit.cover,
//                           width: 100,
//                           height: 100,
//                           errorBuilder: (context, error, stackTrace) =>
//                               const Icon(Icons.error),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   wisata.nama,
//                                   style: const TextStyle(
//                                       fontSize: 16, fontWeight: FontWeight.bold),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 RatingBar(
//                                   minRating: 1,
//                                   maxRating: 5,
//                                   ignoreGestures: true,
//                                   allowHalfRating: false,
//                                   initialRating: wisata.rating.toDouble(),
//                                   itemSize: 15.0,
//                                   ratingWidget: RatingWidget(
//                                     full: const Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     half: const Icon(
//                                       Icons.star_half,
//                                       color: Colors.amber,
//                                     ),
//                                     empty: const Icon(
//                                       Icons.star_border,
//                                       color: Colors.amber,
//                                     ),
//                                   ),
//                                   onRatingUpdate: (double ratings) {},
//                                 ),
//                                 Text(
//                                   wisata.deskripsi,
//                                   maxLines: 1, // Limit to one line
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },

//           } else if (snapshot.hasError) {
//             return Center(child: Text('${snapshot.error}'));
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromARGB(255, 54, 40, 176),
//         tooltip: 'Increment',
//         onPressed: () {
//           Navigator.push(context, BottomUpRoute(page: CreateWisataScreen(idKategori: widget.idKategori)));
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//     );
//   }
// }
