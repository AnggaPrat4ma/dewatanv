import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken, int idUser, String namaUser, String role, String username) {
    emit(AuthState(
      isLoggeIn: true,
      accessToken: accessToken,
      idUser: idUser,
      namaUser: namaUser,
      role: role,
      username: username,
      isFavoriteList: const [],
    ));
  }

  void toggleFavorite(String idwisata) {
    final isFavorite = state.isFavoriteList.contains(idwisata);
    final updatedFavorites = List<String>.from(state.isFavoriteList);
    if (isFavorite) {
      updatedFavorites.remove(idwisata);
    } else {
      updatedFavorites.add(idwisata);
    }
    emit(state.copyWith(isFavoriteList: updatedFavorites));
  }

  void logout() {
    emit(const AuthState(
      isLoggeIn: false,
      accessToken: null,
      idUser: 0,
      namaUser: '',
      role: 'user',
      username: '',
      isFavoriteList: [],
    ));
  }
}


// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(const AuthInitialState());

//   void login(
//     String accessToken, 
//     int idUser,  
//     String namaUser, 
//     String role, 
//     String username) {
//     emit(AuthState(
//       isLoggeIn: true, 
//       accessToken: accessToken,
//       idUser: idUser,
//       namaUser: namaUser,
//       role: role,
//       username: username
//     ));
//   }

//   void toggleFavorite(String idwisata) {
//     // Implement the logic to toggle the favorite status
//     final isFavorite = state.isFavoriteList.contains(idwisata);
//     final updatedFavorites = List<String>.from(state.isFavoriteList);
//     if (isFavorite) {
//       updatedFavorites.remove(idwisata);
//     } else {
//       updatedFavorites.add(idwisata);
//     }
//     emit(state.copyWith(isFavoriteList: updatedFavorites));
//   }

//   void logout() {
//     emit(const AuthState(
//       isLoggeIn: false, 
//       accessToken: "", 
//       idUser: 1, 
//       namaUser: "",
//       role: "user",
//       username: ""
//     ));
//   }
// }


// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(const AuthInitialState());

//   void login(
//     String accessToken, 
//     int idUser,  
//     // String lokasi, 
//     String namaUser, 
//     // String gambar, 
//     String role, 
//     String username) {
//     emit(AuthState(
//       isLoggeIn: true, 
//       accessToken: accessToken,
//       idUser: idUser,
//       // lokasi: lokasi,
//       namaUser: namaUser,
//       // gambar: gambar,
//       role: role,
//       username: username
//       ));
//   }

//   void logout() {
//     emit(const AuthState(isLoggeIn: false, accessToken: "", idUser: 1, 
//     // lokasi: "", 
//     namaUser: "",
//     // gambar: "",
//     role: "user",
//     username: ""));
//   }


// }
