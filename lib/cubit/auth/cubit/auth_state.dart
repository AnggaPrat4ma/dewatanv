// part of 'auth_cubit.dart';

// @immutable
// class AuthState {
//   final bool isLoggeIn;
//   final String? accessToken;
//   final int idUser;
//   // final String lokasi;
//   final String namaUser;
//   // final String gambar;
//   final String role;
//   final String username;
//   const AuthState({
//     required this.isLoggeIn, 
//     this.accessToken, 
//     required this.idUser,
//     // required this.lokasi,
//     required this.namaUser,
//     // required this.gambar,
//     required this.role,
//     required this.username,
//     });
// }

// final class AuthInitialState extends AuthState {
//   const AuthInitialState() : super(
//     isLoggeIn: true, 
//     accessToken: "", 
//     idUser: 1, 
//     // lokasi: "", 
//     namaUser: "",
//     // gambar: "",
//     role: "user",
//     username: "",);
// }


part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLoggeIn;
  final String? accessToken;
  final int idUser;
  final String namaUser;
  final String role;
  final String username;
  final List<String> isFavoriteList;

  const AuthState({
    required this.isLoggeIn,
    this.accessToken,
    required this.idUser,
    required this.namaUser,
    required this.role,
    required this.username,
    required this.isFavoriteList,
  });

  AuthState copyWith({
    bool? isLoggeIn,
    String? accessToken,
    int? idUser,
    String? namaUser,
    String? role,
    String? username,
    List<String>? isFavoriteList,
  }) {
    return AuthState(
      isLoggeIn: isLoggeIn ?? this.isLoggeIn,
      accessToken: accessToken ?? this.accessToken,
      idUser: idUser ?? this.idUser,
      namaUser: namaUser ?? this.namaUser,
      role: role ?? this.role,
      username: username ?? this.username,
      isFavoriteList: isFavoriteList ?? this.isFavoriteList,
    );
  }
}

final class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(
          isLoggeIn: false,
          accessToken: null,
          idUser: 0,
          namaUser: '',
          role: 'user',
          username: '',
          isFavoriteList: const [],
        );
}
