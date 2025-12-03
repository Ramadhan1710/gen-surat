import 'package:dio/dio.dart';

class SertifikatKaderisasiIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String? sertifikatKaderisasiKetuaPath;
  final String? sertifikatKaderisasiSekretarisPath;
  final String? sertifikatKaderisasiBendaharaPath;

  SertifikatKaderisasiIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    this.sertifikatKaderisasiKetuaPath,
    this.sertifikatKaderisasiSekretarisPath,
    this.sertifikatKaderisasiBendaharaPath,
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
    if (sertifikatKaderisasiKetuaPath != null) {
      map['sertifikat_kaderisasi_ketua'] = await MultipartFile.fromFile(
        sertifikatKaderisasiKetuaPath!,
        filename: sertifikatKaderisasiKetuaPath!.split('/').last,
      );
    }

    if (sertifikatKaderisasiSekretarisPath != null) {
      map['sertifikat_kaderisasi_sekretaris'] = await MultipartFile.fromFile(
        sertifikatKaderisasiSekretarisPath!,
        filename: sertifikatKaderisasiSekretarisPath!.split('/').last,
      );
    }

    if (sertifikatKaderisasiBendaharaPath != null) {
      map['sertifikat_kaderisasi_bendahara'] = await MultipartFile.fromFile(
        sertifikatKaderisasiBendaharaPath!,
        filename: sertifikatKaderisasiBendaharaPath!.split('/').last,
      );
    }

    return map;
  }
}
