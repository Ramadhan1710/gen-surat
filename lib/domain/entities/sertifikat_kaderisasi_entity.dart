class SertifikatKaderisasiEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String? sertifikatKaderisasiKetuaPath;
  final String? sertifikatKaderisasiSekretarisPath;
  final String? sertifikatKaderisasiBendaharaPath;

  SertifikatKaderisasiEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    this.sertifikatKaderisasiKetuaPath,
    this.sertifikatKaderisasiSekretarisPath,
    this.sertifikatKaderisasiBendaharaPath,
  });
}
