class TukangOjek {
  final int? id;
  final String nama;
  final String nopol;

  TukangOjek({
    this.id,
    required this.nama,
    required this.nopol,
  });

  TukangOjek.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        nama = res["nama"],
        nopol = res["nopol"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nopol': nopol,
    };
  }
}
