class SusunanPengurusIppnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String alamatLembaga;
  final String nomorTeleponLembaga;
  final String emailLembaga;
  final String namaKetua;
  final List<WakilKetuaItem> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisItem> wakilSekre;
  final String namaBendahara;
  final String namaWakilBend;
  final List<DepartemenItem> departemen;
  final List<LembagaItem> lembaga;
  final List<PelindungItem> pelindung;
  final List<PembinaItem> pembina;

  SusunanPengurusIppnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.alamatLembaga,
    required this.nomorTeleponLembaga,
    required this.emailLembaga,
    required this.namaKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    required this.wakilSekre,
    required this.namaBendahara,
    required this.namaWakilBend,
    required this.departemen,
    required this.lembaga,
    required this.pelindung,
    required this.pembina,
  });
}

class WakilKetuaItem {
  final String title;
  final String nama;

  WakilKetuaItem({required this.title, required this.nama});
}

class WakilSekretarisItem {
  final String title;
  final String nama;

  WakilSekretarisItem({required this.title, required this.nama});
}

class DepartemenItem {
  final String namaDepartemen;
  final String koordinator;
  final List<AnggotaDepartemenItem> anggota;

  DepartemenItem({
    required this.namaDepartemen,
    required this.koordinator,
    required this.anggota,
  });
}

class AnggotaDepartemenItem {
  final String nama;

  AnggotaDepartemenItem({required this.nama});
}

class LembagaItem {
  final String nama;
  final String direktur;
  final String sekretaris;
  final List<AnggotaLembagaItem> anggota;

  LembagaItem({
    required this.nama,
    required this.direktur,
    required this.sekretaris,
    required this.anggota,
  });
}

class AnggotaLembagaItem {
  final String nama;

  AnggotaLembagaItem({required this.nama});
}

class PelindungItem {
  final String nama;

  PelindungItem({required this.nama});
}

class PembinaItem {
  final int no;
  final String nama;

  PembinaItem({required this.no, required this.nama});
}
