import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detailCategory extends StatefulWidget {
  const detailCategory({ Key? key }) : super(key: key);

  @override
  _detailCategoryState createState() => _detailCategoryState();
}

class _detailCategoryState extends State<detailCategory> {
  Future<List<Wisata>>? _wisata;

  // @override
  // void initState() {
  //   super.initState();
  //   _wisata = DataService.fetchwisata();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Wisata>>(
            future: _wisata,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final data = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0, // Make the aspect ratio 1:1 for square cards
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return GestureDetector(
                      // onTap: () {
                      //   // Navigasi ke screen yang sesuai dengan idkategori
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => DENPASAR(idkategori: item.idkategori),
                      //     ),
                      //   );
                      // },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                                // child: Image.network(
                                //   item.gambar,
                                //   fit: BoxFit.cover,
                                //   width: double.infinity,
                                //   height: double.infinity, // Ensure the image fills the space
                                // ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.1),
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15.0)),
                              ),
                              child: Text(
                                item.nama,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.pacifico(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 54, 40, 176),
      //   tooltip: 'Increment',
      //   onPressed: () {
      //     // Navigator.pushNamed(context, '/form-screen');
      //     // BottomUpRoute(page: const FormScreen());
      //     Navigator.push(context, BottomUpRoute(page: const UtsPostScreen()));
      //   },
      //   child: const Icon(Icons.add, color: Colors.white, size: 28),
      // ),
    );
  }
}