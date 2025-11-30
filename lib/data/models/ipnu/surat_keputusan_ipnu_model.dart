import 'dart:io';

import 'package:dio/dio.dart';

class SuratKeputusanIpnuModel {
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
  final File ttdKetua;
  final File ttdSekretaris;
  final File ttdAnggota;
  final List<TimFormaturModel> timFormatur;

  SuratKeputusanIpnuModel({
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
    required this.ttdKetua,
    required this.ttdSekretaris,
    required this.ttdAnggota,
    required this.timFormatur,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_rapta": periodeRapta,
      "nomor_surat": nomorSurat,
      "periode_kepengurusan": periodeKepengurusan,
      "ketua_terpilih": ketuaTerpilih,
      "nama_wilayah": namaWilayah,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "waktu_penetapan": waktuPenetapan,
      "nama_ketua": namaKetua,
      "nama_sekretaris": namaSekretaris,
      "nama_anggota": namaAnggota,
      "ttd_ketua": await MultipartFile.fromFile(
        ttdKetua.path,
        filename: ttdKetua.path.split('/').last,
      ),
      "ttd_sekretaris": await MultipartFile.fromFile(
        ttdSekretaris.path,
        filename: ttdSekretaris.path.split('/').last,
      ),
      "ttd_anggota": await MultipartFile.fromFile(
        ttdAnggota.path,
        filename: ttdAnggota.path.split('/').last,
      ),
      "tim_formatur": timFormatur.map((e) => e.toMap()).toList(),
    };
  }
}

class TimFormaturModel {
  final String no;
  final String nama;
  final String daerahPengkaderan;

  TimFormaturModel({
    required this.no,
    required this.nama,
    required this.daerahPengkaderan,
  });

  Map<String, dynamic> toMap() {
    return {'no': no, 'nama': nama, 'daerah_pengkaderan': daerahPengkaderan};
  }
}
