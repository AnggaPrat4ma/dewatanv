import 'package:dewatanv/dto/balance.dart';
import 'package:dewatanv/dto/customer_service.dart';
import 'package:dewatanv/dto/datas.dart';
import 'package:dewatanv/dto/kategori.dart';
import 'package:dewatanv/dto/news.dart';
import 'package:dewatanv/dto/spending.dart';
import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      // Handle error
      throw Exception('Failed to load news');
    }
  }

  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  // post data to endpoint news
  static Future<News> createNews(String title, String body) async {
    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );
    

    if (response.statusCode == 201) {
      // Check for creation success (201 Created)
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      // Handle error
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }

  static Future<void> updateNews(String id, String title, String body) async {
    Map<String, String> data = {"id": id, "title": title, "body": body};
    String jsonData = jsonEncode(data);
    await http.put(Uri.parse('${Endpoints.news}/$id'),
        body: jsonData, headers: {'Content-type': 'application/json'});
  }

  static Future<void> deleteDatas(int id) async {
    final url = Uri.parse('${Endpoints.datas}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  static Future<List<CustomerService>> fetchCustomerService() async {
    final response = await http.get(Uri.parse(Endpoints.CustomerService)); 
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>) 
          .map((item) => CustomerService.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

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

  static Future<List<Wisata>> fetchwisata(int idKategori) async {
    final response = await http.get(Uri.parse('${Endpoints.uas}/data_wisata/$idKategori'));
    if (response.statusCode == 200) {
      // List<dynamic> jsonResponse = json.decode(response.body);
      // // If the response contains a list directly
      // return jsonResponse.map((data) => Wisata.fromJson(data)).toList();
      
      // If the response contains the list within an object
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> wisataList = jsonResponse['datas'];
      return wisataList.map((data) => Wisata.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load wisata');
    }
  }

  // static Future<List<Wisata>> fetchwisata() async {
  //   final response = await http.get(Uri.parse(Endpoints.wisata));

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((data) => Wisata.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load wisata');
  //   }
  // }

  static Future<void> deleteCustomerService(String id) async { 
    await http.delete(Uri.parse('${Endpoints.CustomerService}/$id'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<List<Balances>> fetchBalances() async {
    final response = await http.get(Uri.parse(Endpoints.balance)); 
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>) 
          .map((item) => Balances.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Spendings>> fetchSpendings() async {
    final response = await http.get(Uri.parse(Endpoints.spending)); 
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>) 
          .map((item) => Spendings.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future <http.Response> sendSpendingData(int spending) async {
    final url = Uri.parse(Endpoints.spending);
    final data = {'spending' : spending};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  static Future<List<Wisata>> fetchWisataByCategory(int idKategori) async {
    final response = await http.get(Uri.parse('${Endpoints.wisata}/$idKategori'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Wisata.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load wisata');
    }
  }

  static Future<http.Response> sendLoginData(String username, String password) async {
    final url = Uri.parse(Endpoints.login);
    final data = {'username': username, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  static Future <http.Response> logoutData() async {
    final url = Uri.parse(Endpoints.logout);
    final String? accessToken = await SecureStorageUtil.storage.read(key: tokenStoreName);
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

  static void updateData(String id, String title, String body) {}

  static void deleteData(String id) {}

  static void sendNews(String text, String text2) {}
}
