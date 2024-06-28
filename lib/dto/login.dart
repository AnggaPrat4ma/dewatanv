// class Login{
//   final String accessToken;
//   final String tokenType;
//   final int expiresIn;
//   final int iduser;
//   final String role;
//   final String namaUser;
//   final String username;

//   Login({
//     required this.accessToken,
//     required this.tokenType,
//     required this.expiresIn,
//     required this.iduser,
//     required this.role,
//     required this.namaUser,
//     required this.username,
//   });

//   factory Login.fromJson(Map<String, dynamic> json) {
//     return Login(
//       accessToken: json['access_token'] as String,
//       tokenType: json['type'] as String,
//       expiresIn: json['expires_in'] as int,
//       iduser: json['id_user'] as int,
//       role: json['role'] as String,
//       namaUser: json['namaUser'] as String,
//       username: json['username'] as String,
//     );
//   }
// }

class Login {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int iduser;
  final String role;
  final String namaUser;
  final String username;

  Login({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.iduser,
    required this.role,
    required this.namaUser,
    required this.username,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      accessToken: json['access_token'] as String,
      tokenType: json['type'] as String,
      expiresIn: json['expires_in'] as int,
      iduser: json['id_user'] as int,
      role: json['role'] as String,
      namaUser: json['namaUser'] as String,
      username: json['username'] as String,
    );
  }
}
