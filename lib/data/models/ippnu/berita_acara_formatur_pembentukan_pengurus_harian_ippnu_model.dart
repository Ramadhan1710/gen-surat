import 'dart:io';

import 'package:dio/dio.dart';

class BeritaAcaraFormaturPembentukanPengurusHarianIppnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tingkatLembaga;
  final String tanggalPenyusunan;
  final String tempatPenyusunan;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final List<FormaturModel> formatur;
  final List<PelindungModel> pelindung;
  final List<PembinaModel> pembina;
  final String namaKetua;
  final List<WakilKetuaModel> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisModel>? wakilSekre;
  final String namaBendahara;
  final String? namaWakilBend;

  BeritaAcaraFormaturPembentukanPengurusHarianIppnuModel({
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

  Future<Map<String, dynamic>> toMultipartMap() async {
    final map = <String, dynamic>{
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      "tingkat_lembaga": tingkatLembaga,
      "tanggal_penyusunan": tanggalPenyusunan,
      "tempat_penyusunan": tempatPenyusunan,
      "nama_wilayah": namaWilayah,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "formatur": formatur.map((e) => e.toMap()).toList(),
      "pelindung": pelindung.map((e) => e.toMap()).toList(),
      "pembina": pembina.map((e) => e.toMap()).toList(),
      "nama_ketua": namaKetua,
      "wakil_ketua": wakilKetua.map((e) => e.toMap()).toList(),
      "nama_sekretaris": namaSekretaris,
      if (wakilSekre != null && wakilSekre!.isNotEmpty)
        "wakil_sekre": wakilSekre!.map((e) => e.toMap()).toList(),
      "nama_bendahara": namaBendahara,
      if (namaWakilBend != null && namaWakilBend!.isNotEmpty)
        "nama_wakil_bend": namaWakilBend,
    };

    // Add formatur signatures
    for (int i = 0; i < formatur.length; i++) {
      map["ttd_formatur_${i + 1}"] = await MultipartFile.fromFile(
        formatur[i].ttd.path,
        filename: formatur[i].ttd.path.split('/').last,
      );
    }

    return map;
  }
}

class FormaturModel {
  final int no;
  final String nama;
  final String jabatan;
  final File ttd;

  FormaturModel({
    required this.no,
    required this.nama,
    required this.jabatan,
    required this.ttd,
  });

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'nama': nama,
      'jabatan': jabatan,
    };
  }
}

class PelindungModel {
  final String nama;

  PelindungModel({
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
    };
  }
}

class PembinaModel {
  final int no;
  final String nama;

  PembinaModel({
    required this.no,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'nama': nama,
    };
  }
}

class WakilKetuaModel {
  final String title;
  final String nama;

  WakilKetuaModel({
    required this.title,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'nama': nama,
    };
  }
}

class WakilSekretarisModel {
  final String title;
  final String nama;

  WakilSekretarisModel({
    required this.title,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'nama': nama,
    };
  }
}
