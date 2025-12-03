import 'package:dio/dio.dart';

class BeritaAcaraRapatFormaturIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String tempatRapat;
  final String periodeRapta;
  final String namaWilayah;
  final String tanggalRapat;
  final List<TimFormaturIpnuModel> timFormatur;

  BeritaAcaraRapatFormaturIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.tempatRapat,
    required this.periodeRapta,
    required this.namaWilayah,
    required this.tanggalRapat,
    required this.timFormatur,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    final map = <String, dynamic>{
      'jenis_lembaga': jenisLembaga,
      'nama_lembaga': namaLembaga,
      'tanggal': tanggal,
      'bulan': bulan,
      'tahun': tahun,
      'tempat_rapat': tempatRapat,
      'periode_rapta': periodeRapta,
      'nama_wilayah': namaWilayah,
      'tanggal_rapat': tanggalRapat,
      'jenis_lembaga_upper': jenisLembaga.toUpperCase(),
      'jenis_lembaga_title': _toTitleCase(jenisLembaga),
      'nama_lembaga_upper': namaLembaga.toUpperCase(),
      'nama_lembaga_title': _toTitleCase(namaLembaga),
    };

    // Add tim formatur data
    final timFormaturList = <Map<String, dynamic>>[];
    for (int i = 0; i < timFormatur.length; i++) {
      final member = timFormatur[i];
      final memberMap = await member.toMultipartMap(i + 1);
      timFormaturList.add(memberMap);
    }
    map['tim_formatur'] = timFormaturList;

    // Add TTD files
    for (int i = 0; i < timFormatur.length; i++) {
      if (timFormatur[i].ttdPath != null) {
        map['ttd_${i + 1}'] = await MultipartFile.fromFile(
          timFormatur[i].ttdPath!,
          filename: timFormatur[i].ttdPath!.split('/').last,
        );
      }
    }

    return map;
  }

  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}

class TimFormaturIpnuModel {
  final String nama;
  final String jabatan;
  final String? ttdPath;

  TimFormaturIpnuModel({required this.nama, required this.jabatan, this.ttdPath});

  Future<Map<String, dynamic>> toMultipartMap(int index) async {
    return {'nama': nama, 'jabatan': jabatan, 'no': index.toString()};
  }
}
