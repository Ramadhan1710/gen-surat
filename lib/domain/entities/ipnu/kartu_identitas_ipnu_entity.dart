class KartuIdentitasIpnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String? kartuIdentitasKetuaPath;
  final String? kartuIdentitasSekretarisPath;
  final String? kartuIdentitasBendaharaPath;

  KartuIdentitasIpnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    this.kartuIdentitasKetuaPath,
    this.kartuIdentitasSekretarisPath,
    this.kartuIdentitasBendaharaPath,
  });

  // Computed fields
  String get jenisLembagaUpper => jenisLembaga.toUpperCase();
  String get namaLembagaUpper => namaLembaga.toUpperCase();
}
