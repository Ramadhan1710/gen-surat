class BeritaAcaraRapatFormaturEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String tempatRapat;
  final String periodeRapta;
  final String namaWilayah;
  final String tanggalRapat;
  final List<TimFormaturEntity> timFormatur;

  BeritaAcaraRapatFormaturEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.tempatRapat,
    required this.periodeRapta,
    required this.namaWilayah,
    required this.tanggalRapat,
    required this.timFormatur,
  });

  // Computed fields
  String get jenisLembagaUpper => jenisLembaga.toUpperCase();
  String get jenisLembagaTitle => _toTitleCase(jenisLembaga);
  String get namaLembagaUpper => namaLembaga.toUpperCase();
  String get namaLembagaTitle => _toTitleCase(namaLembaga);

  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}

class TimFormaturEntity {
  final String nama;
  final String jabatan;
  final String? ttdPath;

  TimFormaturEntity({required this.nama, required this.jabatan, this.ttdPath});
}
