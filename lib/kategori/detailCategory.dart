import 'package:dewatanv/components/bottom_up_transition.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/form_crete.dart';
import 'package:dewatanv/kategori/detailWisata.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';

class WisataScreen extends StatefulWidget {
  final int idKategori;

  WisataScreen({required this.idKategori});

  @override
  _WisataScreenState createState() => _WisataScreenState();
}

class _WisataScreenState extends State<WisataScreen> {
  late Future<List<Wisata>> futureWisata;

  @override
  void initState() {
    super.initState();
    futureWisata = DataService.fetchWisataByCategory(widget.idKategori);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: FutureBuilder<List<Wisata>>(
        future: futureWisata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final wisataList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Adjust as needed
              ),
              itemCount: wisataList.length,
              itemBuilder: (context, index) {
                final wisata = wisataList[index];
                final imageUrl = '${Endpoints.uas}/static/${wisata.gambar}';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WisataScreendetail(idwisata: wisata.idwisata)),
                    );
                  },
                  child:  Card(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          wisata.nama,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          wisata.deskripsi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 54, 40, 176),
        tooltip: 'Increment',
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: CreateWisataScreen(idKategori: widget.idKategori)));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
