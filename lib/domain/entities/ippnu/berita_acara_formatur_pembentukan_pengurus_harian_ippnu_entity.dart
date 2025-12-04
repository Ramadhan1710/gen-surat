class BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tingkatLembaga;
  final String tanggalPenyusunan;
  final String tempatPenyusunan;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final List<FormaturEntity> formatur;
  final List<PelindungEntity> pelindung;
  final List<PembinaEntity> pembina;
  final String namaKetua;
  final List<WakilKetuaEntity> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisEntity>? wakilSekre;
  final String namaBendahara;
  final String? namaWakilBend;

  BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.tingkatLembaga,
    required this.tanggalPenyusunan,
    required this.tempatPenyusunan,
    required this.namaWilayah,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.formatur,
    required this.pelindung,
    required this.pembina,
    required this.namaKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    this.wakilSekre,
    required this.namaBendahara,
    this.namaWakilBend,
  });
}

class FormaturEntity {
  final int no;
  final String nama;
  final String jabatan;
  final String ttdPath;

  FormaturEntity({
    required this.no,
    required this.nama,
    required this.jabatan,
    required this.ttdPath,
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
