// import 'package:dewatanv/endpoints/endpoints.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UpdateWisataScreen extends StatefulWidget {
//   const UpdateWisataScreen({Key? key, required this.idwisata}) : super(key: key);
//   final int idwisata;

//   @override
//   _UpdateWisataScreenState createState() => _UpdateWisataScreenState();
// }

// class _UpdateWisataScreenState extends State<UpdateWisataScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String nama = '';
//   String deskripsi = '';
//   String maps = '';
//   int idkategori = 0;
//   File? _image;


//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   void initState() {
//     super.initState();
    
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       if (_image == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please select both an image and a video')),
//         );
//         return;
//       }

//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse('${Endpoints.wisata}/create${widget.idwisata}'),
//       );

//       request.fields['nama_wisata'] = nama;
//       request.fields['deskripsi'] = deskripsi;
//       request.fields['rating_wisata'] = rating.toString();
//       request.fields['maps'] = maps;
//       request.fields['id_kategori'] = idKategori.toString();

//       request.files.add(await http.MultipartFile.fromPath('gambar', _image!.path));
//       //request.files.add(await http.MultipartFile.fromPath('video', _video!.path));

//       final response = await request.send();

//       if (response.statusCode == 201) {
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to create Wisata')),
//         );
//       }
//     }
//   }

//   double rating = 0;
//   void ratingUpdate(double userRating) {
//     setState(() {
//       rating = userRating;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Wisata'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Nama Wisata'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   nama = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Deskripsi'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   deskripsi = value!;
//                 },
//               ),
//               RatingBar(
//                 minRating: 1,
//                 maxRating: 5,
//                 allowHalfRating: false,
//                 ratingWidget: RatingWidget(
//                   full: const Icon(
//                     Icons.star,
//                     color: Color.fromARGB(255, 0, 170, 255),
//                   ),
//                   half: const Icon(
//                     Icons.star_half,
//                     color: Color.fromARGB(255, 0, 170, 255),
//                   ),
//                   empty: const Icon(
//                     Icons.star_border,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//                 onRatingUpdate: ratingUpdate,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Maps'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a maps URL';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   maps = value!;
//                 },
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: const Text('Pick Image'),
//               ),
//               if (_image != null)
//                 Image.file(
//                   _image!,
//                   height: 100,
//                   width: 100,
//                 ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Update Wisata'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateWisataScreen extends StatefulWidget {
  const UpdateWisataScreen({Key? key, required this.idwisata}) : super(key: key);
  final int idwisata;

  @override
  _UpdateWisataScreenState createState() => _UpdateWisataScreenState();
}

class _UpdateWisataScreenState extends State<UpdateWisataScreen> {
  final _formKey = GlobalKey<FormState>();
  String nama = '';
  String deskripsi = '';
  String maps = '';
  int idkategori = 0;
  File? _image;
  double rating = 0.0;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchWisataDetails();
  }

  Future<void> _fetchWisataDetails() async {
    final response = await http.get(Uri.parse('${Endpoints.wisata}/${widget.idwisata}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        nama = data['nama_wisata'];
        deskripsi = data['deskripsi'];
        maps = data['maps'];
        idkategori = data['id_kategori'];
        rating = data['rating_wisata'].toDouble();
        // If you have image URL, you can set _image to that path. This depends on your implementation.
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch Wisata details')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('${Endpoints.wisata}/update/${widget.idwisata}'),
      );

      request.fields['nama_wisata'] = nama;
      request.fields['deskripsi'] = deskripsi;
      request.fields['rating_wisata'] = rating.toString();
      request.fields['maps'] = maps;
      request.fields['id_kategori'] = idkategori.toString();

      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath('gambar', _image!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update Wisata')),
        );
      }
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: nama,
                decoration: const InputDecoration(labelText: 'Nama Wisata'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  nama = value!;
                },
              ),
              TextFormField(
                initialValue: deskripsi,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  deskripsi = value!;
                },
              ),
              RatingBar(
                initialRating: rating,
                minRating: 1,
                maxRating: 5,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 0, 170, 255),
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Color.fromARGB(255, 0, 170, 255),
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: Colors.blueGrey,
                  ),
                ),
                onRatingUpdate: ratingUpdate,
              ),
              TextFormField(
                initialValue: maps,
                decoration: const InputDecoration(labelText: 'Maps'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a maps URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  maps = value!;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              if (_image != null)
                Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Update Wisata'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
