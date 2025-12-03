import 'package:dio/dio.dart';

class KartuIdentitasIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String? kartuIdentitasKetuaPath;
  final String? kartuIdentitasSekretarisPath;
  final String? kartuIdentitasBendaharaPath;

  KartuIdentitasIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    this.kartuIdentitasKetuaPath,
    this.kartuIdentitasSekretarisPath,
    this.kartuIdentitasBendaharaPath,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    final map = <String, dynamic>{
      'jenis_lembaga': jenisLembaga,
      'nama_lembaga': namaLembaga,
      'periode_kepengurusan': periodeKepengurusan,
      'jenis_lembaga_upper': jenisLembaga.toUpperCase(),
      'nama_lembaga_upper': namaLembaga.toUpperCase(),
    };

    // Add file uploads
    if (kartuIdentitasKetuaPath != null) {
      map['kartu_identitas_ketua'] = await MultipartFile.fromFile(
        kartuIdentitasKetuaPath!,
        filename: kartuIdentitasKetuaPath!.split('/').last,
      );
    }

    if (kartuIdentitasSekretarisPath != null) {
      map['kartu_identitas_sekretaris'] = await MultipartFile.fromFile(
        kartuIdentitasSekretarisPath!,
        filename: kartuIdentitasSekretarisPath!.split('/').last,
      );
    }

    if (kartuIdentitasBendaharaPath != null) {
      map['kartu_identitas_bendahara'] = await MultipartFile.fromFile(
        kartuIdentitasBendaharaPath!,
        filename: kartuIdentitasBendaharaPath!.split('/').last,
      );
    }

    return map;
  }
}
