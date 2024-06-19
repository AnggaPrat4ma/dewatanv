class Wisata {
  final int idwisata;
  final String nama;
  final String deskripsi;
  final String? gambar;
  final int idkategori;

  Wisata({
    required this.idwisata,
    required this.nama,
    required this.deskripsi,
    this.gambar,
    required this.idkategori
  });

  factory Wisata.fromJson(Map<String, dynamic> json) {
    return Wisata(
    idwisata: json['id_wisata'] ?? 0,
      nama: json['nama_wisata'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      gambar: json['gambar'],
      idkategori: json['id_kategori'] ?? 0,
  );}
}