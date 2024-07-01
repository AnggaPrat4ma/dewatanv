// ignore_for_file: use_build_context_synchronously

import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CreateWisataScreen extends StatefulWidget {
  const CreateWisataScreen({super.key, required this.idKategori});
  final int idKategori;

  @override
  // ignore: library_private_types_in_public_api
  _CreateWisataScreenState createState() => _CreateWisataScreenState();
}

class _CreateWisataScreenState extends State<CreateWisataScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longtitudeController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  double rating = 0;

  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await _picker.pickImage(source: img);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  Future<void> _submitForm() async {
    // Validasi semua field terisi
    if (_namaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _latitudeController.text.isEmpty ||
        _longtitudeController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Endpoints.wisata}/create'),
    );

    request.fields['nama_wisata'] = _namaController.text;
    request.fields['deskripsi'] = _deskripsiController.text;
    request.fields['rating_wisata'] = rating.toString();
    request.fields['Latitude'] = _latitudeController.text;
    request.fields['Longtitude'] = _longtitudeController.text;
    request.fields['id_kategori'] = widget.idKategori.toString();

    request.files.add(await http.MultipartFile.fromPath('gambar', _image!.path));

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create Wisata')),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _latitudeController.dispose();
    _longtitudeController.dispose();
    super.dispose();
  }

  void ratingUpdate(double userRating) {
    setState(() {
      rating = userRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Wisata',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 28,
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
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Wisata',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 30, 129, 209)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                prefixIcon: const Icon(Icons.place, color: Color.fromARGB(255, 30, 129, 209)),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 30, 129, 209)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                prefixIcon: const Icon(Icons.description, color: Color.fromARGB(255, 30, 129, 209)),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(
                labelText: 'Latitude',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 30, 129, 209)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                prefixIcon: const Icon(Icons.map, color: Color.fromARGB(255, 30, 129, 209)),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _longtitudeController,
              decoration: InputDecoration(
                labelText: 'Longitude',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 30, 129, 209)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 30, 129, 209)),
                ),
                prefixIcon: const Icon(Icons.map_outlined, color: Color.fromARGB(255, 30, 129, 209)),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Rating:',
              style: TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 30, 129, 209)),
            ),
            const SizedBox(height: 8.0),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: ratingUpdate,
            ),
            const SizedBox(height: 16.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context: context);
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                          size: 50,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 129, 209),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
