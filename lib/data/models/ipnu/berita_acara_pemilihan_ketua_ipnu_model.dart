import 'dart:io';

import 'package:dio/dio.dart';

class BeritaAcaraPemilihanKetuaIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String waktuPemilihanKetua;
  final String tempatPemilihanKetua;
  final int totalSuaraSahPencalonanKetua;
  final int totalSuaraTidakSahPencalonanKetua;
  final int totalSuaraTidakSahPemilihanKetua;
  final int totalSuaraSahPemilihanKetua;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String waktuPenetapan;
  final String namaKetua;
  final String namaSekretaris;
  final String namaAnggota;
  final List<PencalonanKetuaModel> pencalonanKetua;
  final List<PemilihanKetuaModel> pemilihanKetua;
  final String namaKetuaTerpilih;
  final String alamatKetuaTerpilih;
  final int totalSuaraKetuaTerpilih;
  final List<FormaturModel> formatur;
  final File ttdKetua;
  final File ttdSekretaris;
  final File ttdAnggota;

  BeritaAcaraPemilihanKetuaIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.waktuPemilihanKetua,
    required this.tempatPemilihanKetua,
    required this.totalSuaraSahPencalonanKetua,
    required this.totalSuaraTidakSahPencalonanKetua,
    required this.totalSuaraTidakSahPemilihanKetua,
    required this.totalSuaraSahPemilihanKetua,
    required this.namaWilayah,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.waktuPenetapan,
    required this.namaKetua,
    required this.namaSekretaris,
    required this.namaAnggota,
    required this.pencalonanKetua,
    required this.pemilihanKetua,
    required this.namaKetuaTerpilih,
    required this.alamatKetuaTerpilih,
    required this.totalSuaraKetuaTerpilih,
    required this.formatur,
    required this.ttdKetua,
    required this.ttdSekretaris,
    required this.ttdAnggota,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      "tanggal": tanggal,
      "bulan": bulan,
      "tahun": tahun,
      "waktu_pemilihan_ketua": waktuPemilihanKetua,
      "tempat_pemilihan_ketua": tempatPemilihanKetua,
      "total_suara_sah_pencalonan_ketua": totalSuaraSahPencalonanKetua,
      "total_suara_tidak_sah_pencalonan_ketua": totalSuaraTidakSahPencalonanKetua,
      "total_suara_tidak_sah_pemilihan_ketua": totalSuaraTidakSahPemilihanKetua,
      "total_suara_sah_pemilihan_ketua": totalSuaraSahPemilihanKetua,
      "nama_wilayah": namaWilayah,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "waktu_penetapan": waktuPenetapan,
      "nama_ketua": namaKetua,
      "nama_sekretaris": namaSekretaris,
      "nama_anggota": namaAnggota,
      "pencalonan_ketua": pencalonanKetua.map((e) => e.toMap()).toList(),
      "pemilihan_ketua": pemilihanKetua.map((e) => e.toMap()).toList(),
      "nama_ketua_terpilih": namaKetuaTerpilih,
      "alamat_ketua_terpilih": alamatKetuaTerpilih,
      "total_suara_ketua_terpilih": totalSuaraKetuaTerpilih,
      "formatur": formatur.map((e) => e.toMap()).toList(),
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
    };
  }
}

class PencalonanKetuaModel {
  final int nomor;
  final String nama;
  final String alamat;
  final int jmlSuaraSah;

  PencalonanKetuaModel({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.jmlSuaraSah,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomor': nomor,
      'nama': nama,
      'alamat': alamat,
      'jml_suara_sah': jmlSuaraSah,
    };
  }
}

class PemilihanKetuaModel {
  final int nomor;
  final String nama;
  final String alamat;
  final int jmlSuaraSah;

  PemilihanKetuaModel({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.jmlSuaraSah,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomor': nomor,
      'nama': nama,
      'alamat': alamat,
      'jml_suara_sah': jmlSuaraSah,
    };
  }
}

class FormaturModel {
  final int nomor;
  final String nama;
  final String alamat;
  final String daerahPengkaderan;

  FormaturModel({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.daerahPengkaderan,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomor': nomor,
      'nama': nama,
      'alamat': alamat,
      'daerah_pengkaderan': daerahPengkaderan,
    };
  }
}
