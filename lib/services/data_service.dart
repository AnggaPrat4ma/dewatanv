import 'package:dewatanv/dto/kategori.dart';
import 'package:dewatanv/dto/profile.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/dto/wisatfavorite.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static Future<List<Kategori>> fetchkategori() async {
    final response = await http.get(Uri.parse('${Endpoints.kategori}/read'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Kategori.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<void> addFavorite(int userId, int idWisata) async {
    final url = Uri.parse('${Endpoints.favorite}/add'); // Sesuaikan dengan endpoint Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'id_user': userId,
        'id_wisata': idWisata,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      debugPrint('Wisata berhasil ditambahkan ke favorit');
    } else {
      throw Exception('Gagal menambahkan wisata ke favorit');
    }
  }

  static Future<void> removeFavorite(int userId, int idWisata) async {
    final url = Uri.parse('${Endpoints.favorite}/remove'); // Sesuaikan dengan endpoint Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'id_user': userId,
        'id_wisata': idWisata,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      debugPrint('Wisata berhasil dihapus dari favorit');
    } else {
      throw Exception('Gagal menghapus wisata dari favorit');
    }
  }

  static Future<List<Wisata>> fetchWisataByRating() async {
    final response = await http.get(Uri.parse('${Endpoints.wisata}/top_rated'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Wisata.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Wisata>> fetchWisata() async {
    final response = await http.get(Uri.parse(Endpoints.wisata));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Wisata.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Akun>> fetchAkunById(int idUser) async {
    final response =
        await http.get(Uri.parse('${Endpoints.akun}/user/$idUser'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Akun.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Tangani error
      throw Exception(
          'Gagal memuat data pengguna dengan id $idUser, status code: ${response.statusCode}');
    }
  }

  static Future<List<Akun>> fetchAkun() async {
    final response = await http.get(Uri.parse('${Endpoints.akun}/read'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Akun.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Akun>> fetchUserById(int iduser) async {
    final response = await http.get(Uri.parse('${Endpoints.profile}/$iduser'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Akun.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Tangani error
      throw Exception(
          'Gagal memuat data pengguna dengan id $iduser, status code: ${response.statusCode}');
    }
  }

  static Future<Wisata> fetchWisataById(int idWisata) async {
    final response =
        await http.get(Uri.parse('${Endpoints.wisata}/wisata/$idWisata'));

    if (response.statusCode == 200) {
      return Wisata.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load wisata');
    }
  }

  static Future<List<Wisatafavorit>> fetchWisataFavoritByUser(int idUser) async {
    final response = await http.get(Uri.parse('${Endpoints.favorite}/user/$idUser'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData['datas'] as List)
          .map((data) => Wisatafavorit.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load favorite wisata by user');
    }
  }

  static Future<List<Wisata>> fetchWisataByCategory(
      int idKategori, int page) async {
    try {
      final response = await http.get(
          Uri.parse('${Endpoints.wisata}/$idKategori')
              .replace(queryParameters: {
        'page': page.toString(),
      }));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // Debug logging
        debugPrint('Response data: $decodedResponse');

        // Handle both list and map formats
        if (decodedResponse is List) {
          // If the response is a list
          if (decodedResponse.isEmpty) {
            debugPrint('No data available: empty list');
            return [];
          } else {
            return decodedResponse
                .whereType<Map<String, dynamic>>() // Ensure each item is a Map
                .map((item) => Wisata.fromJson(item))
                .toList();
          }
        } else if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('datas')) {
          // If the response is a map with a 'datas' key
          final datas = decodedResponse['datas'];
          if (datas is List) {
            if (datas.isEmpty) {
              debugPrint('No data available: empty "datas" list');
              return [];
            } else {
              return datas
                  .whereType<
                      Map<String, dynamic>>() // Ensure each item is a Map
                  .map((item) => Wisata.fromJson(item))
                  .toList();
            }
          } else {
            debugPrint('Unexpected "datas" type: ${datas.runtimeType}');
            throw Exception('Unexpected "datas" type');
          }
        } else {
          // Unexpected JSON format
          debugPrint('Unexpected JSON format: $decodedResponse');
          throw Exception('Unexpected JSON format');
        }
      } else {
        debugPrint(
            'Failed to load wisata. Status code: ${response.statusCode}');
        throw Exception('Failed to load');
      }
    } catch (error) {
      debugPrint('Error fetching wisata by category: $error');
      throw Exception('Failed to load wisata');
    }
  }

  static Future<http.Response> sendLoginData(
      String username, String password) async {
    final url = Uri.parse(Endpoints.login);
    final data = {'username': username, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  static Future<http.Response> logoutData() async {
    final url = Uri.parse(Endpoints.logout);
    final String? accessToken =
        await SecureStorageUtil.storage.read(key: tokenStoreName);
    debugPrint("logout with $accessToken");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return response;
  }

  static Future<void> deleteWisata(int idwisata) async {
    await http.delete(Uri.parse('${Endpoints.delete}/$idwisata'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<http.Response> sendSignUpData(
      String name, String username, String password) async {
    final url = Uri.parse(Endpoints.registrasi);
    final data = {
      'nama_user': name,
      'username': username,
      'password': password
    };
    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static void updateData(String id, String title, String body) {}

  static void deleteData(String id) {}

  static void sendNews(String text, String text2) {}
}
