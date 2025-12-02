class SusunanPengurusIpnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String alamatLembaga;
  final String nomorTeleponLembaga;
  final String emailLembaga;
  final String periodeKepengurusan;
  final bool isRanting;
  final String? namaRoisSyuriyah;
  final String? namaKetuaTanfidziyah;
  final bool isKomisariat;
  final String? namaKepalaMadrasah;
  final List<PembinaEntity> pembina;
  final String namaKetua;
  final String alamatKetua;
  final List<WakilKetuaEntity> wakilKetua;
  final String namaSekretaris;
  final String alamatSekretaris;
  final List<WakilSekretarisEntity>? wakilSekre;
  final String namaBendahara;
  final String alamatBendahara;
  final String? namaWakilBend;
  final String? alamatWakilBend;
  final List<DepartemenEntity> departemen;
  final List<LembagaEntity> lembaga;
  final bool? hasLembagaCBP;
  final String? komandan;
  final String? alamatKomandan;
  final String? wakilKomandan;
  final String? alamatWakilKomandan;
  final bool? hasDivisi;
  final List<DivisiEntity>? divisi;

  SusunanPengurusIpnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.alamatLembaga,
    required this.nomorTeleponLembaga,
    required this.emailLembaga,
    required this.periodeKepengurusan,
    required this.isRanting,
    this.namaRoisSyuriyah,
    this.namaKetuaTanfidziyah,
    required this.isKomisariat,
    this.namaKepalaMadrasah,
    required this.pembina,
    required this.namaKetua,
    required this.alamatKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    required this.alamatSekretaris,
    this.wakilSekre,
    required this.namaBendahara,
    required this.alamatBendahara,
    this.namaWakilBend,
    this.alamatWakilBend,
    required this.departemen,
    required this.lembaga,
    this.hasLembagaCBP,
    this.komandan,
    this.alamatKomandan,
    this.wakilKomandan,
    this.alamatWakilKomandan,
    this.hasDivisi,
    this.divisi,
  });
}

class PembinaEntity {
  final int no;
  final String nama;

  PembinaEntity({
    required this.no,
    required this.nama,
  });
}

class WakilKetuaEntity {
  final String title;
  final String nama;
  final String alamat;

  WakilKetuaEntity({
    required this.title,
    required this.nama,
    required this.alamat,
  });
}

class WakilSekretarisEntity {
  final String title;
  final String nama;
  final String alamat;

  WakilSekretarisEntity({
    required this.title,
    required this.nama,
    required this.alamat,
  });
}

class DepartemenEntity {
  final String nama;
  final String koordinator;
  final String alamatKoordinator;
  final List<AnggotaDepartemenEntity> anggota;

  DepartemenEntity({
    required this.nama,
    required this.koordinator,
    required this.alamatKoordinator,
    required this.anggota,
  });
}

class AnggotaDepartemenEntity {
  final String nama;
  final String alamat;

  AnggotaDepartemenEntity({
    required this.nama,
    required this.alamat,
  });
}

class LembagaEntity {
  final String nama;
  final String direktur;
  final String alamatDirektur;
  final String sekretaris;
  final String alamatSekretaris;
  final List<AnggotaLembagaEntity>? anggota;

  LembagaEntity({
    required this.nama,
    required this.direktur,
    required this.alamatDirektur,
    required this.sekretaris,
    required this.alamatSekretaris,
    this.anggota,
  });
}

class AnggotaLembagaEntity {
  final String nama;
  final String alamat;

  AnggotaLembagaEntity({
    required this.nama,
    required this.alamat,
  });
}

class DivisiEntity {
  final String nama;
  final String koordinator;
  final String alamatKoordinator;
  final List<AnggotaDivisiEntity>? anggota;

  DivisiEntity({
    required this.nama,
    required this.koordinator,
    required this.alamatKoordinator,
    this.anggota,
  });
}

class AnggotaDivisiEntity {
  final String nama;
  final String alamat;

  AnggotaDivisiEntity({
    required this.nama,
    required this.alamat,
  });
}
