
class Wisata {
  final int idwisata;
  final String nama;
  final String deskripsi;
  final String? gambar;
  final int rating;
  final int idkategori;
  final double Latitude;
  final double Longtitude;

  Wisata({
    required this.idwisata,
    required this.nama,
    required this.deskripsi,
    this.gambar,
    required this.rating,
    required this.idkategori,
    required this.Latitude,
    required this.Longtitude
  });

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
      idwisata: json['id_wisata'] as int,
      nama: json['nama_wisata'] as String,
      deskripsi: json['deskripsi'] as String,
      gambar: json['gambar'] as String?,
      rating: json['rating_wisata'] as int,
      idkategori: json['id_kategori'] as int,
      Latitude: double.parse(json['Latitude'] as String),
      Longtitude: double.parse(json['Longtitude'] as String),
  );


}