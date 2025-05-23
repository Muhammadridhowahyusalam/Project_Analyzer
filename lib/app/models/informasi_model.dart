class InformasiModel {
  final String id;
  final String judul;
  final String deskripsiLengkap;
  final String gambarNama;

  InformasiModel({
    required this.id,
    required this.judul,
    required this.deskripsiLengkap,
    required this.gambarNama,
  });

  factory InformasiModel.fromJson(Map<String, dynamic> json) {
    return InformasiModel(
      id: json['id'],
      judul: json['judul'],
      deskripsiLengkap: json['deskripsi_lengkap'], // Harus cocok!
      gambarNama: json['gambar_nama'], // Harus cocok!
    );
  }
}
