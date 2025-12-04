class BeritaAcaraPenyusunanPengurusIppnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tanggalPenyusunan;
  final String tempatPenyusunan;
  final String namaWilayah;
  final String hariPenyusunan;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final List<PengurusHarianEntity> pengurusHarian;
  final List<PelindungEntity> pelindung;
  final List<PembinaEntity> pembina;
  final String namaKetua;
  final List<WakilKetuaEntity> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisEntity>? wakilSekre;
  final String namaBendahara;
  final String? namaWakilBend;
  final List<DepartemenEntity> departemen;
  final List<LembagaEntity> lembaga;

  BeritaAcaraPenyusunanPengurusIppnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.tanggalPenyusunan,
    required this.tempatPenyusunan,
    required this.namaWilayah,
    required this.hariPenyusunan,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.pengurusHarian,
    required this.pelindung,
    required this.pembina,
    required this.namaKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    this.wakilSekre,
    required this.namaBendahara,
    this.namaWakilBend,
    required this.departemen,
    required this.lembaga,
  });
}

class PengurusHarianEntity {
  final String jabatan;
  final String nama;
  final String? ttdPath;

  PengurusHarianEntity({
    required this.jabatan,
    required this.nama,
    this.ttdPath,
  });
}

class PelindungEntity {
  final String nama;

  PelindungEntity({
    required this.nama,
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

  WakilKetuaEntity({
    required this.title,
    required this.nama,
  });
}

class WakilSekretarisEntity {
  final String title;
  final String nama;

  WakilSekretarisEntity({
    required this.title,
    required this.nama,
  });
}

class DepartemenEntity {
  final String namaDepartemen;
  final String koordinator;
  final List<AnggotaDepartemenEntity> anggota;

  DepartemenEntity({
    required this.namaDepartemen,
    required this.koordinator,
    required this.anggota,
  });
}

class AnggotaDepartemenEntity {
  final String nama;

  AnggotaDepartemenEntity({
    required this.nama,
  });
}

class LembagaEntity {
  final String nama;
  final String direktur;
  final String sekretaris;
  final List<AnggotaLembagaEntity> anggota;

  LembagaEntity({
    required this.nama,
    required this.direktur,
    required this.sekretaris,
    required this.anggota,
  });
}

class AnggotaLembagaEntity {
  final String nama;

  AnggotaLembagaEntity({
    required this.nama,
  });
}
