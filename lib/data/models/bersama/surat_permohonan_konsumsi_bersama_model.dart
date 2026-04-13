class SuratPermohonanKonsumsiBersamaModel {
  final String nomorSurat;
  final String lampiran;
  final String tujuanSurat;
  final String namaKegiatan;
  final String hariTanggal;
  final String waktu;
  final String tempat;
  final String namaKonsumsi;
  final String jumlahKonsumsi;
  final String tanggalHijriah;
  final String tanggalMasehi;

  SuratPermohonanKonsumsiBersamaModel({
    required this.nomorSurat,
    required this.lampiran,
    required this.tujuanSurat,
    required this.namaKegiatan,
    required this.hariTanggal,
    required this.waktu,
    required this.tempat,
    required this.namaKonsumsi,
    required this.jumlahKonsumsi,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "nomor_surat": nomorSurat,
      "lampiran": lampiran,
      "tujuan_surat": tujuanSurat,
      "nama_kegiatan": namaKegiatan,
      "hari_tanggal": hariTanggal,
      "waktu": waktu,
      "tempat": tempat,
      "nama_konsumsi": namaKonsumsi,
      "jumlah_konsumsi": jumlahKonsumsi,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
    };
  }
}