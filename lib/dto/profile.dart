class Akun {
  final int idUser;
  final String lokasi;
  final String namaUser;
  final String gambar;
  final String role;
  final String username;

  Akun ({
    required this.idUser,
    required this.lokasi,
    required this.namaUser,
    required this.gambar,
    required this.role,
    required this.username
  });

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
      idUser: json['id_user'] as int,
      lokasi: json['lokasi'] ?? "",
      namaUser: json['nama_user'] ?? "",
      gambar: json['gambar'] ?? "",
      role: json['role'] as String,
      username: json['username'] as String
    );
  }
}