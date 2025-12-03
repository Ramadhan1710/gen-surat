class CurriculumVitaeEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  
  // Data Ketua
  final String namaKetua;
  final String ttlKetua;
  final String niaKetua;
  final String alamatKetua;
  final String mottoKetua;
  final String nomorHpKetua;
  final String emailKetua;
  final List<OrganisasiEntity>? organisasiKetua;
  final List<PendidikanEntity> pendidikanKetua;
  final String? fotoKetuaPath;
  
  // Data Sekretaris
  final String namaSekretaris;
  final String ttlSekretaris;
  final String niaSekretaris;
  final String alamatSekretaris;
  final String mottoSekretaris;
  final String nomorHpSekretaris;
  final String emailSekretaris;
  final List<OrganisasiEntity>? organisasiSekretaris;
  final List<PendidikanEntity> pendidikanSekretaris;
  final String? fotoSekretarisPath;
  
  // Data Bendahara
  final String namaBendahara;
  final String ttlBendahara;
  final String niaBendahara;
  final String alamatBendahara;
  final String mottoBendahara;
  final String nomorHpBendahara;
  final String emailBendahara;
  final List<OrganisasiEntity>? organisasiBendahara;
  final List<PendidikanEntity> pendidikanBendahara;
  final String? fotoBendaharaPath;

  CurriculumVitaeEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.namaKetua,
    required this.ttlKetua,
    required this.niaKetua,
    required this.alamatKetua,
    required this.mottoKetua,
    required this.nomorHpKetua,
    required this.emailKetua,
    required this.organisasiKetua,
    required this.pendidikanKetua,
    this.fotoKetuaPath,
    required this.namaSekretaris,
    required this.ttlSekretaris,
    required this.niaSekretaris,
    required this.alamatSekretaris,
    required this.mottoSekretaris,
    required this.nomorHpSekretaris,
    required this.emailSekretaris,
    required this.organisasiSekretaris,
    required this.pendidikanSekretaris,
    this.fotoSekretarisPath,
    required this.namaBendahara,
    required this.ttlBendahara,
    required this.niaBendahara,
    required this.alamatBendahara,
    required this.mottoBendahara,
    required this.nomorHpBendahara,
    required this.emailBendahara,
    required this.organisasiBendahara,
    required this.pendidikanBendahara,
    this.fotoBendaharaPath,
  });
}

class OrganisasiEntity {
  final String nama;

  OrganisasiEntity({
    required this.nama,
  });
}

class PendidikanEntity {
  final String tingkatPendidikan;
  final String namaPendidikan;

  PendidikanEntity({
    required this.tingkatPendidikan,
    required this.namaPendidikan,
  });
}
