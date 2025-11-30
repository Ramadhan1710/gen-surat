class SuratKeputusanIpnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeRapta;
  final String nomorSurat;
  final String periodeKepengurusan;
  final String ketuaTerpilih;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String waktuPenetapan;
  final String namaKetua;
  final String namaSekretaris;
  final String namaAnggota;
  final String ttdKetuaPath;
  final String ttdSekretarisPath;
  final String ttdAnggotaPath;
  final List<TimFormaturEntity> timFormatur;

  SuratKeputusanIpnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeRapta,
    required this.nomorSurat,
    required this.periodeKepengurusan,
    required this.ketuaTerpilih,
    required this.namaWilayah,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.waktuPenetapan,
    required this.namaKetua,
    required this.namaSekretaris,
    required this.namaAnggota,
    required this.ttdKetuaPath,
    required this.ttdSekretarisPath,
    required this.ttdAnggotaPath,
    required this.timFormatur,
  });
}

class TimFormaturEntity {
  final String no;
  final String nama;
  final String daerahPengkaderan;

  TimFormaturEntity({
    required this.no,
    required this.nama,
    required this.daerahPengkaderan,
  });
}