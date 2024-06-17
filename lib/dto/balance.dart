class Balances {
  final int balance;
  final String? nim;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int idbalance;

  Balances(
      {required this.balance,
      this.nim,
      this.createdAt,
      this.updatedAt,
      required this.idbalance});


  factory Balances.fromJson(Map<String, dynamic> json) => Balances(
    idbalance: json['id_balance'] as int,
    balance: json['balance'] as int,
    nim: json['nim'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}