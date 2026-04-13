class SuratPermohonanPemateriBersamaModel {
  final String nomorSurat;
  final String lampiran;
  final String tujuanSurat;
  final String namaKegiatan;
  final String hariTanggal;
  final String waktu;
  final String tempat;
  final String pemateri;
  final String materi;
  final String tanggalHijriah;
  final String tanggalMasehi;

  SuratPermohonanPemateriBersamaModel({
    required this.nomorSurat,
    required this.lampiran,
    required this.tujuanSurat,
    required this.namaKegiatan,
    required this.hariTanggal,
    required this.waktu,
    required this.tempat,
    required this.pemateri,
    required this.materi,
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
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
    };
  }
}