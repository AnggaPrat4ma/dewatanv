
import 'package:dewatanv/endpoints/endpoints.dart';

class Wisata {
  final int idwisata;
  final String nama;
  final String deskripsi;
  final String gambar;
  final int rating;
  final int idkategori;
  final double latitude;
  final double longtitude;

  Wisata({
    required this.idwisata,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.rating,
    required this.idkategori,
    required this.latitude,
    required this.longtitude
  });

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
      idwisata: json['id_wisata'] as int,
      nama: json['nama_wisata'] as String,
      deskripsi: json['deskripsi'] as String,
      gambar: json['gambar'] != null
          ? '${Endpoints.baseUrl}/static/${json['gambar']}'
          : 'https://via.placeholder.com/150',
      rating: json['rating_wisata'] as int,
      idkategori: json['id_kategori'] as int,
      latitude: double.parse(json['Latitude'] as String),
      longtitude: double.parse(json['Longtitude'] as String),
  );


}