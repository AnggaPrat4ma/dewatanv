class Kategori{
  final int idkategori;
  final String namaKategori;
  final String? gambar;

  Kategori({
    required this.idkategori,
    required this.namaKategori,
    this.gambar,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      idkategori: json['id_kategori'] as int,
      namaKategori: json['nama_kategori'] as String,
      gambar: json['gambar'] as String?,
    );
  }
}