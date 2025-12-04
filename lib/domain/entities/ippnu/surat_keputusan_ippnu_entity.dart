class SuratKeputusanIppnuEntity {
  final String periodeRapta;
  final String jenisLembaga;
  final String nomorSurat;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String ketuaTerpilih;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String waktuPenetapan;
  final String namaKetua;
  final String namaSekretaris;
  final String namaAnggota;
  final List<TimFormaturItem> timFormatur;
  final String ttdKetuaPath;
  final String ttdSekretarisPath;
  final String ttdAnggotaPath;

  SuratKeputusanIppnuEntity({
    required this.periodeRapta,
    required this.jenisLembaga,
    required this.nomorSurat,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.ketuaTerpilih,
    required this.namaWilayah,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.waktuPenetapan,
    required this.namaKetua,
    required this.namaSekretaris,
    required this.namaAnggota,
    required this.timFormatur,
    required this.ttdKetuaPath,
    required this.ttdSekretarisPath,
    required this.ttdAnggotaPath,
  });
}

class TimFormaturItem {
  final int no;
  final String nama;
  final String daerahPengkaderan;

  TimFormaturItem({
    required this.no,
    required this.nama,
    required this.daerahPengkaderan,
  });
}
