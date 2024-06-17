import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
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
    futureWisata = DataService.fetchwisata(widget.idKategori);
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint(widget.idKategori.toString());
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Wisata> wisataList = snapshot.data!;
            return ListView.builder(
              itemCount: wisataList.length,
              itemBuilder: (context, index) {
                final wisata = wisataList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (wisata.gambar != null) 
                        Image.network(
                          Uri.parse('${Endpoints.uas}/static/${wisata.gambar}').toString()
                        )
                      else
                        Container(height: 200, color: Colors.grey), // Placeholder for missing image
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          wisata.nama,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(wisata.deskripsi),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
