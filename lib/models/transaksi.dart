class Transaksi {
  final int? id;
  final int tukangOjekId;
  final int harga;
  final DateTime timestamp;

  Transaksi({
    this.id,
    required this.tukangOjekId,
    required this.harga,
    required this.timestamp,
  });

  Transaksi.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        tukangOjekId = res["tukangojek_id"],
        harga = res["harga"],
        timestamp = res["timestamp"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'tukangojek_id': tukangOjekId,
      'harga': harga,
      'timestamp': timestamp,
    };
  }
}
