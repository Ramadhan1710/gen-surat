import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/data/mappers/bersama/surat_undangan_bersama_mapper.dart';
import 'package:gen_surat/domain/entities/bersama/surat_undangan_bersama_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateSuratUndanganBersamaUsecase {
  final ISuratRepository repository;

  GenerateSuratUndanganBersamaUsecase(this.repository);

  Future<File> execute(
    SuratUndanganBersamaEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SuratUndanganBersamaMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      jenisSurat: AppConstants.lembagaBersama,
      typeSurat: TypeSuratConstants.suratUndanganBersama,
      endpoint: ApiConstants.suratUndangan,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SuratUndanganBersamaEntity entity) {
    if (entity.nomorSurat.isEmpty) {
      throw Exception('Nomor surat harus diisi');
    }

    if (entity.tujuanSurat.isEmpty) {
      throw Exception('Tujuan surat harus diisi');
    }

    if (entity.namaKegiatan.isEmpty) {
      throw Exception('Nama kegiatan harus diisi');
    }

    if (entity.hariTanggal.isEmpty) {
      throw Exception('Hari/tanggal harus diisi');
    }

    if (entity.waktu.isEmpty) {
      throw Exception('Waktu harus diisi');
    }

    if (entity.tempat.isEmpty) {
      throw Exception('Tempat harus diisi');
    }

    if (entity.tanggalHijriah.isEmpty) {
      throw Exception('Tanggal Hijriah harus diisi');
    }

    if (entity.tanggalMasehi.isEmpty) {
      throw Exception('Tanggal Masehi harus diisi');
    }
  }
}
