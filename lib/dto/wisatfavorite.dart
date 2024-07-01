import 'package:dewatanv/endpoints/endpoints.dart';

class Wisatafavorit{
  final int idWisataFavorite;
  final int idUser;
  final int idwisata;
  final String nama;
  final String deskripsi;
  final String gambar;
  final int rating;

  Wisatafavorit({
    required this.idWisataFavorite,
    required this.idUser,
    required this.idwisata,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.rating,
  });

  factory Wisatafavorit.fromJson(Map<String, dynamic> json) {
    return Wisatafavorit(
      idWisataFavorite: json['id_wisata_favorit'] ?? 0,
      idUser: json['id_user'] ?? 0,
      idwisata: json['id_wisata'] ?? 0,
      gambar: json['gambar'] != null
          ? '${Endpoints.baseUrl}/static/${json['gambar']}'
          : 'https://via.placeholder.com/150',
      nama: json['nama_wisata'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      rating: json['rating_wisata'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_wista_favorite': idWisataFavorite,
      'id_user': idUser,
      'id_wisata': idwisata,
      'gambar': gambar,
      'nama_wisata': nama,
      'deskripsi': deskripsi,
      'rating_wisata': rating
    };
  }
}