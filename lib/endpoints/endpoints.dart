import 'package:dewatanv/utils/constants.dart';
import 'package:dewatanv/utils/secure_storage_util.dart';

class Endpoints {
  //uas
  static String baseUrl='';

  static String login= '';
  static String kategori= '';
  static String wisata= '';
  static String registrasi= '';
  static String delete= '';
  static String profile= '';
  static String akun = '';
  static String logout= '';
  static String favorite='';

  static Future<void> initializeURLs() async {
    try {
      baseUrl = await SecureStorageUtil.storage.read(key: baseURL) ?? '';
      if (baseUrl.isNotEmpty) {
        if (!baseUrl.startsWith('http://') && !baseUrl.startsWith('https://')) {
          // Assuming default to http if scheme is missing
          baseUrl = 'http://$baseUrl';
        }
        login = "$baseUrl/auth/login";
        logout = "$baseUrl/auth/logout";
        profile = "$baseUrl/profile/read";
        kategori= "$baseUrl/kategori";
        wisata= "$baseUrl/data_wisata";
        registrasi= "$baseUrl/auth/register";
        delete= "$baseUrl/data_wisata/delete";
        akun = "$baseUrl/akun";
        logout= "$baseUrl/auth/logout";
        favorite= "$baseUrl/wisata_favorit";
      } else {
        // Handle the case where the base URL is not set or invalid
        throw Exception('Base URL is empty');
      }
    } catch (e) {
      // Handle any errors that might occur during reading from storage
      // ignore: avoid_print
      print('Error initializing URLs: $e');
      rethrow; // Re-throwing to ensure calling code can handle this error if needed
    }
  }


}
