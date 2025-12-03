class SertifikatKaderisasiIpnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String? sertifikatKaderisasiKetuaPath;
  final String? sertifikatKaderisasiSekretarisPath;
  final String? sertifikatKaderisasiBendaharaPath;

  SertifikatKaderisasiIpnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    this.sertifikatKaderisasiKetuaPath,
    this.sertifikatKaderisasiSekretarisPath,
    this.sertifikatKaderisasiBendaharaPath,
  });

  // Computed fields
  String get jenisLembagaUpper => jenisLembaga.toUpperCase();
  String get namaLembagaUpper => namaLembaga.toUpperCase();
}
