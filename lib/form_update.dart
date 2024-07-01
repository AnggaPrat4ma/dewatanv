import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UpdateWisataScreen extends StatefulWidget {
  const UpdateWisataScreen({required this.wisata, super.key});
  final Wisata wisata;

  @override
  // ignore: library_private_types_in_public_api
  _UpdateWisataScreenState createState() => _UpdateWisataScreenState();
}

class _UpdateWisataScreenState extends State<UpdateWisataScreen> {
  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;
  late TextEditingController _latitudeController;
  late TextEditingController _longtitudeController;
  File? _image;
  final _picker = ImagePicker();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.wisata.nama);
    _deskripsiController = TextEditingController(text: widget.wisata.deskripsi);
    _latitudeController = TextEditingController(text: widget.wisata.latitude.toString());
    _longtitudeController = TextEditingController(text: widget.wisata.longtitude.toString());
    rating = 0;
  }

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

  Future<void> _updateDataWithImage(BuildContext context) async {
    try {
      var request = http.MultipartRequest('PUT',
        Uri.parse('${Endpoints.wisata}/update/${widget.wisata.idwisata}'));
      request.fields['nama_wisata'] = _namaController.text;
      request.fields['deskripsi'] = _deskripsiController.text;
      request.fields['rating_wisata'] = rating.toString();
      request.fields['Latitude'] = _latitudeController.text;
      request.fields['Longtitude'] = _longtitudeController.text;

      if (_image != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'gambar', _image!.path);
        request.files.add(multipartFile);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update Wisata')),
        );
      }
    } catch (e) {
      if (e is http.ClientException) {
        debugPrint('ClientException: ${e.message}');
      } else if (e is SocketException) {
        debugPrint('SocketException: ${e.message}');
      } else {
        debugPrint('Exception: ${e.toString()}');
      }
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
        title: const Text('Update Wisata'),
      ),
      body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Wisata',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _deskripsiController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _latitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _longtitudeController,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16.0),
                  ),
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
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : widget.wisata.gambar.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.wisata.gambar,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                    Text(
                                      'Pick your Image here',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: const Color.fromARGB(255, 124, 122, 122),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {_updateDataWithImage(context);}, 
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
