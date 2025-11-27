import 'dart:io';
import 'package:dio/dio.dart';

class SuratPermohonanPengesahanIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String nomorTeleponLembaga;
  final String alamatLembaga;
  final String emailLembaga;
  final String nomorSurat;
  final String tanggalRapat;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String periodeKepengurusan;
  final String namaKetuaTerpilih;
  final String namaSekretarisTerpilih;
  final String jenisLembagaInduk;

  final File ttdKetua;
  final File ttdSekretaris;

  SuratPermohonanPengesahanIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.nomorTeleponLembaga,
    required this.alamatLembaga,
    required this.emailLembaga,
    required this.nomorSurat,
    required this.tanggalRapat,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.periodeKepengurusan,
    required this.namaKetuaTerpilih,
    required this.namaSekretarisTerpilih,
    required this.jenisLembagaInduk,
    required this.ttdKetua,
    required this.ttdSekretaris,
  });

  /// Convert ke Map untuk multipart upload
  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "nomor_telepon_lembaga": nomorTeleponLembaga,
      "alamat_lembaga": alamatLembaga,
      "email_lembaga": emailLembaga,
      "nomor_surat": nomorSurat,
      "tanggal_rapat": tanggalRapat,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "periode_kepengurusan": periodeKepengurusan,
      "nama_ketua_terpilih": namaKetuaTerpilih,
      "nama_sekretaris_terpilih": namaSekretarisTerpilih,
      "jenis_lembaga_induk": jenisLembagaInduk,
      "ttd_ketua": await MultipartFile.fromFile(
        ttdKetua.path,
        filename: ttdKetua.path.split('/').last,
      ),
      "ttd_sekretaris": await MultipartFile.fromFile(
        ttdSekretaris.path,
        filename: ttdSekretaris.path.split('/').last,
      ),
    };
  }
}
