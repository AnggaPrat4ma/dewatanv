class Spendings {
  final int spending;
  final String? nim;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int idspending;

  Spendings(
      {required this.spending,
      this.nim,
      required this.createdAt,
      this.updatedAt,
      required this.idspending});


  factory Spendings.fromJson(Map<String, dynamic> json) => Spendings(
      idspending: json['id_spending'] as int,
      spending: json['spending'] as int,
      nim: json['nim'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}