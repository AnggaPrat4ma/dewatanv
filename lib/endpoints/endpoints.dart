class Endpoints {
  static const String baseURL =
      "https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1";

  static const String baseURLLive = "https://simobile.singapoly.com";

  static const String news = "$baseURL/news";
  static const String datas = "$baseURLLive/api/datas";
  // ignore: constant_identifier_names
  static const String CustomerService = "$baseURLLive/api/customer-service/2215091093";
  static const String balance = "$baseURLLive/api/balance/2215091093";
  static const String spending= "$baseURLLive/api/spending/2215091093";
  static const String logout= "$uas/auth/logout";

  //uas
  static const String host = "192.168.41.88";
  static const String uas = "http://$host:5000";

  static const String login= "$uas/auth/login";
  static const String kategori= "$uas/kategori";
  static const String wisata= "$uas/data_wisata";
  static const String registrasi= "$uas/auth/register";

}
