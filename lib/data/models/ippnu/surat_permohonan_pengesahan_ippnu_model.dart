import 'dart:io';
import 'package:dio/dio.dart';

class SuratPermohonanPengesahanIppnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String teleponLembaga;
  final String alamatLembaga;
  final String emailLembaga;
  final String nomorSurat;
  final String tanggalRapta;
  final String nomorRapta;
  final String tempatRapta;
  final String tanggalKeputusan;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String periodeKepengurusan;
  final String namaKetuaTerpilih;
  final String namaSekretarisTerpilih;
  final String namaLembagaInduk;
  final String tingkatLembaga;

  final File ttdKetua;
  final File ttdSekretaris;

  SuratPermohonanPengesahanIppnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.teleponLembaga,
    required this.alamatLembaga,
    required this.emailLembaga,
    required this.nomorSurat,
    required this.tanggalRapta,
    required this.nomorRapta,
    required this.tempatRapta,
    required this.tanggalKeputusan,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.periodeKepengurusan,
    required this.namaKetuaTerpilih,
    required this.namaSekretarisTerpilih,
    required this.namaLembagaInduk,
    required this.tingkatLembaga,
    required this.ttdKetua,
    required this.ttdSekretaris,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "telepon_lembaga": teleponLembaga,
      "alamat_lembaga": alamatLembaga,
      "email_lembaga": emailLembaga,
      "nomor_surat": nomorSurat,
      "tanggal_rapta": tanggalRapta,
      "nomor_rapta": nomorRapta,
      "tempat_rapta": tempatRapta,
      "tanggal_keputusan": tanggalKeputusan,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "periode_kepengurusan": periodeKepengurusan,
      "nama_ketua_terpilih": namaKetuaTerpilih,
      "nama_sekretaris_terpilih": namaSekretarisTerpilih,
      "nama_lembaga_induk": namaLembagaInduk,
      "tingkat_lembaga": tingkatLembaga,
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
