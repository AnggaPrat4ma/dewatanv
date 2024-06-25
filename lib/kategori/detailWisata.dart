// import 'package:dewatanv/components/bottom_up_transition.dart';
// import 'package:dewatanv/dto/wisata.dart';
// import 'package:dewatanv/endpoints/endpoints.dart';
// import 'package:dewatanv/form_update.dart';
// import 'package:dewatanv/services/data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class WisataListScreen extends StatefulWidget {
//   final int idwisata;
//   final String nama;

//   WisataListScreen({required this.idwisata, required this.nama});

//   @override
//   _WisataListScreenState createState() => _WisataListScreenState();
// }

// class _WisataListScreenState extends State<WisataListScreen> {
//   late Future<Wisata> _wisataFuture;
//   static const googlePlex = LatLng(37.4223, -122.0848);

//   @override
//   void initState() {
//     super.initState();
//     _wisataFuture = DataService.fetchWisataById(widget.idwisata);
//   }

//   void refresh() {
//     setState(() {
//       _wisataFuture = DataService.fetchWisataById(widget.idwisata);
//     });
//   }

//   void _deleteWisata(int idwisata) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Konfirmasi"),
//         content: const Text("Apakah Anda yakin ingin menghapus postingan ini?"),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               try {
//                 await DataService.deleteWisata(idwisata);
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.red,
//                     content: Text('Data berhasil dihapus!'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//                 refresh();
//               } catch (error) {
//                 debugPrint('Gagal menghapus data: $error');
//               }
//             },
//             child: const Text('Ya'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Tidak'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.nama,
//           style: GoogleFonts.pacifico(
//             color: Colors.white,
//             fontSize: 30,
//           ),),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 30, 129, 209),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: FutureBuilder<Wisata?>(
//         future: _wisataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.hasData){
//             final wisata = snapshot.data!;
//             LatLng? curentWisata;
//             if (wisata.Latitude != null && wisata.Longtitude != null) {
//               curentWisata = LatLng(wisata.Latitude!, wisata.Longtitude!);
//             }
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 elevation: 5.0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       wisata.gambar != null
//                           ? Container(
//                               height: 200,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 10.0,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 child: Image.network(
//                                   '${Endpoints.uas}/static/${wisata.gambar}',
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     print('Error loading image: $error');
//                                     return const Icon(Icons.error, size: 50);
//                                   },
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               height: 200,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 10.0,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: const Center(
//                                 child: Icon(Icons.image, size: 50, color: Colors.white),
//                               ),
//                             ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     wisata.nama,
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.edit, color: Colors.blue),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       BottomUpRoute(page: UpdateWisataScreen(wisata: wisata)),
//                                     ).then((_) => refresh());
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () {
//                                     _deleteWisata(wisata.idwisata);
//                                   },
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8.0),
//                             Text(
//                               wisata.deskripsi,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     RatingBarIndicator(
//                                       rating: wisata.rating.toDouble(),
//                                       itemBuilder: (context, index) => const Icon(
//                                         Icons.star,
//                                         color: Colors.amber,
//                                       ),
//                                       itemCount: 5,
//                                       itemSize: 24.0,
//                                       direction: Axis.horizontal,
//                                     ),
//                                     const SizedBox(width: 8.0),
//                                   ],
//                                 ),
//                                 Text(
//                                   'Category: ${wisata.idkategori}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (curentWisata != null)
//                               SizedBox(
//                                 height: 200,
//                                 child: GoogleMap(
//                                   initialCameraPosition: CameraPosition(target: curentWisata, zoom: 14),
//                                   markers: {
//                                     Marker(
//                                       markerId: const MarkerId('location'),
//                                       position: curentWisata,
//                                       icon: BitmapDescriptor.defaultMarker,
//                                     )
//                                   },
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('${snapshot.error}'));
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

// import 'package:dewatanv/components/bottom_up_transition.dart';
// import 'package:dewatanv/form_update.dart';
// import 'package:dewatanv/services/data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:dewatanv/dto/wisata.dart';
// import 'package:dewatanv/endpoints/endpoints.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';

// class WisataDetailScreen extends StatelessWidget {
//   final Wisata wisata;

//   WisataDetailScreen({required this.wisata});

//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = '${Endpoints.uas}/static/${wisata.gambar}';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           wisata.nama,
//           style: GoogleFonts.pacifico(
//             color: Colors.white,
//             fontSize: 30,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 30, 129, 209),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200,
//                 errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 100),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     wisata.nama,
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.edit, color: Colors.blue),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       BottomUpRoute(page: UpdateWisataScreen(wisata: wisata)),
//                                     ).then((_) => refresh());
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () {
//                                     _deleteWisata(wisata.idwisata);
//                                   },
//                                 ),
//                               ],
//                             ),
//             const SizedBox(height: 10),
//             RatingBar(
//               minRating: 1,
//               maxRating: 5,
//               ignoreGestures: true,
//               allowHalfRating: false,
//               initialRating: wisata.rating.toDouble(),
//               itemSize: 20.0,
//               ratingWidget: RatingWidget(
//                 full: const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 half: const Icon(
//                   Icons.star_half,
//                   color: Colors.amber,
//                 ),
//                 empty: const Icon(
//                   Icons.star_border,
//                   color: Colors.amber,
//                 ),
//               ),
//               onRatingUpdate: (double ratings) {},
//             ),
//             const SizedBox(height: 10),
//             Text(
//               wisata.deskripsi,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
