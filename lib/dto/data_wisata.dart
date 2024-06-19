class DataWisata {
  final int idwisata;
  final String nama;
  final String deskripsi;
  final String? gambar;
  final String? video;
  final int rating;
  final String maps;
  final int idkategori;

  DataWisata({
    required this.idwisata,
    required this.nama,
    required this.deskripsi,
    this.gambar,
    this.video,
    required this.rating,
    required this.maps,
    required this.idkategori
  });

  factory DataWisata.fromJson(Map<String, dynamic> json) {
    return DataWisata(
    idwisata: json['id_wisata'] as int,
      nama: json['nama_wisata'] as String,
      deskripsi: json['deskripsi'] as String,
      gambar: json['gambar'] as String?,
      video: json['video'] as String?,
      rating: json['rating_wisata'] as int,
      maps: json['maps'] as String,
      idkategori: json['id_kategori'] as int,
  );}
}