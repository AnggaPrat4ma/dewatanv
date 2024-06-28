import 'package:dewatanv/dto/profile.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({required this.akun, super.key});
  final Akun akun;

  @override
  // ignore: library_private_types_in_public_api
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController _namaController;
  late TextEditingController _lokasiController;
  File? _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.akun.namaUser);
    _lokasiController = TextEditingController(text: widget.akun.lokasi);
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
        Uri.parse('${Endpoints.akun}/update/${widget.akun.idUser}'));
      request.fields['nama_wisata'] = _namaController.text;
      request.fields['lokasi'] = _lokasiController.text;

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
    _lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _lokasiController,
                    decoration: const InputDecoration(
                      labelText: 'Lokasi',
                      hintText: 'Provinsi/Negara'
                    ),
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
                            : widget.akun.gambar.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${Endpoints.baseUrl}/static/${widget.akun.gambar}",
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
