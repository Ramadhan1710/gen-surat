import 'dart:io';

import 'package:dio/dio.dart';

class BeritaAcaraPenyusunanPengurusIppnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tanggalPenyusunan;
  final String tempatPenyusunan;
  final String namaWilayah;
  final String hariPenyusunan;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final List<PengurusHarianModel> pengurusHarian;
  final List<PelindungModel> pelindung;
  final List<PembinaModel> pembina;
  final String namaKetua;
  final List<WakilKetuaModel> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisModel>? wakilSekre;
  final String namaBendahara;
  final String? namaWakilBend;
  final List<DepartemenModel> departemen;
  final List<LembagaModel> lembaga;

  BeritaAcaraPenyusunanPengurusIppnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.tanggalPenyusunan,
    required this.tempatPenyusunan,
    required this.namaWilayah,
    required this.hariPenyusunan,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.pengurusHarian,
    required this.pelindung,
    required this.pembina,
    required this.namaKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    this.wakilSekre,
    required this.namaBendahara,
    this.namaWakilBend,
    required this.departemen,
    required this.lembaga,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    // Convert pengurus harian to multipart
    final pengurusHarianList = <Map<String, dynamic>>[];
    for (var p in pengurusHarian) {
      pengurusHarianList.add(await p.toMultipartMap());
    }

    final map = <String, dynamic>{
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      "tanggal_penyusunan": tanggalPenyusunan,
      "tempat_penyusunan": tempatPenyusunan,
      "nama_wilayah": namaWilayah,
      "hari_penyusunan": hariPenyusunan,
      "tanggal_hijriah": tanggalHijriah,
      "tanggal_masehi": tanggalMasehi,
      "pengurus_harian": pengurusHarianList,
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
      "departemen": departemen.map((e) => e.toMap()).toList(),
      "lembaga": lembaga.map((e) => e.toMap()).toList(),
    };

    return map;
  }
}

class PengurusHarianModel {
  final String jabatan;
  final String nama;
  final File? ttd;

  PengurusHarianModel({
    required this.jabatan,
    required this.nama,
    this.ttd,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    final map = <String, dynamic>{
      'jabatan': jabatan,
      'nama': nama,
    };

    if (ttd != null) {
      map['ttd'] = await MultipartFile.fromFile(
        ttd!.path,
        filename: ttd!.path.split('/').last,
      );
    }

    return map;
  }
}

class PelindungModel {
  final String nama;

  PelindungModel({required this.nama});

  Map<String, dynamic> toMap() {
    return {'nama': nama};
  }
}

class PembinaModel {
  final int no;
  final String nama;

  PembinaModel({required this.no, required this.nama});

  Map<String, dynamic> toMap() {
    return {'no': no, 'nama': nama};
  }
}

class WakilKetuaModel {
  final String title;
  final String nama;

  WakilKetuaModel({required this.title, required this.nama});

  Map<String, dynamic> toMap() {
    return {'title': title, 'nama': nama};
  }
}

class WakilSekretarisModel {
  final String title;
  final String nama;

  WakilSekretarisModel({required this.title, required this.nama});

  Map<String, dynamic> toMap() {
    return {'title': title, 'nama': nama};
  }
}

class DepartemenModel {
  final String namaDepartemen;
  final String koordinator;
  final List<AnggotaDepartemenModel> anggota;

  DepartemenModel({
    required this.namaDepartemen,
    required this.koordinator,
    required this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama_departemen': namaDepartemen,
      'koordinator': koordinator,
      'anggota': anggota.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaDepartemenModel {
  final String nama;

  AnggotaDepartemenModel({required this.nama});

  Map<String, dynamic> toMap() {
    return {'nama': nama};
  }
}

class LembagaModel {
  final String nama;
  final String direktur;
  final String sekretaris;
  final List<AnggotaLembagaModel> anggota;

  LembagaModel({
    required this.nama,
    required this.direktur,
    required this.sekretaris,
    required this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'direktur': direktur,
      'sekretaris': sekretaris,
      'anggota': anggota.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaLembagaModel {
  final String nama;

  AnggotaLembagaModel({required this.nama});

  Map<String, dynamic> toMap() {
    return {'nama': nama};
  }
}
